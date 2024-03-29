import '../database/app_database.dart';
import '../models/timetable.dart';

class TimetableRepository {
  final _timetableDao = AppDatabase.instance.timetableDao;

  Future<List<TimeTable>> getTimetable() async {
    var res;
    try {
      res = await _timetableDao.getAll();
    } catch (e) {
      // return e;
      print('all timetable error $e');
    }

    return res;
  }

  Future<List<TimeTable>> getWeekTimetable(sDate, eDate) async {
    var res;
    try {
      res = await _timetableDao.getForWeek(sDate, eDate);
    } catch (e) {
      // return e;
      print('all timetable error $e');
    }

    return res;
  }

  Future<void> addMeal(TimeTable meal) async {
    await _timetableDao.insert(meal);
  }

  Future<void> updateMeal(TimeTable meal) async {
    await _timetableDao.update(meal);
  }
}
