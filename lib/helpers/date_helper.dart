import 'package:intl/intl.dart';

String formatDate(DateTime date, [String dateFormat = 'dd MMM yyyy']) {
  return DateFormat(dateFormat).format(date);
}

