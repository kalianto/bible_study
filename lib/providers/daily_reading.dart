import 'dart:async';
import 'package:intl/intl.dart';
import '../database.dart';
import '../models/daily_reading.dart';
import '../providers/bible_version.dart';
import '../models/bible_version.dart';

class DailyReadingProvider {
  final dbProvider = DatabaseProvider();
  final bibleVersionProvider = BibleVersionProvider();

  Future<List<DailyReading>> getDailyReading(DateTime date, {int bibleVersionId = 8}) async {
    var dbClient = await dbProvider.db;
    var dateId = DateFormat('dMM').format(date);
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);

    List<DailyReading> dailyReadingList = [];
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'select a.start as sId, a.end as eId, ' +
            'd.n as sBookName, b.b as sBookNum, b.c as sChapter , b.v as sVerse, ' +
            'b.t as sVerseSummary, e.n as eBookName, c.b as eBookNum, c.c as eChapter, ' +
            'c.v as eVerse, a.date as dateId, a.orderBy, a.groupId ' +
            'from daily_reading a ' +
            'join ${bibleVersion.table} b on a.start = b.id ' +
            'join ${bibleVersion.table} c on a.end = c.id ' +
            'join ${bibleVersion.keyTable} d on b.b = d.b ' +
            'join ${bibleVersion.keyTable} e on c.b = e.b ' +
            'where a.date = ?',
        [dateId]);
    if (res.length > 0) {
      dailyReadingList = List.generate(
          res.length,
              (i) =>
              DailyReading(
                  dateId: res[i]["dateId"],
                  sId: res[i]["sId"],
                  sBookName: res[i]["sBookName"],
                  sBookNum: res[i]["sBookNum"],
                  sChapter: res[i]["sChapter"],
                  sVerse: res[i]["sVerse"],
                  sVerseSummary: res[i]["sVerseSummary"],
                  eId: res[i]["eId"],
                  eBookName: res[i]["eBookName"],
                  eBookNum: res[i]["eBookNum"],
                  eChapter: res[i]["eChapter"],
                  eVerse: res[i]["eVerse"],
                  groupId: res[i]["groupId"],
                  orderBy: res[i]["orderBy"],
                  bibleVersion: bibleVersion.table,
                  bibleCode: bibleVersion.abbreviation,
              ));
    }

    return dailyReadingList;
  }
}
