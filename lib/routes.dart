import 'package:bettymeals/ui/screens/addmeal.dart';
import 'package:bettymeals/ui/screens/index.dart';
import 'package:flutter/material.dart';

import 'ui/screens/addcategory.dart';
import 'ui/screens/mealtable.dart';

class Routes {
  static const String home = '/';
  static const String timetable = '/timetable';
  static const String addFood = '/add-food';
  static const String addCategory = '/add-category';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case timetable:
        return MaterialPageRoute(builder: (_) => const MealTableScreen());
      case addFood:
        return MaterialPageRoute(builder: (_) => const AddMealScreen());
      case addCategory:
        return MaterialPageRoute(builder: (_) => const AddCategoryScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
