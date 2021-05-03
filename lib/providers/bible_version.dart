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
            'where a.id = ? and a.enabled = 1',
        [bibleVersionId]);

    if (res.length > 0) {
      bibleVersion = BibleVersion.fromMapEntry(res[0]);
    }

    return bibleVersion;
  }

  Future<List<BibleVersion>> getAllBibleVersion() async {
    var dbClient = await dbProvider.db;
    List<BibleVersion> bibleVersionList = [];
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.id, a."table", a.abbreviation, a.language, a.version, a.info_text, ' +
            'a.info_url, a.publisher, a.copyright, a.copyright_info ' +
            'from bible_version_key a where a.enabled = 1');

    if (res.length > 0) {
      bibleVersionList = List.generate(
        res.length,
        (k) => BibleVersion.fromMapEntry(res[k])
      );
    }

    return bibleVersionList;
  }
}
