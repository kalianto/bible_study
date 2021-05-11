import 'package:flutter/material.dart';
import '../models/daily_reading.dart';
import '../services/daily_reading.dart';

class MyReadingItem with ChangeNotifier {
  MyReadingItem({ this.date, this.bibleVersionId }) ;
  DateTime date;
  int bibleVersionId;

  List<DailyReading> readingItemList = [];

  Future<void> getDailyReadingSummary() async {
    var dbClient = DailyReadingProvider();
    readingItemList =
    await dbClient.getDailyReading(date, bibleVersionId: bibleVersionId);
    notifyListeners();
  }
}

Future<MyReadingItem> loadDailyReadingItem() async {
  MyReadingItem readingItem = MyReadingItem();
  await readingItem.getDailyReadingSummary();
  return readingItem;
}
