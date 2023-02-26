import 'dart:async';

import '../database.dart';
import '../helpers/bible_helper.dart' as BibleHelper;
import '../models/bible_version.dart';
import '../models/bible_view.dart';
import '../models/daily_reading.dart';
import '../services/bible_version.dart';

class BibleViewService {
  final dbService = DatabaseService();
  final bibleVersionProvider = BibleVersionService();

  Future<List<BibleView>> getBibleView(DailyReading item, int bibleVersionId) async {
    var dbClient = await dbService.db;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);
    List<BibleView> bibleViewList = [];

    /// Get start and end of bible verse from reading item
    int lastVerse = await getMaxChapterVerse(bibleVersion, item.eBookNum, item.eChapter);
    int lastReadingItem = BibleHelper.formatBibleId(item.eBookNum, item.eChapter, lastVerse);
    int firstReadingItem = BibleHelper.formatBibleId(item.sBookNum, item.sChapter, 1);
    List<Map<String, dynamic>> result = await dbClient.rawQuery(
      'SELECT a.id, a.b as bookNum, a.c as bookChapter, a.v as bookVerse, '
      'a.t as bookText, b.n as bookName '
      'from ${bibleVersion.table} a '
      'join ${bibleVersion.keyTable} b on b.b = a.b '
      // 'where ((a.b = ? and a.c = ?) OR (a.b = ? and a.c = ?))' +
      'where id between ? AND ? '
      'order by a.id ASC',
      //[item.sBookNum, item.sChapter, item.eBookNum, item.eChapter]);
      [firstReadingItem, lastReadingItem],
    );

    if (result.length > 0) {
      bibleViewList = List.generate(
        result.length,
        (k) => BibleView(
          id: result[k]["id"],
          bookName: result[k]["bookName"],
          bookNum: result[k]["bookNum"],
          bookChapter: result[k]["bookChapter"],
          bookVerse: result[k]["bookVerse"],
          bibleVersion: bibleVersion.table,
          bibleCode: bibleVersion.abbreviation,
          bookText: BibleHelper.parseText(result[k]["bookText"]),
          bibleVersionId: bibleVersionId,
        ),
      );
    }

    return bibleViewList;
  }

  Future<List<BibleView>> getDailyReadingContent(DailyReading item, int bibleVersionId) async {
    var dbClient = await dbService.db;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);
    List<BibleView> bibleViewList = [];

    /// Get start and end of bible verse from reading item
    List<Map<String, dynamic>> result = await dbClient.rawQuery(
      'SELECT a.id, a.b as bookNum, a.c as bookChapter, a.v as bookVerse, '
      'a.t as bookText, b.n as bookName '
      'from ${bibleVersion.table} a '
      'join ${bibleVersion.keyTable} b on b.b = a.b '
      'where id between ? AND ? '
      'order by a.id ASC',
      [item.sId, item.eId],
    );

    if (result.length > 0) {
      List<Map<String, dynamic>> filteredResult = [];

      /// do a filter of psalms and proverbs for 28 Aug
      if (item.sBookNum != 19 && item.sBookNum != 20) {
        try {
          result.forEach((res) {
            if (res['bookNum'] != 19 && res['bookNum'] != 20) {
              filteredResult.add(res);
            }
          });
        } catch (error) {
          print(error);
        }
      } else {
        filteredResult = result;
      }

      bibleViewList = List.generate(
        filteredResult.length,
        (k) => BibleView(
          id: filteredResult[k]["id"],
          bookName: filteredResult[k]["bookName"],
          bookNum: filteredResult[k]["bookNum"],
          bookChapter: filteredResult[k]["bookChapter"],
          bookVerse: filteredResult[k]["bookVerse"],
          bibleVersion: bibleVersion.table,
          bibleCode: bibleVersion.abbreviation,
          bookText: BibleHelper.parseText(filteredResult[k]["bookText"]),
          bibleVersionId: bibleVersionId,
        ),
      );
    }

    return bibleViewList;
  }

  Future<List<BibleView>> getBibleContent({int bibleVersionId = 8, int verseStart}) async {
    var dbClient = await dbService.db;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);
    List<BibleView> bibleViewList = [];
    List<int> verses = BibleHelper.splitVerse(verseStart);
    verses.removeAt(0);
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
      'SELECT a.id, a.b as bookNum, a.c as bookChapter, a.v as bookVerse, '
      'a.t as bookText, b.n as bookName '
      'from ${bibleVersion.table} a '
      'join ${bibleVersion.keyTable} b on b.b = a.b '
      'where ((a.c = ? and a.b = ?))'
      'order by a.id ASC',
      verses,
    );

    if (res.length > 0) {
      bibleViewList = List.generate(
        res.length,
        (k) => BibleView(
          id: res[k]["id"],
          bookName: res[k]["bookName"],
          bookNum: res[k]["bookNum"],
          bookChapter: res[k]["bookChapter"],
          bookVerse: res[k]["bookVerse"],
          bibleVersion: bibleVersion.table,
          bibleCode: bibleVersion.abbreviation,
          bookText: BibleHelper.parseText(res[k]["bookText"]),
          bibleVersionId: bibleVersionId,
        ),
      );
    }

    return bibleViewList;
  }

  Future<int> getMaxChapterVerse(BibleVersion bibleVersion, int book, int chapter) async {
    var dbClient = await dbService.db;
    List<Map<String, dynamic>> res = await dbClient.rawQuery('SELECT MAX(v) as lastVerse from  ${bibleVersion.table} a where b = ? and c = ?', [book, chapter]);

    int lastVerse = 0;
    if (res.length > 0) {
      lastVerse = res[0]['lastVerse'];
    }

    return lastVerse;
  }

  // String parseText(String text) {
  //   return text.replaceAll(new RegExp(r"\\"), "");
  // }

  // List<int> splitVerse(int verse) {
  //   String verses = verse.toString();
  //   List<int> verseList = [];
  //   verseList.add(int.parse(verses.substring(verses.length - 3)));
  //   verseList.add(int.parse(verses.substring(verses.length - 6, verses.length - 3)));
  //   verseList.add(int.parse(verses.substring(0, verses.length - 6)));
  //   return verseList;
  // }

  Future<BibleView> getBibleViewById(int bibleVersionId, int bibleViewId) async {
    var dbClient = await dbService.db;
    BibleView bibleView;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
      'SELECT a.id, a.b as bookNum, a.c as bookChapter, a.v as bookVerse, '
      'a.t as bookText, b.n as bookName '
      'from ${bibleVersion.table} a '
      'join ${bibleVersion.keyTable} b on b.b = a.b '
      'where a.id = ? ',
      [bibleViewId],
    );

    if (res.length > 0) {
      bibleView = BibleView(
        id: res[0]["id"],
        bookName: res[0]["bookName"],
        bookNum: res[0]["bookNum"],
        bookChapter: res[0]["bookChapter"],
        bookVerse: res[0]["bookVerse"],
        bibleVersion: bibleVersion.table,
        bibleCode: bibleVersion.abbreviation,
        bookText: BibleHelper.parseText(res[0]["bookText"]),
        bibleVersionId: bibleVersionId,
      );
    }

    return bibleView;
  }
}
