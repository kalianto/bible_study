import 'daily_reading.dart';

class DailyReadingArguments {
  DailyReadingArguments({this.index, this.item, this.date, this.itemList});
  final DailyReading item;
  final DateTime date;
  final int index;
  final List<DailyReading> itemList;
}
