import 'package:intl/intl.dart';

String formatDate(DateTime date, [String dateFormat = 'dd MMM yyyy']) {
  return DateFormat(dateFormat).format(date);
}

String formatDateSQLite(DateTime date) {
  return formatDate(date, 'yyyy-MM-dd HH:mm:ss');
}

DateTime getDateFromDateId(int dateId) {
  String thisYear = new DateTime.now().year.toString();
  String d = dateId.toString();
  String month = d.substring(d.length - 2, d.length);
  String date = d.substring(0, d.length - 2).padLeft(2, '0');
  return DateTime.parse(thisYear + '-' + month + '-' + date);
}
