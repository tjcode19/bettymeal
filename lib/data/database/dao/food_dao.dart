import 'package:sqflite/sqflite.dart';

import '../../models/food.dart';

class FoodDao {
  static const String tableName = 'food';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      description TEXT,
      image TEXT,
      type INTEGER,
      foodextra_id INTEGER,
      FOREIGN KEY (foodextra_id) REFERENCES foodextra (id)
    )
  ''';

  final Database _database;

  FoodDao(this._database);

  Future<int> insert(FoodRequestModel food) async {
    return await _database.insert(tableName, food.toMap());
  }

  Future<int> update(FoodModel food) async {
    return await _database
        .update(tableName, food.toMap(), where: 'id = ?', whereArgs: [food.id]);
  }

  Future<int> delete(FoodModel food) async {
    return await _database
        .delete(tableName, where: 'id = ?', whereArgs: [food.id]);
  }

  Future<List<FoodModel>> getAll() async {
    final List<Map<String, dynamic>> maps = await _database.query(tableName);

    return List.generate(maps.length, (i) {
      return FoodModel.fromMap(maps[i]);
    });
  }
}
