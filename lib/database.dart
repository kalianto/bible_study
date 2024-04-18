import "dart:io";

import 'package:flutter/services.dart';
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';

import 'app_config.dart';

class DatabaseService {
  static final DatabaseService _instance = new DatabaseService.internal();
  factory DatabaseService() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseService.internal();

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

    // var taskDb = await openReadOnlyDatabase(path);
    // var taskDb = await openDatabase(path, version: 1);
    var taskDb = await openDatabase(
      path,
      version: AppConfig.dbVersion,
      onUpgrade: _onUpgrade,
    );
    print('Database init');
    print(await taskDb.getVersion());
    taskDb.setVersion(1);
    return taskDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // check version
    print(db);
    print(oldVersion);
    print(newVersion);

    // get the file from migrations folder
    if (oldVersion < newVersion) {
      print('upgrade');
    }
    // execute the file
  }
}
