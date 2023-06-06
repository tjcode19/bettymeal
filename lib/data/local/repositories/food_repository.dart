import '../database/app_database.dart';
import '../models/food.dart';

class FoodRepository {
  final foodDao = AppDatabase.instance.foodDao;

  Future<List<FoodModel>> getAllMeals() async {
    return await foodDao.getAll();
  }

   Future<List<FoodModel>> getById(int foodId) async {
    return await foodDao.getById(foodId);
  }

  Future<void> addMeal(FoodRequestModel food) async {
    await foodDao.insert(food);
  }

  Future<void> deleteMeal(FoodModel food) async {
    await foodDao.delete(food);
  }
}
