import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_config.dart';
import '../helpers/bible_helper.dart' as BibleHelper;
import '../services/my_bible.dart';

const int DEFAULT_BIBLE_VERSION = 8; // TB

class MyBibleProvider with ChangeNotifier {
  MyBibleProvider({this.version, this.lastBibleVerse});

  int version;
  int lastBibleVerse;
  String bookChapter;
  Map<String, int> lastBibleVerseArray;
  List<int> allBibleChapters;

  Future<void> getMyBibleVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final bibleVersion = AppConfig.bibleVersion;
    version = prefs.getInt(bibleVersion) ?? DEFAULT_BIBLE_VERSION;
    notifyListeners();
  }

  Future<void> saveMyBibleVersion(int bibleVersion) async {
    final prefs = await SharedPreferences.getInstance();
    final key = AppConfig.bibleVersion;
    prefs.setInt(key, bibleVersion);
    version = bibleVersion;
    await loadAllChapters();
    notifyListeners();
  }

  Future<void> getMyBibleLastVerse() async {
    final prefs = await SharedPreferences.getInstance();
    final lastBibleVerseKey = AppConfig.lastBibleVerse;
    lastBibleVerse = prefs.getInt(lastBibleVerseKey) ?? 1001001;
    updateLastBibleVerseArray(lastBibleVerse);
    notifyListeners();
  }

  Future<void> saveMyBibleLastVerse(int lastVerse) async {
    final prefs = await SharedPreferences.getInstance();
    final key = AppConfig.lastBibleVerse;
    prefs.setInt(key, lastVerse);
    lastBibleVerse = lastVerse;
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
