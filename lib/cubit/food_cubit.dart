import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/food.dart';
import '../data/repositories/food_repository.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  final FoodRepository _foodRepository;

  FoodCubit()
      : _foodRepository = FoodRepository(),
        super(FoodInitial());

  Future<void> getAllMeals() async {
    print('get meal');
    try {
      emit(FoodLoading());
      final categories = await _foodRepository.getAllMeals();
      emit(FoodLoaded(foods: categories));
    } catch (e) {
      print("here we are $e");
      emit(FoodError(errorMessage: e.toString()));
    }
  }

  Future<void> addFood(FoodModel food) async {
    try {
      await _foodRepository.addMeal(food);
      emit(FoodAdded());
    } catch (e) {
      emit(FoodError(errorMessage: e.toString()));
    }
  }
}
