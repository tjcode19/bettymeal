import 'package:bettymeals/data/database/dao/food_dao.dart';

import 'food.dart';

class TimetableModel {
  final int? id;
  final DateTime date;
  final List<FoodModel> foods;

  TimetableModel({this.id, required this.date, required this.foods});

  // Define the `fromMap` method
  factory TimetableModel.fromMap(Map<String, dynamic> map) {
    final foodList = List<Map<String, dynamic>>.from(map['foods']);
    final foods = foodList.map((food) => FoodModel.fromMap(food)).toList();

    return TimetableModel(
      id: map['id'],
      date: DateTime.parse(map['date']),
      foods: foods,
    );
  }

  // Convert a TimetableModel object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'foodIds': foods.map((food) => food.id).toList(),
    };
  }
}
