import 'dart:async';

import '../database.dart';
import '../helpers/bible_helper.dart' as BibleHelper;
import '../models/bible_view.dart';
import '../models/rhema.dart';

class RhemaService {
  final dbService = DatabaseService();

  /// date must be in y-MM-dd format
  Future<List<Rhema>> getRhemaByDate(String date) async {
    var dbClient = await dbService.db;
    List<Rhema> rhemaList = [];
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
      'SELECT a.id, a.rhemaDate, a.rhemaText, a.bibleVersionId, a.dateKey, '
      'b."table" as bibleTable, '
      'b.abbreviation as bibleAbbreviation, '
      'b.language as bibleLang '
      'fROM rhema a '
      'JOIN bible_version_key b on a.bibleVersionId = b.id '
      'where a.dateKey = ? '
      'ORDER BY a.rhemaDate DESC ',
      [date],
    );

    if (res.length > 0) {
      rhemaList = List.generate(res.length, (i) => Rhema.fromMapEntry(res[i]));
    }
    return rhemaList;
  }

  Future<List<Rhema>> getAllRhemaList({int limit = 10000}) async {
    var dbClient = await dbService.db;
    List<Rhema> rhemaList = [];
    List<Map<String, dynamic>> res = await dbClient.rawQuery(
      'SELECT a.id, a.rhemaDate, a.rhemaText, a.bibleVersionId, a.dateKey, '
      'b."table" as bibleTable, '
      'b.abbreviation as bibleAbbreviation, '
      'b.language as bibleLang '
      'fROM rhema a '
      'JOIN bible_version_key b on a.bibleVersionId = b.id '
      'ORDER BY rhemaDate DESC ',
    );

    if (res.length > 0) {
      rhemaList = List.generate(res.length, (i) => Rhema.fromMapEntry(res[i]));
    }

    return rhemaList;
  }

  Future<List<Rhema>> getAllRhemaVerseList(List<Rhema> rhemaList) async {
    var dbClient = await dbService.db;
    for (Rhema rhema in rhemaList) {
      rhema.rhemaVerses = [];
      List<Map<String, dynamic>> res = await dbClient.rawQuery(
        'SELECT a.rhemaId, a.verseId, a.verseOrder, '
        'b.t as verse, b.b as bookNum, b.c as bookChapter, b.v as bookVerse, '
        'b.t as bookText, c.n as bookName '
        'FROM rhema_verses as a '
        'JOIN ${rhema.bibleTable} as b ON a.verseId = b.id '
        'JOIN key_${rhema.bibleLang} as c ON c.b = b.b '
        'WHERE a.rhemaId = ? '
        'ORDER BY a.verseOrder ASC',
        [rhema.id],
      );

      if (res.length > 0) {
        try {
          for (int i = 0; i < res.length; i++) {
            RhemaVerse newRhemaVerse = RhemaVerse.fromMapEntry(res[i]);
            newRhemaVerse.bibleView = BibleView(
              id: res[i]["verseId"],
              bookName: res[i]["bookName"],
              bookNum: res[i]["bookNum"],
              bookChapter: res[i]["bookChapter"],
              bookVerse: res[i]["bookVerse"],
              bibleVersion: rhema.bibleTable,
              bibleCode: rhema.bibleAbbreviation,
              bookText: BibleHelper.parseText(res[i]["bookText"]),
              bibleVersionId: rhema.bibleVersionId,
            );
            rhema.rhemaVerses.add(newRhemaVerse);
          }
        } catch (error) {
          print(error);
        }
      }
    }
    return rhemaList;
  }

  Future<List<Rhema>> getRhemaSummary(int limit) async {
    // List<RhemaSummary> summaryList = [];
    List<Rhema> rhemaList = await getAllRhemaList(limit: limit);
    List<Rhema> rhemaVerseList = await getAllRhemaVerseList(rhemaList);
    return rhemaVerseList;
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
      [id],
    );

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
      // List<RhemaVerse> rhemaVerses = [];
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
