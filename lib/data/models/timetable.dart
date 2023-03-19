import 'food.dart';

class Timetable {
  final int id;
  final DateTime date;
  final List<Food> foods;

  Timetable({required this.id, required this.date, required this.foods});

  // Define the `fromMap` method
  factory Timetable.fromMap(Map<String, dynamic> map) {
    final foodList = List<Map<String, dynamic>>.from(map['foods']);
    // final foods = foodList.map((food) => Food.fromMap(food)).toList();

    return Timetable(
      id: map['id'],
      date: DateTime.parse(map['date']),
      foods: [],
    );
  }

  // Convert a Timetable object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'foodIds': foods.map((food) => food.id).toList(),
    };
  }
}
