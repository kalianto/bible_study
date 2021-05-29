class AppConfig {
  AppConfig._();

  static final AppConfig instance = AppConfig._();

  static const String isLoggedIn = '_loggedIn';
  static const String profile = '_profile';
  static const String dbFile = 'bible_study.db';
  static const String bibleVersion = 'bible_version';
  static const String lastBibleVerse = 'lastBibleVerse';
}
