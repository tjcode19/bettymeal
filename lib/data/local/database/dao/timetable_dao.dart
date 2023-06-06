import 'dart:developer';

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
    Map<String, dynamic> json = {'food': timetable.food};
    return await _database.update(tableName,json,
        where: 'date = ?', whereArgs: [timetable.date]);
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

  // .where('createdAt', '>=', '2009-01-01T00:00:00Z')
  // .where('createdAt', '<', '2010-01-01T00:00:00Z')

  Future<List<TimeTable>> getForWeek(startDate, endDate) async {
    final List<Map<String, dynamic>> maps = await _database
        .query(tableName, where: 'date >= ?', whereArgs: [startDate]);

    return List.generate(maps.length, (i) {
      return TimeTable.fromJson(maps[i]);
    });
  }
}
