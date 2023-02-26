import 'dart:convert';

import 'package:flutter/material.dart';

import '../helpers/bible_helper.dart' as BibleHelper;
import '../helpers/secure_storage.dart';
import '../services/my_bible.dart';

class MyBibleProvider with ChangeNotifier {
  MyBibleProvider({this.version, this.lastBibleVerse});

  final secureStorage = SecureStorage();

  int version;
  int lastBibleVerse;
  String bookChapter;
  Map<String, int> lastBibleVerseArray;
  List<int> allBibleChapters;

  Future<void> getMyBibleVersion() async {
    version = await secureStorage.getBibleVersion();
    notifyListeners();
  }

  Future<void> saveMyBibleVersion(int bibleVersion) async {
    version = bibleVersion;
    await secureStorage.setBibleVersion(bibleVersion);
    await loadAllChapters();
    notifyListeners();
  }

  Future<void> getMyBibleLastVerse() async {
    lastBibleVerse = await secureStorage.getLastBibleVerse();
    updateLastBibleVerseArray(lastBibleVerse);
    notifyListeners();
  }

  Future<void> saveMyBibleLastVerse(int lastVerse) async {
    lastBibleVerse = lastVerse;
    await secureStorage.setLastBibleVerse(lastBibleVerse);
    updateLastBibleVerseArray(lastBibleVerse);
    notifyListeners();
  }

  Future<void> loadAllChapters() async {
    MyBibleService myBibleService = new MyBibleService();
    allBibleChapters = await myBibleService.getAllBibleChapters(bibleVersionId: version);
    notifyListeners();
  }

  void goToPreviousVerse() {
    List<int> bibleVerse = BibleHelper.splitVerse(lastBibleVerse);
    int currentBibleVerse = BibleHelper.formatBookChapter(bibleVerse[2], bibleVerse[1]);
    int current = allBibleChapters.indexWhere((element) => element == currentBibleVerse);
    int prev = current - 1;
    if (prev > 0) {
      int prevElement = int.parse(allBibleChapters.elementAt(prev).toString() + '001');
      saveMyBibleLastVerse(prevElement);
      // lastBibleVerse = prevElement;
      // notifyListeners();
    }
  }

  void goToNextVerse() {
    List<int> bibleVerse = BibleHelper.splitVerse(lastBibleVerse);
    int currentBibleVerse = BibleHelper.formatBookChapter(bibleVerse[2], bibleVerse[1]);
    int current = allBibleChapters.indexWhere((element) => element == currentBibleVerse);
    int next = current + 1;
    if (next < allBibleChapters.length) {
      int nextElement = int.parse(allBibleChapters.elementAt(next).toString() + '001');
      saveMyBibleLastVerse(nextElement);
      // lastBibleVerse = nextElement;
      // notifyListeners();
    }
  }

  void updateLastBibleVerseArray(int value) {
    List<int> array = BibleHelper.splitVerse(value);
    lastBibleVerseArray = {
      'verse': array[0],
      'chapter': array[1],
      'book': array[2],
    };
    // notifyListeners();
  }

  void updateBookChapterText(String value) {
    bookChapter = value;
    notifyListeners();
  }

  String getBookChapterText() {
    Map<String, dynamic> bookChapterObject = jsonDecode(bookChapter);
    return bookChapterObject['bookName'] + ' ' + bookChapterObject['chapterStart'].toString();
  }

  // int formatBibleId(int book, int chapter, int verse) {
  //   return int.parse(
  //     book.toString() +
  //     chapter.toString().padLeft(3, '0') +
  //     '001'
  //   );
  // }
}
