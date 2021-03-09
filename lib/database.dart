import "dart:io";
import 'dart:typed_data';
import 'package:flutter/services.dart';
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'app_config.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = new DatabaseProvider.internal();

  factory DatabaseProvider() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseProvider.internal();

  /// Initialize DB
  initDb() async {
    String path = join(await getDatabasesPath(), AppConfig.dbFile);
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      try {
        ByteData data = await rootBundle.load(join("assets", "cfg", AppConfig.dbFile));
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(path).writeAsBytes(bytes, flush: true);
      } catch (_) {}
    }
    // var taskDb = await openDatabase(path, version: 1);
    var taskDb = await openReadOnlyDatabase(path);
    return taskDb;
  }

  Future countTable() async {
    var dbClient = await db;
    var res =
    // await dbClient.rawQuery("""SELECT count(*) as count FROM sqlite_master
    //      WHERE type = 'table'
    //      AND name != 'android_metadata'
    //      AND name != 'sqlite_sequence';""");
    await dbClient.query('t_asv', columns: ['*'], where: 'id = ?', whereArgs: [1001010]);
    return res[0]['t'];
  }
}
