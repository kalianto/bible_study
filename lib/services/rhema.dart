import 'dart:async';

import '../database.dart';
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

  /// updateRhema

  /// deleteRhema
}
