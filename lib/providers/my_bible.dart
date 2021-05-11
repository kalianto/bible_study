import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_config.dart';


class MyBible with ChangeNotifier {
  MyBible({this.version, this.lastBibleVerse});

  int version;
  int lastBibleVerse;

  Future<void> getMyBibleVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final bibleVersion = AppConfig.bibleVersion;
    version = prefs.getInt(bibleVersion) ?? 1;
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
}

Future<MyBible> loadMyBible() async {
  MyBible myBibleVersion = new MyBible();
  await myBibleVersion.getMyBibleVersion();
  await myBibleVersion.getMyBibleLastVerse();
  return myBibleVersion;
}