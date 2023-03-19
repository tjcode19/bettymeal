import 'package:sqflite/sqflite.dart';

import '../../models/timetable.dart';

class TimetableDao {
  static const String tableName = 'timetable';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      food_id INTEGER,
      day_of_week INTEGER,
      FOREIGN KEY (food_id) REFERENCES food (id)
    )
  ''';

  final Database _database;

  TimetableDao(this._database);

  Future<int> insert(Timetable timetable) async {
    return await _database.insert(tableName, timetable.toMap());
  }

  Future<int> update(Timetable timetable) async {
    return await _database.update(tableName, timetable.toMap(),
        where: 'id = ?', whereArgs: [timetable.id]);
  }

  Future<int> delete(Timetable timetable) async {
    return await _database
        .delete(tableName, where: 'id = ?', whereArgs: [timetable.id]);
  }

  Future<List<Timetable>> getAll() async {
    final List<Map<String, dynamic>> maps = await _database.query(tableName);

    return List.generate(maps.length, (i) {
      return Timetable.fromMap(maps[i]);
    });
  }
}
