import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // databse creation
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'location.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE table user_locations(id TEXT PRIMARY KEY, name TEXT, image TEXT)',
        );
      },
      version: 1,
    );
  }

  // insertion
  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // fetch
  static Future<List<Map<String, dynamic>>> fetch(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  // delete
  static Future<void> delete(String table) async {
    final db = await DBHelper.database();
    db.delete(table);
  }
}
