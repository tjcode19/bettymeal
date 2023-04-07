import 'dart:convert';
import 'dart:developer' as d;
import 'dart:math';

import 'package:bettymeals/data/models/food.dart';
import 'package:bettymeals/data/repositories/food_repository.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/timetable.dart';
import '../data/repositories/timetable_repository.dart';

part 'timetable_state.dart';

class TimetableCubit extends Cubit<TimetableState> {
  final TimetableRepository _repository;

  TimetableCubit()
      : _repository = TimetableRepository(),
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

      // DateTime now = DateTime.now();
      // int daysUntilNextSunday = 7 - now.weekday;
      // if (now.weekday == 7) {
      //   daysUntilNextSunday = 0;
      // }
      // DateTime nextSunday = now.add(Duration(days: daysUntilNextSunday));
      // int daysBetween = nextSunday.difference(now).inDays;
      var random = Random();
      var min = 0;
      // final List<int> f = [];

      int d = 0;
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
      // final meals = await _repository.getAllMeals();
      // emit(TimetableLoaded(timetable: meals));
    } catch (_) {
      emit(const TimetableError(errorMessage: ""));
    }
  }

  Future<void> addMeal(TimeTable meal) async {
    FoodRepository foodRepository = FoodRepository();
    try {
      await _repository.addMeal(meal);
      final meals = await _repository.getTimetable();


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

      d.inspect(mealList);

      emit(TimetableLoaded(timetable: mealList));
    } catch (e) {
      print(e);
      emit(const TimetableError(errorMessage: ''));
    }
  }

  Future<void> getTimetable() async {
    FoodRepository foodRepository = FoodRepository();
    try {
      final meals = await _repository.getTimetable();

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
}
