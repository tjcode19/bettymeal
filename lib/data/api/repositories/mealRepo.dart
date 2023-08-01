import 'package:bettymeals/data/api/models/MealResponse.dart';
import 'package:bettymeals/data/api/network_request.dart';

class MealRepository {
  final NetworkRequest nRequest = NetworkRequest();

  Future<GetAllMeal> getAllMeals({page=1, limit = 10}) async {
    final response = await nRequest.get("meal?page=$page&limit=$limit"); //meal?page=1&limit=40

    return GetAllMeal.fromJson(response);
  }

  Future<GetAllMeal> searchMeals({name}) async {
    final response = await nRequest.get("meal/search/$name"); //meal?page=1&limit=40

    return GetAllMeal.fromJson(response);
  }
}
