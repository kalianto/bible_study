import 'dart:async';

import '../../helpers/date_helper.dart' as DateHelper;
import '../database.dart';
import '../models/bible_version.dart';
import '../models/daily_reading.dart';
import '../services/bible_version.dart';

class DailyReadingService {
  final dbService = DatabaseService();
  final bibleVersionProvider = BibleVersionService();

  Future<List<DailyReading>> getDailyReading(DateTime date, {int bibleVersionId = 8}) async {
    var dbClient = await dbService.db;
    var dateId = DateHelper.formatDate(date, 'dMM');
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);

    List<DailyReading> dailyReadingList = [];
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'select a.id, a.start as sId, a.end as eId, '
        'd.n as sBookName, b.b as sBookNum, b.c as sChapter , b.v as sVerse, '
        'b.t as sVerseSummary, e.n as eBookName, c.b as eBookNum, c.c as eChapter, '
        'c.v as eVerse, a.date as dateId, a.orderBy, a.groupId '
        'from daily_reading a '
        'join ${bibleVersion.table} b on a.start = b.id '
        'join ${bibleVersion.table} c on a.end = c.id '
        'join ${bibleVersion.keyTable} d on b.b = d.b '
        'join ${bibleVersion.keyTable} e on c.b = e.b '
        'where a.date = ?',
        [dateId]);
    if (res.length > 0) {
      dailyReadingList = List.generate(
          res.length,
          (i) => DailyReading(
                dateId: res[i]["dateId"],
                sId: res[i]["sId"],
                sBookName: res[i]["sBookName"],
                sBookNum: res[i]["sBookNum"],
                sChapter: res[i]["sChapter"],
                sVerse: res[i]["sVerse"],
                sVerseSummary: res[i]["sVerseSummary"].replaceAll(new RegExp(r'\\'), ''),
                eId: res[i]["eId"],
                eBookName: res[i]["eBookName"],
                eBookNum: res[i]["eBookNum"],
                eChapter: res[i]["eChapter"],
                eVerse: res[i]["eVerse"],
                groupId: res[i]["groupId"],
                orderBy: res[i]["orderBy"],
                bibleVersion: bibleVersion.table,
                bibleCode: bibleVersion.abbreviation,
                id: res[i]["id"],
              ));
    }

    return dailyReadingList;
  }

  Future<DailyReading> getDailyReadingItemById(int id, {int bibleVersionId = 8}) async {
    var dbClient = await dbService.db;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);

    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'select a.id, a.start as sId, a.end as eId, '
        'd.n as sBookName, b.b as sBookNum, b.c as sChapter , b.v as sVerse, '
        'b.t as sVerseSummary, e.n as eBookName, c.b as eBookNum, c.c as eChapter, '
        'c.v as eVerse, a.date as dateId, a.orderBy, a.groupId '
        'from daily_reading a '
        'join ${bibleVersion.table} b on a.start = b.id '
        'join ${bibleVersion.table} c on a.end = c.id '
        'join ${bibleVersion.keyTable} d on b.b = d.b '
        'join ${bibleVersion.keyTable} e on c.b = e.b '
        'where a.id = ?',
        [id]);

    DailyReading dailyReading;

    if (res.length > 0) {
      dailyReading = DailyReading(
        dateId: res[0]["dateId"],
        sId: res[0]["sId"],
        sBookName: res[0]["sBookName"],
        sBookNum: res[0]["sBookNum"],
        sChapter: res[0]["sChapter"],
        sVerse: res[0]["sVerse"],
        sVerseSummary: res[0]["sVerseSummary"].replaceAll(new RegExp(r'\\'), ''),
        eId: res[0]["eId"],
        eBookName: res[0]["eBookName"],
        eBookNum: res[0]["eBookNum"],
        eChapter: res[0]["eChapter"],
        eVerse: res[0]["eVerse"],
        groupId: res[0]["groupId"],
        orderBy: res[0]["orderBy"],
        bibleVersion: bibleVersion.table,
        bibleCode: bibleVersion.abbreviation,
        id: res[0]["id"],
      );
    }

    return dailyReading;
  }
}
