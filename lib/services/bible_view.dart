import 'dart:async';
import '../database.dart';
import '../models/daily_reading.dart';
import '../models/bible_view.dart';
import '../services/bible_version.dart';
import '../models/bible_version.dart';
import '../helpers/bible_helper.dart' as BibleHelper;

class BibleViewProvider {
  final dbProvider = DatabaseService();
  final bibleVersionProvider = BibleVersionProvider();

  Future<List<BibleView>> getBibleView(DailyReading item, int bibleVersionId) async {
    var dbClient = await dbProvider.db;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);
    List<BibleView> bibleViewList = [];
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.id, a.b as bookNum, a.c as bookChapter, a.v as bookVerse, ' +
            'a.t as bookText, b.n as bookName ' +
            'from ${bibleVersion.table} a ' +
            'join ${bibleVersion.keyTable} b on b.b = a.b ' +
            'where ((a.b = ? and a.c = ?) OR (a.b = ? and a.c = ?))' +
            'order by a.id ASC',
        [item.sBookNum, item.sChapter, item.eBookNum, item.eChapter]);

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
              ));
    }

    return bibleViewList;
  }

  Future<List<BibleView>> getBibleContent({int bibleVersionId = 8, int verseStart}) async {
    var dbClient = await dbProvider.db;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);
    List<BibleView> bibleViewList = [];
    List<int> verses = BibleHelper.splitVerse(verseStart);
    verses.removeAt(0);
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.id, a.b as bookNum, a.c as bookChapter, a.v as bookVerse, ' +
            'a.t as bookText, b.n as bookName ' +
            'from ${bibleVersion.table} a ' +
            'join ${bibleVersion.keyTable} b on b.b = a.b ' +
            'where ((a.c = ? and a.b = ?))' +
            'order by a.id ASC',
        verses);

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
          ));
    }

    return bibleViewList;
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
}
