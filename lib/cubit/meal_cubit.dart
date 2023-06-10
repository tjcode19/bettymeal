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

  getAllMeal() async {
    emit(MealLoading());
    try {
      final cal = await Future.wait(
        [
          mealRepository.getAllMeals('BR'),
          mealRepository.getAllMeals('LN'),
          mealRepository.getAllMeals('DN')
        ],
      );

      inspect(cal);

      if (cal[0].code != '000') {
        emit(MealError(cal[0].message!));
      } else {
        emit(MealSuccess(cal[0].data!, cal[1].data!, cal[2].data!));
      }
    } catch (e) {
      emit(MealError("Error Occured"));
      print(e);
    }
  }
}
