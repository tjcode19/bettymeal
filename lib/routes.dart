import 'package:bettymeals/ui/screens/addmeal.dart';
import 'package:bettymeals/ui/screens/get_started.dart';
import 'package:bettymeals/ui/screens/index.dart';
import 'package:bettymeals/ui/screens/meal_details.dart';
import 'package:bettymeals/ui/screens/onboarding/index.dart';
import 'package:bettymeals/ui/screens/settings/change_password.dart';
import 'package:bettymeals/ui/screens/settings/profile.dart';
import 'package:bettymeals/ui/splash_screen.dart';
import 'package:flutter/material.dart';

import 'data/api/models/GetSubscription.dart';
import 'data/api/models/MealResponse.dart';
import 'ui/screens/addcategory.dart';
import 'ui/screens/login.dart';
import 'ui/screens/mealtable.dart';
import 'ui/screens/plan_details/index.dart';
import 'ui/screens/plans.dart';
import 'ui/screens/set_password.dart';
import 'ui/screens/settings/about.dart';

class Routes {
  static const String splashScreen = '/slash-screen';
  static const String home = '/';
  static const String onboarding = '/onboarding';
  static const String getStarted = '/get-started';
  static const String planDetails = '/plan-details';
  static const String timetable = '/timetable';
  static const String addFood = '/add-food';
  static const String setPassword = '/set-password';
  static const String addCategory = '/add-category';
  static const String mealDetails = '/meal-details';
  static const String plans = '/plans';
  static const String loginScreen = '/login-screen';
  static const String aboutScreen = '/about-screen';
  static const String profileScreen = '/profile-screen';
  static const String changePasswordScreen = '/change-password-screen';

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
      case planDetails:
        final SubData plan = settings.arguments as SubData;
        return MaterialPageRoute(
          builder: (_) => PlanDetails(
            plan: plan,
          ),
        );
      case mealDetails:
        final MealData meal = settings.arguments as MealData;
        return MaterialPageRoute(
          builder: (_) => MealDetails(
            meal: meal,
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
      case plans:
        final String t = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PlansScreen(
            planId: t,
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
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case aboutScreen:
        return MaterialPageRoute(
          builder: (_) => AboutScreen(),
        );
      case profileScreen:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case changePasswordScreen:
        return MaterialPageRoute(
          builder: (_) => ChangePasswordScreen(),
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
