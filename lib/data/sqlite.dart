import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SQLite {
  static final SQLite instance = SQLite._init();

  static Database? _database;

  SQLite._init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Database");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Validate (
        ID INTEGER PRIMARY KEY,
        Finger_Print VARCHAR(255),
        Remember_Status VARCHAR(255)
      )
      ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row["ID"];
    return await db!.update(table, row, where: 'ID = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: 'ID = ?', whereArgs: [id]);
  }

  Future deleteDatabase() async {
    Database? db = await instance.database;
    db!.close();
    _database = null;
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Database");
    databaseFactory.deleteDatabase(path);
    initDatabase();
  }
}
