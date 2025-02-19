import '../models/daily_reading.dart';

class BibleEntry {
  final String sBookName;
  final int sBookNum;
  final int sChapter;
  final String eBookName;
  final int eBookNum;
  final int eChapter;

  BibleEntry({required this.sBookName, required this.sBookNum, required this.sChapter, required this.eBookName, required this.eBookNum, required this.eChapter});

  factory BibleEntry.fromReadingItem(DailyReading item) {
    return BibleEntry(
      sBookName: item.sBookName,
      sBookNum: item.sBookNum,
      sChapter: item.sChapter,
      eBookName: item.eBookName,
      eBookNum: item.eBookNum,
      eChapter: item.eChapter,
    );
  }
}
