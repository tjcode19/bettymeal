import 'dart:async';

import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:bettymeals/data/shared_preference.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/meal_cubit.dart';
import '../cubit/sub_cubit.dart';
import '../cubit/timetable_cubit.dart';
import '../routes.dart';
import '../utils/enums.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final double sizeW = 140;
  int counter = 2;

  late AnimationController _controller;
  late Animation<double> _animation;
  final SharedPreferenceApp sharedPreference = SharedPreferenceApp();
  void finishSplashScreen() async {
    final ft = await sharedPreference.getSharedPrefs(
            sharedType: SpDataType.bool, fieldName: 'firstTimer') ??
        true;
    final token = await sharedPreference.getSharedPrefs(
        sharedType: SpDataType.String, fieldName: 'token');
    final expDate = await sharedPreference.getSharedPrefs(
        sharedType: SpDataType.String, fieldName: 'tokenExp');

    final now = DateTime.now();

    if (ft) {
      gotoOnboarding();
    } else if (token != "") {
      var expD = DateTime.parse(expDate);
      if (now.isAfter(expD)) {
        goLogin();
      } else {
        context.read<DashboardCubit>().prepareDashboard('Splash screen');
        goHome();
      }
    } else {
      goLogin();
    }
  }

  gotoOnboarding() async {
    Timer(Duration(seconds: counter), () {
      Navigator.popAndPushNamed(context, Routes.onboarding);
    });
  }

  goHome() {
    context.read<TimetableCubit>().getTimeableApi();
    context.read<SubCubit>().getSubscription();
    context.read<MealCubit>().getAllMeal('fresh');
      context.read<TimetableCubit>().getRecords();
   

    Timer(Duration(seconds: counter), () async {
      Navigator.popAndPushNamed(context, Routes.home);
    });
  }

  goLogin() {
    Timer(Duration(seconds: counter), () async {
      Navigator.popAndPushNamed(context, Routes.loginScreen);
    });
  }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    // Create the animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Specify the desired animation curve
    );

    // Start the animation when the widget is mounted
    _controller.forward();
     context.read<SubCubit>().startListening();
      context.read<SubCubit>().loadPurchases();

    finishSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          backgroundColor: AppColour(context).primaryColour,
          body: Container(
            decoration: BoxDecoration(
              color: AppColour(context).primaryColour,
              image: DecorationImage(
                  image: AssetImage('assets/images/6.png'),
                  fit: BoxFit.cover,
                  opacity: 0.1),
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(20),
                bottom: Radius.elliptical(CommonUtils.sw(context), 40.0),
              ),
            ),
            child: Stack(alignment: AlignmentDirectional.center, children: [
              Positioned(
                top: CommonUtils.sh(context, s: 0.25),
                child: SizedBox(
                  width: CommonUtils.sw(context, s: 0.7),
                  child: Column(
                    children: [
                      Opacity(
                        opacity: _animation.value,
                        child: Image.asset(
                          'assets/images/3.png',
                          semanticLabel: 'Meable Logo',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('From'),
                      Image.asset(
                        'assets/images/boll.png',
                        width: CommonUtils.sw(context, s: 0.3),
                        height: CommonUtils.sh(context, s: 0.1),
                      ),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: AppColour(context)
                                      .onPrimaryColour
                                      .withOpacity(0.6)),
                          text: 'Version',
                          children: [
                            TextSpan(
                                text: ' 1.0.0',
                                style: TextStyle(
                                    color: AppColour(context).onPrimaryColour)),
                          ],
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
        );
      },
    );
  }
}
