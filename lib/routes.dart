import 'package:bettymeals/ui/screens/addmeal.dart';
import 'package:bettymeals/ui/screens/homepage.dart';
import 'package:flutter/material.dart';

import 'ui/screens/addcategory.dart';
import 'ui/screens/timetable.dart';

class Routes {
  static const String home = '/';
  static const String timetable = '/timetable';
  static const String addFood = '/add-food';
  static const String addCategory = '/add-category';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case timetable:
        return MaterialPageRoute(builder: (_) => TimetableScreen());
      case addFood:
        return MaterialPageRoute(builder: (_) => AddMealScreen());
      case addCategory:
        return MaterialPageRoute(builder: (_) => AddCategoryScreen());
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
