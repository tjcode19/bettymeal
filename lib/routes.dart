import 'package:bettymeals/ui/screens/addmeal.dart';
import 'package:bettymeals/ui/screens/authentication/forgot_password.dart';
import 'package:bettymeals/ui/screens/delete_account/index.dart';
import 'package:bettymeals/ui/screens/get_started.dart';
import 'package:bettymeals/ui/screens/index.dart';
import 'package:bettymeals/ui/screens/mealtable/stepbystep.dart';
import 'package:bettymeals/ui/screens/onboarding/index.dart';
import 'package:bettymeals/ui/screens/records/index.dart';
import 'package:bettymeals/ui/screens/settings/change_password.dart';
import 'package:bettymeals/ui/screens/settings/profile.dart';
import 'package:bettymeals/ui/screens/subscription/index.dart';
import 'package:bettymeals/ui/splash_screen.dart';
import 'package:bettymeals/utils/animations.dart';
import 'package:flutter/material.dart';
import 'data/api/models/GetNotifications.dart';
import 'data/api/models/GetSubscription.dart';
import 'data/api/models/MealResponse.dart';
import 'ui/screens/addcategory.dart';
import 'ui/screens/authentication/login.dart';
import 'ui/screens/mealtable/mealtable.dart';
import 'ui/screens/mealtable/meal_details.dart';
import 'ui/screens/notifications/noti_list.dart';
import 'ui/screens/notifications/notifications.dart';
import 'ui/screens/payment.dart';
import 'ui/screens/plan_details/index.dart';
import 'ui/screens/plans.dart';
import 'ui/screens/set_password.dart';
import 'ui/screens/settings/about.dart';
import 'ui/screens/store.dart';

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
  static const String forgotPasswordScreen = '/forgot-password-screen';
  static const String profileScreen = '/profile-screen';
  static const String paymentScreen = '/payment-screen';
  static const String changePasswordScreen = '/change-password-screen';
  static const String storeScreen = '/store-screen';
  static const String stepbystepScreen = '/step-by-step-screen';
  static const String manageSubScreen = '/manage-sub-screen';
  static const String notificationList = '/notification-list';
  static const String notificationScreen = '/notification-screen';
  static const String recordsScreen = '/records-screen';
  static const String deleteAccountScreen = '/delete-account-screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return FadeRoute(page: HomePage());
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const Onboarding());
      case getStarted:
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case planDetails:
        final SubscriptionData p = settings.arguments as SubscriptionData;
        return MaterialPageRoute(
          builder: (_) => PlanDetails(
            plan: p,
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
      case notificationScreen:
        final t = settings.arguments as Data;
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(
            title: t.title ?? '',
            body: t.message ?? '',
            date: t.date ?? ''
          ),
        );
      case notificationList:
        final List<Data> msgList = settings.arguments as List<Data>;
        return MaterialPageRoute(
          builder: (_) => NotificationList(msgList),
        );
      case plans:
        final String t = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PlansScreen(
            planId: t,
          ),
        );
      case storeScreen:
        final String t = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => StoreScreen(
            planId: t,
          ),
        );
      case stepbystepScreen:
        final t = settings.arguments as List;
        final List<String> steps = t[0] as List<String>;
        final String name = t[1] as String;
        return MaterialPageRoute(
          builder: (_) => StepByStepScreen(
            steps: steps,
            mealName: name,
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
        return SlideLeftRoute(page: LoginScreen());
      case manageSubScreen:
        return SlideLeftRoute(page: SubscriptionScreen());
      case deleteAccountScreen:
        return SlideLeftRoute(page: DeleteAccountScreen());
      case forgotPasswordScreen:
        return SlideLeftRoute(page: ForgotPasswordScreen());
      case aboutScreen:
        return MaterialPageRoute(
          builder: (_) => AboutScreen(),
        );
      case profileScreen:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case recordsScreen:
        return MaterialPageRoute(
          builder: (_) => RecordsScreen(),
        );
      case paymentScreen:
        final List<dynamic> t = settings.arguments as List;
        final plan = t[0];
        final m = t[1];
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(
            plan: plan,
            type: m,
          ),
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
