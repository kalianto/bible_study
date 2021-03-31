import 'dart:async';
import '../database.dart';
import '../models/bible_version.dart';

class BibleVersionProvider {
  final dbProvider = DatabaseProvider();

  Future<BibleVersion> getBibleVersion(int bibleVersionId) async {
    var dbClient = await dbProvider.db;
    BibleVersion bibleVersion;
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.id, a."table", a.abbreviation, a.language, a.version, a.info_text, ' +
            'a.info_url, a.publisher, a.copyright, a.copyright_info ' +
            'from bible_version_key a ' +
            'where a.id = ?',
        [bibleVersionId]);

    if (res.length > 0) {
      bibleVersion = BibleVersion(
        id: res[0]["id"],
        table: res[0]["table"],
        abbreviation: res[0]["abbreviation"],
        language: res[0]["language"],
        version: res[0]["version"],
        infoText: res[0]["info_text"],
        infoUrl: res[0]["info_url"],
        publisher: res[0]["publisher"],
        copyright: res[0]["copyright"],
        copyrightInfo: res[0]["copyright_info"],
        keyTable: 'key_' + res[0]["language"],
      );
    }

    return bibleVersion;
  }

  Future<List<BibleVersion>> getAllBibleVersion() async {
    var dbClient = await dbProvider.db;
    List<BibleVersion> bibleVersionList = new List();
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.id, a."table", a.abbreviation, a.language, a.version, a.info_text, ' +
            'a.info_url, a.publisher, a.copyright, a.copyright_info ' +
            'from bible_version_key a ');

    if (res.length > 0) {
      bibleVersionList = List.generate(
          res.length,
          (k) => BibleVersion(
                id: res[k]["id"],
                table: res[k]["table"],
                abbreviation: res[k]["abbreviation"],
                language: res[k]["language"],
                version: res[k]["version"],
                infoText: res[k]["info_text"],
                infoUrl: res[k]["info_url"],
                publisher: res[k]["publisher"],
                copyright: res[k]["copyright"],
                copyrightInfo: res[k]["copyright_info"],
                keyTable: 'key_' + res[k]["language"],
              ));
    }

    return bibleVersionList;
  }
}
