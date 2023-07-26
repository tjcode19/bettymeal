import 'dart:developer';

import 'package:bettymeals/data/api/models/MealResponse.dart';
import 'package:bettymeals/data/api/repositories/mealRepo.dart';
import 'package:bettymeals/data/shared_preference.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'meal_state.dart';

class MealCubit extends Cubit<MealState> {
  MealCubit()
      : sharedPreference = SharedPreferenceApp(),
        mealRepository = MealRepository(),
        super(MealInitial());

  final SharedPreferenceApp sharedPreference;
  final MealRepository mealRepository;

  getAllMeal({page, limit}) async {
    emit(MealLoading());
    try {
      final cal = await mealRepository.getAllMeals(page: page, limit: limit);

      inspect(cal);

      if (cal.code != '000') {
        emit(MealError(cal.message!));
      } else {
        emit(MealSuccess(cal.data!));
      }
    } catch (e) {
      emit(MealError("Error Occured"));
      print(e);
    }
  }
}
