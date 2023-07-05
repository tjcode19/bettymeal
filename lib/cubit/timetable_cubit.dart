import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:bettymeals/cubit/sub_cubit.dart';
import 'package:bettymeals/cubit/user_cubit.dart';
import 'package:bettymeals/data/local/models/food.dart';
import 'package:bettymeals/data/local/repositories/food_repository.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/api/models/GetTimetable.dart';
import '../data/api/repositories/timetableRepo.dart';
import '../data/local/models/timetable.dart';
import '../data/local/repositories/timetable_repository.dart';

part 'timetable_state.dart';

class TimetableCubit extends Cubit<TimetableState> {
  final TimetableRepository _repository;
  final TimetableRepo apiRepo;

  TimetableCubit()
      : _repository = TimetableRepository(),
        apiRepo = TimetableRepo(),
        super(TimetableInitial());

  Future<void> generateMealTable() async {
    try {
      FoodRepository foodRepository = FoodRepository();
      final foods = await foodRepository.getAllMeals();

      final bf =
          foods.where((food) => (jsonDecode(food.type).contains(0))).toList();
      final ln =
          foods.where((food) => (jsonDecode(food.type).contains(1))).toList();
      final dn =
          foods.where((food) => (jsonDecode(food.type).contains(2))).toList();

      final mls = [];

      mls.add(bf);
      mls.add(ln);
      mls.add(dn);

      var random = Random();
      var min = 0;

      // int d = 0;
      final dates = HelperMethod.dayOfWeek();

      for (String d in dates) {
        var today = DateTime.parse(d);
        final List<int> f = [];
        int? b;
        for (List<FoodModel> m in mls) {
          var randomInt = min + random.nextInt(m.length - min);

          int att = 0;
          while (f.contains(m[randomInt].id) && att < 3) {
            randomInt = min + random.nextInt(m.length - min);

            att++;
          }
          b = m[randomInt].id!;
          f.add(b);
        }

        addMeal(
            TimeTable(date: today.microsecondsSinceEpoch, food: jsonEncode(f)));
      }
    } catch (_) {
      emit(const TimetableError(errorMessage: ""));
    }
  }

  Future<void> rescheduleMealTable() async {
    try {
      FoodRepository foodRepository = FoodRepository();
      final foods = await foodRepository.getAllMeals();

      final bf =
          foods.where((food) => (jsonDecode(food.type).contains(0))).toList();
      final ln =
          foods.where((food) => (jsonDecode(food.type).contains(1))).toList();
      final dn =
          foods.where((food) => (jsonDecode(food.type).contains(2))).toList();

      final mls = [];

      mls.add(bf);
      mls.add(ln);
      mls.add(dn);

      var random = Random();
      var min = 0;

      // int d = 0;
      final dates = HelperMethod.dayOfWeek();

      for (String d in dates) {
        var today = DateTime.parse(d);
        final List<int> f = [];
        int? b;
        for (List<FoodModel> m in mls) {
          var randomInt = min + random.nextInt(m.length - min);

          int att = 0;
          while (f.contains(m[randomInt].id) && att < 3) {
            randomInt = min + random.nextInt(m.length - min);

            att++;
          }
          b = m[randomInt].id!;
          f.add(b);
        }

        await updateMeal(
            TimeTable(date: today.microsecondsSinceEpoch, food: jsonEncode(f)));
      }
    } catch (_) {
      emit(const TimetableError(errorMessage: ""));
    }
  }

  Future<void> updateMeal(TimeTable meal) async {
    try {
      await _repository.updateMeal(meal);
      getTimetable();
    } catch (e) {
      emit(const TimetableError(errorMessage: ''));
    }
  }

  Future<void> addMeal(TimeTable meal) async {
    try {
      await _repository.addMeal(meal);
      getTimetable();
    } catch (e) {
      emit(const TimetableError(errorMessage: ''));
    }
  }

  Future<void> getTimetable() async {
    FoodRepository foodRepository = FoodRepository();
    final dates = HelperMethod.dayOfWeek();
    try {
      final meals = await _repository.getWeekTimetable(
          DateTime.parse(dates[0]).microsecondsSinceEpoch,
          DateTime.parse(dates[dates.length - 1]).microsecondsSinceEpoch);

      final m = List.generate(meals.length, (i) async {
        List<dynamic> f = jsonDecode(meals[i].food!);
        final List<FoodModel> fItem = [];

        for (int i in f) {
          var kk = await foodRepository.getById(i);
          fItem.add(kk[0]);
        }
        return TimetableModel(
            date: DateTime.fromMicrosecondsSinceEpoch(meals[i].date!),
            foods: fItem);
      });

      List<TimetableModel> mealList = await Future.wait(m);

      emit(TimetableLoaded(timetable: mealList));
    } catch (e) {
      emit(const TimetableError(errorMessage: ''));
    }
  }

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

  getRecords(data) {
    emit(GetRecordSuccess(data));
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
          UserCubit().isActiveSub(v: true);
          emit(GetTableSuccess(d, cal.data!));
        } else {
          emit(NoSubSuccess(msg: 'You currently do not have any active plan'));
        }
      }
    } catch (e) {
      emit(TimetableError(errorMessage: "Error Occured"));
    }
  }
}
