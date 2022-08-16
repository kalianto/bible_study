import 'package:collection/collection.dart';

import '../helpers/date_helper.dart' as DateHelper;
import '../models/bible_view.dart';
import '../models/rhema.dart';
import '../services/rhema.dart';

/// getTodayRhema
Future<List<Rhema>> getTodayRhema() async {
  DateTime date = new DateTime.now();
  DateTime yesterday = date.subtract(const Duration(days: 10));
  var todayDate = DateHelper.formatDate(yesterday, 'y-MM-dd');
  List<Rhema> rhemaList = await getRhemaByDate(todayDate);
  return rhemaList;
}

///
/// [date] must in yMMd format, i.e. 2000-01-01
///
Future<List<Rhema>> getRhemaByDate(String date) async {
  var dbClient = RhemaService();

  List<Rhema> rhemaList = await dbClient.getRhemaByDate(date);
  return rhemaList;
}

Future<List<Rhema>> getAllRhema() async {
  var dbClient = RhemaService();

  List<Rhema> rhemaList = await dbClient.getAllRhema(limit: 10);
  return rhemaList;
}

Future<List<RhemaSummary>> getAllRhemaSummary() async {
  var dbClient = RhemaService();

  List<Rhema> rhemaList = await dbClient.getAllRhema(limit: 10);
  Map<String, List<Rhema>> rhemaSummary = groupBy(rhemaList, (Rhema object) => object.dateKey);
  List<RhemaSummary> list = [];
  rhemaSummary.forEach(
      (summaryDate, rhemas) => list.add(RhemaSummary(summaryDate: summaryDate, rhemas: rhemas)));
  print(list);
  return list;
}

Future<Rhema> addRhema(DateTime rhemaDate, String rhemaText, List<BibleView> bibleViewList) async {
  var dbClient = RhemaService();
  int bibleVersionId = bibleViewList[0].bibleVersionId;

  Rhema rhema = new Rhema(
    rhemaDate: rhemaDate,
    rhemaText: rhemaText,
    bibleVersionId: bibleVersionId,
  );

  await dbClient.insertRhema(rhema, bibleViewList);

  return rhema;
}

Future<void> deleteRhema(int rhemaId) async {
  var dbClient = RhemaService();
  await dbClient.deleteRhema(rhemaId);
}
