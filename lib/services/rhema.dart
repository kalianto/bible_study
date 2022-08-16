import 'dart:async';

import '../database.dart';
import '../models/bible_view.dart';
import '../models/rhema.dart';

class RhemaService {
  final dbService = DatabaseService();

  Future<List<Rhema>> getRhemaByDate(String date) async {
    var dbClient = await dbService.db;
    List<Rhema> rhemaList = [];
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.id, a.rhemaDate, a.rhemaText, a.bibleVersionId, '
        'b."table"'
        ', b.abbreviation, b.language '
        'fROM rhema a '
        'JOIN bible_version_key b on a.bibleVersionId = b.id '
        'WHERE a.rhemaDate = ?',
        [date]);

    if (res.length > 0) {
      rhemaList = List.generate(
          res.length,
          (i) => Rhema(
                id: res[i]["id"],
                rhemaDate: res[i]["rhemaDate"],
                rhemaText: res[i]["rhemaText"],
                bibleVersionId: res[i]["bibleVersionId"],
              ));
    }
    return rhemaList;
  }

  Future<List<Rhema>> getAllRhema({int limit = 10}) async {
    var dbClient = await dbService.db;
    List<Rhema> rhemaList = [];
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.id, a.rhemaDate, a.rhemaText, a.bibleVersionId, '
        'b."table", b.abbreviation, b.language, '
        'c.verseId, c.verseOrder '
        'fROM rhema a '
        'JOIN bible_version_key b on a.bibleVersionId = b.id '
        'JOIN rhema_verses c on a.id = c.rhemaId '
        'ORDER BY rhemaDate DESC '
        'LIMIT ?',
        [limit]);

    if (res.length > 0) {
      rhemaList = List.generate(res.length, (i) => Rhema.fromMapEntry(res[i]));
    }

    return rhemaList;
  }

  /// getRhemaByID
  Future<Rhema> getRhemaById(int id) async {
    var dbClient = await dbService.db;
    Rhema rhema;
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.id, a.rhemaDate, a.rhemaText, a.bibleVersionId '
        'fROM rhema a '
        'JOIN bible_version_key b on a.bibleVersionId = b.id '
        'WHERE a.id = ?',
        [id]);

    if (res.length > 0) {
      rhema = Rhema(
        id: res[0]["id"],
        rhemaDate: res[0]["rhemaDate"],
        rhemaText: res[0]["rhemaText"],
        bibleVersionId: res[0]["bibleVersionId"],
      );
    }

    return rhema;
  }

  /// insertRhema
  Future<Rhema> insertRhema(Rhema rhema, List<BibleView> bibleViewList) async {
    var dbClient = await dbService.db;
    await dbClient.transaction((txn) async {
      rhema.id = await txn.insert('rhema', rhema.toMap());
      List<RhemaVerse> rhemaVerses = [];
      final batch = txn.batch();
      for (var x = 0; x < bibleViewList.length; x++) {
        RhemaVerse rhemaVerse = new RhemaVerse(
          rhemaId: rhema.id,
          verseId: bibleViewList[x].id,
          verseOrder: x + 1,
        );
        batch.insert('rhema_verses', rhemaVerse.toMap());
        // rhema.rhemaVerses.add(rhemaVerse);
      }
      batch.commit(noResult: true);
    });

    return rhema;
  }

  /// updateRhema

  /// deleteRhema
  Future<void> deleteRhema(int rhemaId) async {
    var dbClient = await dbService.db;
    await dbClient.transaction((txn) async {
      await txn.delete('rhema', where: "id = ?", whereArgs: [rhemaId]);
      await txn.delete('rhema_verses', where: "rhemaId = ?", whereArgs: [rhemaId]);
    });
  }
}
