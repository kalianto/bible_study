import 'dart:async';

import '../database.dart';
import '../helpers/bible_helper.dart' as BibleHelper;
import '../models/bible_version.dart';
import '../services/bible_version.dart';

class MyBibleService {
  final dbService = DatabaseService();

  Future<List<int>> getAllBibleChapters({int bibleVersionId = 8}) async {
    var dbClient = await dbService.db;
    final bibleVersionProvider = BibleVersionService();

    BibleVersion bibleVersion = await bibleVersionProvider.getBibleVersion(bibleVersionId);

    List<int> allBibleChapters = [];
    List<Map<String, dynamic>> res =
        await dbClient.rawQuery('select DISTINCT b, c from ${bibleVersion.table} ');

    if (res.length > 0) {
      allBibleChapters = List.generate(
          res.length, (index) => BibleHelper.formatBookChapter(res[index]["b"], res[index]["c"]));
    }

    return allBibleChapters;
  }
}
