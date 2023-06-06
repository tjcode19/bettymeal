import 'package:sqflite/sqflite.dart';
import '../../models/food_extra.dart';

class FoodExtraDao {
  static const String tableName = 'foodextra';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT
    )
  ''';

  final Database _database;

  FoodExtraDao(this._database);

  Future<int> insert(FoodExtraModel food) async {
    return await _database.insert(tableName, food.toMap());
  }

  Future<int> update(FoodExtraModel food) async {
    return await _database
        .update(tableName, food.toMap(), where: 'id = ?', whereArgs: [food.id]);
  }

  Future<int> delete(FoodExtraModel food) async {
    return await _database
        .delete(tableName, where: 'id = ?', whereArgs: [food.id]);
  }

  Future<List<FoodExtraModel>> getAll() async {
    final List<Map<String, dynamic>> maps = await _database.query(tableName);

    return List.generate(maps.length, (i) {
      return FoodExtraModel.fromMap(maps[i]);
    });
  }
}
