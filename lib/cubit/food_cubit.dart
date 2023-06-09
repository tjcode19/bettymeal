import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/local/models/food.dart';
import '../data/local/repositories/food_repository.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  final FoodRepository _foodRepository;

  FoodCubit()
      : _foodRepository = FoodRepository(),
        super(FoodInitial());

  Future<void> getAllMeals() async {
    try {
      emit(FoodLoading());
      final foods = await _foodRepository.getAllMeals();

      final bf =
          foods.where((food) => (jsonDecode(food.type).contains(0))).toList();
      final ln =
          foods.where((food) => (jsonDecode(food.type).contains(1))).toList();
      final dn =
          foods.where((food) => (jsonDecode(food.type).contains(2))).toList();

      emit(FoodLoaded(foods: foods, bf: bf, ln: ln, dn: dn));
    } catch (e) {
      emit(FoodError(errorMessage: e.toString()));
    }
  }

  Future<int> getFoodSize() async {
    final foods = await _foodRepository.getAllMeals();

    return foods.length;
  }

  Future<void> addFood(FoodRequestModel food) async {
    inspect(food);
    try {
      await _foodRepository.addMeal(food);

      emit(FoodAdded());
    } catch (e) {
      emit(FoodError(errorMessage: e.toString()));
    }
  }

  Future<void> deleteFood(FoodModel food) async {
    try {
      await _foodRepository.deleteMeal(food);

      await getAllMeals();

      // emit(FoodDeleted());
    } catch (e) {
      emit(FoodError(errorMessage: e.toString()));
    }
  }

  selectedFood(int currentMeal) {}
}
