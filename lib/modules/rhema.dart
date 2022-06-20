import '../helpers/date_helper.dart' as DateHelper;
import '../models/rhema.dart';
import '../services/rhema.dart';

/// getTodayRhema
Future<List<Rhema>> getTodayRhema() async {
  // var dbClient = RhemaService();
  DateTime date = new DateTime.now();
  DateTime yesterday = date.subtract(const Duration(days: 10));
  var todayDate = DateHelper.formatDate(yesterday, 'y-MM-dd');
  // List<Rhema> rhemaList = await dbClient.getRhemaByDate(todayDate);
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
