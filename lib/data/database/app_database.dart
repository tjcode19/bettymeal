import 'package:sqflite/sqflite.dart';

import 'dao/category_dao.dart';
import 'dao/food_dao.dart';
import 'dao/timetable_dao.dart';
import 'package:path/path.dart';

class AppDatabase {
  static const String DB_NAME = 'meal_timetable_app.db';
  static const int DB_VERSION = 1;

  static late final AppDatabase instance;

  Database? _database;

  late final FoodDao foodDao;
  late final CategoryDao categoryDao;
  late final TimetableDao timetableDao;

  AppDatabase._() {
    // Private constructor to prevent multiple instances of the database.
  }

  Future<void> init() async {
    // Get the database path using the sqflite package.
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DB_NAME);

    // Open the database.
    _database = await openDatabase(path, version: DB_VERSION,
        onCreate: (db, version) async {
      // Create the tables.
      await db.execute(FoodDao.createTableQuery);
      await db.execute(CategoryDao.createTableQuery);
      await db.execute(TimetableDao.createTableQuery);
    });

    // Initialize the DAOs.
    foodDao = FoodDao(_database!);
    categoryDao = CategoryDao(_database!);
    timetableDao = TimetableDao(_database!);
  }

  factory AppDatabase() {
    // if (AppDatabase.instance == null) {
      print('hereeeee');
      AppDatabase.instance = AppDatabase._();
      // AppDatabase.instance.init();
    // }
    return AppDatabase.instance;
  }

  Future<void> close() async {
    await _database?.close();
  }
}
