import 'package:sqflite/sqflite.dart';

import '../../models/category.dart';

class CategoryDao {
  static const String tableName = 'category';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      food_id INTEGER,
      day_of_week INTEGER,
      FOREIGN KEY (food_id) REFERENCES food (id)
    )
  ''';

  final Database _database;

  CategoryDao(this._database);

  Future<int> insert(Category category) async {
    return await _database.insert(tableName, category.toMap());
  }

  Future<int> update(Category category) async {
    return await _database.update(tableName, category.toMap(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  Future<int> delete(Category category) async {
    return await _database
        .delete(tableName, where: 'id = ?', whereArgs: [category.id]);
  }

  Future<List<Category>> getAll() async {
    final List<Map<String, dynamic>> maps = await _database.query(tableName);

    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }
}
