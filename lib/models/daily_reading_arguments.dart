import 'daily_reading.dart';

class DailyReadingArguments {
  DailyReadingArguments({required this.index, required this.item, required this.date, required this.itemList});
  final DailyReading item;
  final DateTime date;
  final int index;
  final List<DailyReading> itemList;
}
