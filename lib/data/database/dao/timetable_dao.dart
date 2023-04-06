import 'package:sqflite/sqflite.dart';

import '../../models/timetable.dart';

class TimetableDao {
  static const String tableName = 'timetable';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      food TEXT,
      date INTEGER
    )
  ''';

  final Database _database;

  TimetableDao(this._database);

  Future<int> insert(TimeTable timetable) async {
    return await _database.insert(tableName, timetable.toJson());
  }

  Future<int> update(TimeTable timetable) async {
    return await _database.update(tableName, timetable.toJson(),
        where: 'id = ?', whereArgs: [timetable.id]);
  }

  Future<int> delete(TimeTable timetable) async {
    return await _database
        .delete(tableName, where: 'id = ?', whereArgs: [timetable.id]);
  }

  Future<List<TimeTable>> getAll() async {
    final List<Map<String, dynamic>> maps = await _database.query(tableName);

    return List.generate(maps.length, (i) {
      return TimeTable.fromJson(maps[i]);
    });
  }

  
}
