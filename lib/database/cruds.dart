import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'database.dart';
import '../model/todo.dart';

class DBCrud {
  Future<List<TODO>> getDB() async {
    final Database db = await DBConnection().accessDb();
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (index) {
      return TODO(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
      );
    });
  }

  Future<List<TODO>> getEachDB(int id) async {
    final Database db = await DBConnection().accessDb();

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM todo WHERE id = $id');
    return List.generate(maps.length, (index) {
      return TODO(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
      );
    });
  }

  getCountDB() async {
    final Database db = await DBConnection().accessDb();

    var count = await db.rawQuery('SELECT COUNT(id) FROM todo');
    return count;
  }

  Future<void> insertDB(TODO todo) async {
    final Database db = await DBConnection().accessDb();

    var insertedData = await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return insertedData;
  }

  Future<void> updateDB(TODO todo) async {
    final Database db = await DBConnection().accessDb();

    var updatedData = await db.update(
      'todo',
      todo.toMap(),
      where: "id = ?",
      whereArgs: [todo.id],
    );

    return updatedData;
  }

  Future<void> deleteDB(int id) async {
    final Database db = await DBConnection().accessDb();

    var deletedData = await db.delete(
      'todo',
      where: "id = ?",
      whereArgs: [id],
    );

    return deletedData;
  }

  Future<void> deleteAllDB() async {
    final Database db = await DBConnection().accessDb();

    var deletedAllData = await db.delete('todo');

    return deletedAllData;
  }
}
