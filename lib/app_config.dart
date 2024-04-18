class AppConfig {
  AppConfig._();

  static final AppConfig instance = AppConfig._();

  static const String appName = 'GEMA';
  static const String appDescription = 'Gerakan Membaca Alkitab Setahun';
  static const String isLoggedIn = '_loggedIn';
  static const String profile = '_profile';
  static const String dbFile = 'gema.db';
  static const String bibleVersion = 'bible_version';
  static const String lastBibleVerse = 'lastBibleVerse';

  static const int dbVersion = 2;
}
