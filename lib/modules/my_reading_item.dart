import '../helpers/date_helper.dart' as DateHelper;
import '../providers/my_reading_item.dart';

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
