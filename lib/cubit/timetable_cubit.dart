import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/api/models/GetTimetable.dart';
import '../data/api/repositories/timetableRepo.dart';
import '../data/local/models/timetable.dart';

part 'timetable_state.dart';

class TimetableCubit extends Cubit<TimetableState> {
  final TimetableRepo apiRepo;

  TimetableCubit()
      : apiRepo = TimetableRepo(),
        super(TimetableInitial());

  generateTimeableApi(subId, duration) async {
    emit(TimetableLoading());
    try {
      final cal = await apiRepo.generateTimetable(subId, duration);

      if (cal.code == '000') {
        getTimeableApi();
        emit(TimetableSuccess());
      } else if (cal.code == '004') {
        emit(TimetableInfo(msg: cal.message!));
      } else {
        emit(TimetableError(errorMessage: cal.message!));
      }
    } catch (e) {
      emit(TimetableError(errorMessage: "Error Occured"));
      print(e);
    }
  }

  shuffleTimeableApi(id) async {
    emit(TimetableLoading());
    try {
      final cal = await apiRepo.shuffleTimetable(id);

      if (cal.code != '000') {
        emit(TimetableError(errorMessage: cal.message!));
      } else {
        getTimeableApi();
        // emit(TimetableSuccess());
      }
    } catch (e) {
      emit(TimetableError(errorMessage: "Error Occured"));
      print(e);
    }
  }

  regenrateTimeableApi(id) async {
    emit(TimetableLoading());
    try {
      final cal = await apiRepo.regenerateTimetable(id);

      if (cal.code != '000') {
        emit(TimetableError(errorMessage: cal.message!));
      } else {
        getTimeableApi();
        // emit(TimetableSuccess());
      }
    } catch (e) {
      emit(TimetableError(errorMessage: "Error Occured"));
      print(e);
    }
  }

  sortTable(List<GetTimetableData> data) {
    List<List<Timetable>> weeklyTable = [];

    try {
      List<Timetable> timetable = data[0].timetable!;

      DateTime startDate = DateTime.parse(data[0].startDate!);
      int startWeekday = startDate.weekday;
      int daysUntilSaturday = (DateTime.saturday - startWeekday) % 7;

      int i = 0;

      List<Timetable> weekly = [];

      if (timetable.length <= 8) {
        weekly.addAll(timetable);
        weeklyTable.add(weekly);
        return weeklyTable;
      }

      while (i <= timetable.length) {
        if (daysUntilSaturday >= 0 && i < timetable.length) {
          weekly.add(timetable[i]);
          daysUntilSaturday--;
          i++;
          continue;
        }
        weeklyTable.add(weekly);
        if (daysUntilSaturday == -1 && i == timetable.length) {
          break;
        }

        weekly = [];

        startDate = DateTime.parse(timetable[i].meals![0].date!);
        startWeekday = startDate.weekday;
        final endWeekDay = timetable.length - i > 7
            ? DateTime.saturday
            : DateTime.parse(data[0].endDate!).weekday;
        daysUntilSaturday = (endWeekDay - startWeekday) % 7;

        i = i;
      }

      return weeklyTable.toList();
    } catch (d) {
      print(d);
    }
  }

  getTimeableApi() async {
    // emit(TimetableLoading());
    try {
      final cal = await apiRepo.getTimetable();

      if (cal.code != '000') {
        emit(TimetableError(errorMessage: cal.message!));
      } else {
        // getRecords(cal.data);
        final now = DateTime.now();
        List<GetTimetableData> d = cal.data!.where(
          (element) {
            var h = DateTime.parse(element.endDate!);

            return element.active == true && !h.isBefore(now);
          },
        ).toList();

        if (d.length > 0) {
          final dataWeekly = sortTable(cal.data!);
          emit(GetTableSuccess(d, cal.data!, dataWeekly));
        } else {
          emit(NoSubSuccess(msg: 'You currently do not have any active plan'));
        }
      }
    } catch (e) {
      emit(TimetableError(errorMessage: "Error Occured"));
    }
  }
}
