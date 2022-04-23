import '../models/bible_view.dart';
import '../models/daily_reading.dart';
import '../providers/my_bible.dart';
import '../services/bible_view.dart';

Future<List<BibleView>> getBookContent(MyBibleProvider myBible) async {
  var dbClient = BibleViewService();
  List<BibleView> bibleViewList = await dbClient.getBibleContent(
      bibleVersionId: myBible.version, verseStart: myBible.lastBibleVerse);
  return bibleViewList;
}

Future<List<BibleView>> getBibleViewContent(DailyReading dailyReading, int bibleVersion) async {
  var dbClient = BibleViewService();
  List<BibleView> bibleViewList = await dbClient.getBibleView(dailyReading, bibleVersion);
  return bibleViewList;
}
