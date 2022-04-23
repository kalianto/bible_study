import 'package:flutter/material.dart';

import '../models/daily_reading.dart';
import '../services/daily_reading.dart';

class MyReadingItemProvider with ChangeNotifier {
  MyReadingItemProvider({this.date, this.bibleVersionId});

  DateTime date;
  int bibleVersionId;

  List<DailyReading> readingItemList = [];

  Future<void> getDailyReadingSummary() async {
    var dbClient = DailyReadingService();
    readingItemList = await dbClient.getDailyReading(date, bibleVersionId: bibleVersionId);
    notifyListeners();
  }

  String generateSummary() {
    return List.generate(readingItemList.length, (i) => readingItemList[i].shortSummary())
        .join('\n');
  }
}
