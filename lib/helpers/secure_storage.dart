import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../app_config.dart';
import '../models/profile.dart';

class SecureStorage {
  final storage = new FlutterSecureStorage();

  final int DEFAULT_BIBLE_VERSION = 8;
  final int FIRST_VERSE = 1001001;

  // AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);

  final String _profileKey = AppConfig.profile;
  final String _bibleVersionKey = AppConfig.bibleVersion;
  final String _lastBibleVerseKey = AppConfig.lastBibleVerse;
  final String _isLoggedInKey = AppConfig.isLoggedIn;

  Future setProfile(Profile profile) async {
    String _profile = jsonEncode(profile.toJson());
    await storage.write(key: _profileKey, value: _profile);
  }

  Future setBibleVersion(int bibleVersion) async {
    await storage.write(key: _bibleVersionKey, value: bibleVersion.toString());
  }

  Future setLastBibleVerse(int lastBibleVerse) async {
    await storage.write(key: _lastBibleVerseKey, value: lastBibleVerse.toString());
  }

  Future setIsLoggedIn(bool isLoggedIn) async {
    String boolValue = isLoggedIn ? 'true' : false;
    await storage.write(key: _isLoggedInKey, value: boolValue);
  }

  Future<Profile> getProfile() async {
    String profileValue = await storage.read(key: _profileKey);
    Profile profile =
        profileValue == null ? new Profile() : Profile.fromJson(jsonDecode(profileValue));
    return profile;
  }

  Future<int> getBibleVersion() async {
    String bibleVersionValue = await storage.read(key: _bibleVersionKey);
    return bibleVersionValue != null ? int.parse(bibleVersionValue) : DEFAULT_BIBLE_VERSION;
  }

  Future<int> getLastBibleVerse() async {
    String lastBibleVerseValue = await storage.read(key: _lastBibleVerseKey);
    return lastBibleVerseValue != null ? int.parse(lastBibleVerseValue) : FIRST_VERSE;
  }

  Future<bool> getIsLoggedIn() async {
    String isLoggedInValue = await storage.read(key: _isLoggedInKey);
    return isLoggedInValue == 'true' ? true : false;
  }
}
