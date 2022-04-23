import '../models/daily_reading.dart';
import '../services/daily_reading.dart';

Future<List<DailyReading>> getDailyReadingSummary(DateTime date, int bibleVersionId) async {
  var dbClient = DailyReadingService();
  List<DailyReading> dailyReadingList =
      await dbClient.getDailyReading(date, bibleVersionId: bibleVersionId);
  return dailyReadingList;
}

Future<DailyReading> getDailyReadingItemById(int id, int bibleVersionId) async {
  var dbClient = DailyReadingService();
  DailyReading dailyReading =
      await dbClient.getDailyReadingItemById(id, bibleVersionId: bibleVersionId);
  return dailyReading;
}
