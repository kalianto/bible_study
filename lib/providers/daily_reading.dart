import 'dart:async';
import 'package:intl/intl.dart';
import '../database.dart';
import '../models/daily_reading.dart';

class DailyReadingProvider {
  final dbProvider = DatabaseProvider();

  Future<List<DailyReading>> getDailyReading(DateTime date) async {
    var dbClient = await dbProvider.db;
    var dateId = DateFormat('dMM').format(date);
    List<DailyReading> dailyReadingList = new List();
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'select a.start as sId, a.end as eId, ' +
            'd.n as sBookName, b.b as sBookNum, b.c as sChapter , b.v as sVerse, ' +
            'b.t as sVerseSummary, e.n as eBookName, c.b as eBookNum, c.c as eChapter, ' +
            'c.v as eVerse, a.date as dateId, a.orderBy, a.groupId ' +
            'from daily_reading a ' +
            'join t_asv b on a.start = b.id ' +
            'join t_asv c on a.end = c.id ' +
            'join key_english d on b.b = d.b ' +
            'join key_english e on c.b = e.b ' +
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
                  orderBy: res[i]["orderBy"]));
    }

    return dailyReadingList;
  }
}
