import 'dart:async';

import '../database.dart';
import '../models/bible_version.dart';
import '../models/book_chapter.dart';
import '../services/bible_version.dart';

class BookChapterService {
  final dbService = DatabaseService();
  final bibleVersionProvider = BibleVersionService();

  Future<List<BookChapter>> getAllBookChapters(int bibleVersionId) async {
    var dbClient = await dbService.db;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);
    List<BookChapter> bookChapterList = [];
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
      'SELECT a.b as bookId, MIN(a.c) as chapterStart, '
      'MAX(a.c) as chapterEnd,  b.n as bookName '
      'from ${bibleVersion.table} a '
      'join ${bibleVersion.keyTable} b on b.b = a.b '
      'GROUP BY a.b',
    );

    if (res.length > 0) {
      bookChapterList = List.generate(res.length, (index) => BookChapter.fromMapEntry(res[index]));
    }

    return bookChapterList;
  }

  Future<BookChapter> getBookChapter(int bibleVersionId, int bookId) async {
    var dbClient = await dbService.db;
    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);
    BookChapter bookChapter;
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
      'SELECT a.b as bookId, MIN(a.c) as chapterStart, '
      'MAX(a.c) as chapterEnd,  b.n as bookName '
      'from ${bibleVersion.table} a '
      'join ${bibleVersion.keyTable} b on b.b = a.b '
      'where a.b = ? '
      'GROUP BY a.b',
      [bookId],
    );

    if (res.length > 0) {
      bookChapter = BookChapter.fromMapEntry(res[0]);
    }

    return bookChapter;
  }
}
