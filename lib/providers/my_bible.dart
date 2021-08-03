import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_config.dart';


class MyBible with ChangeNotifier {
  MyBible({this.version, this.lastBibleVerse});

  int version;
  int lastBibleVerse;
  String bookChapter;
  int DEFAULT_BIBLE_VERSION = 8; // TB

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
    notifyListeners();
  }

  Future<void> getMyBibleLastVerse() async {
    final prefs = await SharedPreferences.getInstance();
    final lastBibleVerseKey = AppConfig.lastBibleVerse;
    lastBibleVerse = prefs.getInt(lastBibleVerseKey) ?? 1001001;
    notifyListeners();
  }

  Future<void> saveMyBibleLastVerse(int lastVerse) async {
    final prefs = await SharedPreferences.getInstance();
    final key = AppConfig.lastBibleVerse;
    prefs.setInt(key, lastVerse);
    lastBibleVerse = lastVerse;
    notifyListeners();
  }

  void updateBookChapterText(String value) {
    bookChapter = value;
    notifyListeners();
  }

  String getBookChapterText() {
    Map<String, dynamic> bookChapterObject = jsonDecode(bookChapter);
    return bookChapterObject['bookName'] + ' ' + bookChapterObject['chapterStart'].toString();
  }

  int formatBibleId(int book, int chapter, int verse) {
    return int.parse(
      book.toString() +
      chapter.toString().padLeft(3, '0') +
      '001'
    );
  }
}

Future<MyBible> loadMyBible() async {
  MyBible myBibleVersion = new MyBible();
  await myBibleVersion.getMyBibleVersion();
  await myBibleVersion.getMyBibleLastVerse();
  return myBibleVersion;
}