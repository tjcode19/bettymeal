import 'package:bettymeals/data/api/models/MealResponse.dart';
import 'package:bettymeals/data/api/network_request.dart';

class MealRepository {
  final NetworkRequest nRequest = NetworkRequest();

  Future<GetAllMeal> getAllMeals(type) async {
    final response = await nRequest.get("meal/filter/$type");

    return GetAllMeal.fromJson(response);
  }
}
