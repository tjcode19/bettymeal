import '../database/app_database.dart';
import '../models/food.dart';

class FoodRepository {
  final foodDao = AppDatabase.instance.foodDao;

  Future<List<FoodModel>> getAllMeals() async {
    return await foodDao.getAll();
  }

  Future<void> addMeal(FoodRequestModel food) async {
    await foodDao.insert(food);
  }
}
