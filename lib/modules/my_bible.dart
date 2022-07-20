import '../helpers/bible_helper.dart' as BibleHelper;
import '../models/book_chapter.dart';
import '../providers/my_bible.dart';
import '../services/book_chapter.dart';

Future<MyBibleProvider> loadMyBible() async {
  MyBibleProvider myBibleVersion = new MyBibleProvider();
  await myBibleVersion.getMyBibleVersion();
  await myBibleVersion.getMyBibleLastVerse();
  await myBibleVersion.loadAllChapters();
  return myBibleVersion;
}

Future<String> getBookChapter(MyBibleProvider myBible) async {
  List<int> verses = BibleHelper.splitVerse(myBible.lastBibleVerse);
  int bookId = verses[2];
  var dbClient = BookChapterService();
  BookChapter bookChapter = await dbClient.getBookChapter(myBible.version, bookId);
  return bookChapter.bookName + ' ' + verses[1].toString();
}
