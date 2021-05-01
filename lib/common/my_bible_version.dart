import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_config.dart';


class MyBibleVersion with ChangeNotifier {
  MyBibleVersion({this.version});

  int version;

  Future<void> getMyBibleVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final key = AppConfig.bibleVersion;
    version = prefs.getInt(key) ?? 1;
    notifyListeners();
  }

  Future<void> saveMyBibleVersion(int bibleVersion) async {
    final prefs = await SharedPreferences.getInstance();
    final key = AppConfig.bibleVersion;
    prefs.setInt(key, bibleVersion);
    version = bibleVersion;
    notifyListeners();
  }
}

Future<MyBibleVersion> loadMyBibleVersion() async {
  MyBibleVersion bibleVersion = new MyBibleVersion();
  await bibleVersion.getMyBibleVersion();
  return bibleVersion;
}