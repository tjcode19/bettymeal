import 'dart:developer';
import 'dart:math';

import 'package:bettymeals/data/models/food.dart';
import 'package:bettymeals/data/repositories/food_repository.dart';
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
      final bf = foods.where((food) => food.type == 0).toList();
      final ln = foods.where((e) => e.type == 1).toList();
      final dn = foods.where((e) => e.type == 2).toList();

      final mls = [bf, ln, dn];

      DateTime now = DateTime.now();
      int daysUntilNextSunday = 7 - now.weekday;
      if (now.weekday == 7) {
        daysUntilNextSunday = 0;
      }
      DateTime nextSunday = now.add(Duration(days: daysUntilNextSunday));
      int daysBetween = nextSunday.difference(now).inDays;
      var random = Random();
      var min = 0;
      final List<int> f = [];

      int d = 0;

      while (d < daysBetween) {
        var today = now.add(Duration(days: d));
        f.clear();
        for (List<FoodModel> m in mls) {
          int? b;

          var randomInt = min + random.nextInt((m.length-1) - min);

          b = m[randomInt].id;

          print('the random value $randomInt ${m.length} ${m[randomInt].name}');

          f.add(b!);
        }

        // inspect(f);

        addMeal(MealTable(date: today, foodId: f));
        d++;
      }
      // final meals = await _repository.getAllMeals();
      // emit(TimetableLoaded(timetable: meals));
    } catch (_) {
      emit(const TimetableError(errorMessage: ""));
    }
  }

  Future<void> addMeal(MealTable meal) async {
    inspect(meal);
    try {
      // await _repository.addMeal(meal);
      // final meals = await _repository.getAllMeals();
      // emit(TimetableLoaded(timetable: meals));
    } catch (_) {
      emit(const TimetableError(errorMessage: ''));
    }
  }
}
