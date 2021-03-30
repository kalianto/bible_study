import 'dart:async';
import '../database.dart';
import '../models/bible_view.dart';
import '../models/daily_reading.dart';

class BibleViewProvider {
  final dbProvider = DatabaseProvider();

  Future<List<BibleView>> getBibleView(DailyReading item, String bibleVersion) async {
    var dbClient = await dbProvider.db;
    List<BibleView> bibleViewList = new List();
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.id, a.b as bookNum, a.c as bookChapter, a.v as bookVerse, ' +
            'a.t as bookText, b.n as bookName ' +
            'from t_asv a ' +
            'join key_english b on b.b = a.b ' +
            'where ((a.b = ? and a.c = ?) OR (a.b = ? and a.c = ?))',
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
                bibleVersion: bibleVersion,
                bookText: res[k]["bookText"],
              ));

    }

    return bibleViewList;
  }
}
