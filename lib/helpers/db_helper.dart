import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // database creation
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, isFavorite num)',
        );
      },
      version: 1,
    );
  }

  // toggleFavorite
  static Future<void> toggleFavorite(String id, int status) async {
    final db = await DBHelper.database();
     db.rawUpdate(
      'UPDATE user_places SET isFavorite = ? WHERE id = ?',
      [status, id],
    );
  }

  // insertion
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  // fetch
  static Future<List<Map<String, dynamic>>> fetchData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  // delete
  static Future<int> delete(String table, String id) async {
    final db = await DBHelper.database();
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // Close the database
  static Future<void> close() async {
    final db = await DBHelper.database();
    db.close();
  }
}
