import '../models/book_chapter.dart';
import '../services/book_chapter.dart';

Future<List<BookChapter>> getAllBookChapters(int bibleVersion) async {
  var dbClient = BookChapterService();
  List<BookChapter> bookChapterList = await dbClient.getAllBookChapters(bibleVersion);
  return bookChapterList;
}
