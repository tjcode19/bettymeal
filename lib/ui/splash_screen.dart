import 'dart:async';

import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/data/shared_preference.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../routes.dart';
import '../utils/enums.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final double sizeW = 140;
  int counter = 5;
  final SharedPreferenceApp sharedPreference = SharedPreferenceApp();
  void finishSplashScreen() async {
    final ft = await sharedPreference.getSharedPrefs(
            sharedType: SpDataType.bool, fieldName: 'firstTimer') ??
        true;

    if (!ft) {
      gotoOnboarding();
    } else {
      goHome();
    }
  }

  gotoOnboarding() {
    Timer(Duration(seconds: counter), () {
      Navigator.pushNamed(context, Routes.onboarding);
    });
  }

  goHome() {
    final now = DateTime.now();
    final timetableCubit = context.read<TimetableCubit>();

    // timetableCubit.generateMealTable();

    // Check if it's Sunday
    if (now.weekday == DateTime.sunday) {
      // Call generateMealTable() here\
      timetableCubit.generateMealTable();
    } else {
      timetableCubit.getTimetable();
    }
    Timer(Duration(seconds: counter), () async {
      Navigator.pushNamed(context, Routes.home);
    });
  }

  @override
  void initState() {
    super.initState();

    finishSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColour(context).primaryColour,
      body: Stack(alignment: AlignmentDirectional.center, children: [
        Positioned(
          top: CommonUtils.sh(context, s: 0.25),
          child: SizedBox(
            width: CommonUtils.sw(context, s: 0.5),
            child: Column(
              children: [
                Image(
                  image: Svg('assets/icons/meal.svg',
                      color: Colors.white, size: Size(sizeW, sizeW)),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColour(context).onPrimaryColour),
                    text: 'Meal',
                    children: [
                      TextSpan(
                          text: 'ble',
                          style: TextStyle(
                              color: AppColour(context)
                                  .onPrimaryColour
                                  .withOpacity(0.5))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
