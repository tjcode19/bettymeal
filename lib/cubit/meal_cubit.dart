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

  getAllMeal(action, {page = 1, limit = 20}) async {
    emit(MealLoading());
    try {
      final cal = await mealRepository.getAllMeals(page: page, limit: limit);
      if (cal.code != '000') {
        emit(MealError(cal.message!));
      } else {
        if (action == 'fresh') {
          emit(MealSuccess(cal.data!));
        } else if (action == 'reload') {
          emit(MealReloadSuccess(cal.data!));
        } else if (action == 'more') {
          emit(MealMoreSuccess(cal.data!));
        } else {
          emit(MealSuccess(cal.data!));
        }
      }
    } catch (e) {
      emit(MealError("Error Occured"));
      print(e);
    }
  }

  searchMeal({name}) async {
    emit(MealLoading());
    try {
      final cal = await mealRepository.searchMeals(name: name);

      inspect(cal);
      if (cal.code != '000') {
        emit(MealError(cal.message!));
      } else {
        emit(MealSuccessFilter(cal.data!));
      }
    } catch (e) {
      emit(MealError("Error Occured"));
      print(e);
    }
  }

  filterMeal(String query, List<MealData> data) {
    emit(MealLoading());
    List<MealData> filteredList = [];
    if (query.isNotEmpty && query != '') {
      final c = data
          .where(
              (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      filteredList = c;

      if (c.isEmpty && query != '') {
        searchMeal(name: query);
      } else {
        emit(MealSuccessFilter(filteredList));
      }
    } else {
      emit(MealSuccessFilter(data));
    }
  }
}
