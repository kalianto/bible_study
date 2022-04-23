import 'package:flutter/material.dart';

import '../../helpers/date_helper.dart' as DateHelper;
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

Future<MyReadingItemProvider> loadDailyReadingItem(DateTime date, int bibleVersionId) async {
  MyReadingItemProvider readingItem =
      MyReadingItemProvider(date: date, bibleVersionId: bibleVersionId);
  await readingItem.getDailyReadingSummary();
  return readingItem;
}

Future<String> loadDailyReadingSummaryFull(DateTime date) async {
  MyReadingItemProvider readingItem1 = MyReadingItemProvider(date: date, bibleVersionId: 8);
  await readingItem1.getDailyReadingSummary();
  String summary1 = readingItem1.generateSummary();

  MyReadingItemProvider readingItem2 = MyReadingItemProvider(date: date, bibleVersionId: 4);
  await readingItem2.getDailyReadingSummary();
  String summary2 = readingItem2.generateSummary();

  return '*Read the whole Bible in a year*' +
      '\n' +
      'Complete READING LIST is on https://www.gbimssydney.org.au/gema' +
      '\n\n' +
      '*' +
      DateHelper.formatDate(date, 'yMMMMd') +
      '*\n\n' +
      summary2 +
      '\n\n' +
      '*Let\'s build our intimate relationship with the Author of our life by reading ' +
      'and meditating His words and applying those words in our life*' +
      '\n\n' +
      'GEMA *' +
      DateHelper.formatDate(date, 'dd-MM-yyyy') +
      '*\n\n' +
      summary1 +
      '\n\n' +
      '*Tuhan Yesus memberkati*';
}
