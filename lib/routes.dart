import 'package:bettymeals/ui/screens/addmeal.dart';
import 'package:bettymeals/ui/screens/generate_meal/index.dart';
import 'package:bettymeals/ui/screens/get_started.dart';
import 'package:bettymeals/ui/screens/index.dart';
import 'package:bettymeals/ui/screens/meal_details.dart';
import 'package:bettymeals/ui/screens/onboarding/index.dart';
import 'package:bettymeals/ui/splash_screen.dart';
import 'package:flutter/material.dart';

import 'data/api/models/GetSubscription.dart';
import 'ui/screens/addcategory.dart';
import 'ui/screens/mealtable.dart';
import 'ui/screens/set_password.dart';

class Routes {
  static const String splashScreen = '/slash-screen';
  static const String home = '/';
  static const String onboarding = '/onboarding';
  static const String getStarted = '/get-started';
  static const String foodSetup = '/food-setup';
  static const String timetable = '/timetable';
  static const String addFood = '/add-food';
  static const String setPassword = '/set-password';
  static const String addCategory = '/add-category';
  static const String mealDetails = '/meal-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const Onboarding());
      case getStarted:
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case foodSetup:
        final SubData plan = settings.arguments as SubData;
        return MaterialPageRoute(
          builder: (_) => FoodSetup(
            plan: plan,
          ),
        );
      case mealDetails:
        final SubData plan = settings.arguments as SubData;
        return MaterialPageRoute(
          builder: (_) => MealDetails(
            plan: plan,
          ),
        );
      case timetable:
        return MaterialPageRoute(builder: (_) => const MealTableScreen());
      case addFood:
        final int t = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => AddMealScreen(
            typeId: t,
          ),
        );
      case setPassword:
        final List<String> t = settings.arguments as List<String>;
        return MaterialPageRoute(
          builder: (_) => SetPasswordScreen(
            userId: t[0],
            email: t[1],
          ),
        );
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
