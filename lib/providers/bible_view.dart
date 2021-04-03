import 'dart:async';
import '../database.dart';
import '../models/daily_reading.dart';
import '../models/bible_view.dart';
import '../providers/bible_version.dart';
import '../models/bible_version.dart';

class BibleViewProvider {
  final dbProvider = DatabaseProvider();
  final bibleVersionProvider = BibleVersionProvider();

  Future<List<BibleView>> getBibleView(DailyReading item, int bibleVersionId) async {
    var dbClient = await dbProvider.db;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);
    List<BibleView> bibleViewList = new List();
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
                bookText: res[k]["bookText"],
              ));

    }

    return bibleViewList;
  }
}
