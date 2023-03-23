
import '../database/app_database.dart';
import '../models/timetable.dart';

class TimetableRepository {
  final _timetableDao = AppDatabase.instance.timetableDao;

  Future<List<TimetableModel>> getAllMeals() async {
    return await _timetableDao.getAll();
  }

  Future<void> addMeal(TimetableModel meal) async {
    await _timetableDao.insert(meal);
  }
}
