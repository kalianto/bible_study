import 'package:collection/collection.dart';

import '../helpers/date_helper.dart' as DateHelper;
import '../models/bible_view.dart';
import '../models/rhema.dart';
import '../services/rhema.dart';

/// getTodayRhema
Future<List<RhemaSummary>> getTodayRhema() async {
  DateTime date = new DateTime.now();
  DateTime yesterday = date.subtract(const Duration(days: 10));
  var todayDate = DateHelper.formatDate(yesterday, 'y-MM-dd');
  List<RhemaSummary> rhemaList = await getRhemaByDate(date);
  return rhemaList;
}

///
/// [date] must in yMMd format, i.e. 2000-01-01
///
Future<List<RhemaSummary>> getRhemaByDate(DateTime date) async {
  var dbClient = RhemaService();

  String strDate = DateHelper.formatDate(date, 'y-MM-dd');
  strDate = DateHelper.formatDate(date, 'y-MM-dd');
  List<Rhema> rhemaList = await dbClient.getRhemaByDate(strDate);
  List<Rhema> rhemaVerseList = await dbClient.getAllRhemaVerseList(rhemaList);
  Map<String, List<Rhema>> rhemaSummary = groupBy(rhemaVerseList, (Rhema object) => object.dateKey);
  List<RhemaSummary> list = [];
  rhemaSummary.forEach((summaryDate, rhemas) {
    RhemaSummary rhemaSummary = RhemaSummary(summaryDate: summaryDate, rhemas: rhemas);
    rhemaSummary.generateVerseSummary();
    list.add(rhemaSummary);
  });
  return list;
}

// Future<List<Rhema>> getAllRhema() async {
//   var dbClient = RhemaService();
//
//   List<Rhema> rhemaList = await dbClient.getAllRhemaList(limit: 10000);
//   return rhemaList;
// }

Future<List<RhemaSummary>> getAllRhemaSummary() async {
  var dbClient = RhemaService();

  List<Rhema> rhemaList = await dbClient.getRhemaSummary(10000);
  Map<String, List<Rhema>> rhemaSummary = groupBy(rhemaList, (Rhema object) => object.dateKey);
  List<RhemaSummary> list = [];
  rhemaSummary.forEach((summaryDate, rhemas) {
    RhemaSummary rhemaSummary = RhemaSummary(summaryDate: summaryDate, rhemas: rhemas);
    rhemaSummary.generateVerseSummary();
    list.add(rhemaSummary);
  });
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

Future<void> deleteRhema(List<Rhema> rhemas) async {
  var dbClient = RhemaService();
  for (Rhema rhema in rhemas) {
    await dbClient.deleteRhema(rhema.id);
  }
}
