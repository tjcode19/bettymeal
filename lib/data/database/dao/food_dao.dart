import 'package:sqflite/sqflite.dart';

import '../../models/food.dart';

class FoodDao {
  static const String tableName = 'food';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''';

  final Database _database;

  FoodDao(this._database);

  Future<int> insert(Food food) async {
    return await _database.insert(tableName, food.toMap());
  }

  Future<int> update(Food food) async {
    return await _database
        .update(tableName, food.toMap(), where: 'id = ?', whereArgs: [food.id]);
  }

  Future<int> delete(Food food) async {
    return await _database
        .delete(tableName, where: 'id = ?', whereArgs: [food.id]);
  }

  Future<List<Food>> getAll() async {
    final List<Map<String, dynamic>> maps = await _database.query(tableName);

    return List.generate(maps.length, (i) {
      return Food.fromMap(maps[i]);
    });
  }
}
