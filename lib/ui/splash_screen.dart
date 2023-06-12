import 'dart:async';

import 'package:bettymeals/data/shared_preference.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
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

    if (ft) {
      gotoOnboarding();
    } else {
      goLogin();
    }
  }

  gotoOnboarding() {
    Timer(Duration(seconds: counter), () {
      Navigator.popAndPushNamed(context, Routes.onboarding);
    });
  }

  goHome() {
    final now = DateTime.now();
    // final timetableCubit = context.read<TimetableCubit>();

    // timetableCubit.generateMealTable();

    // Check if it's Sunday
    if (now.weekday == DateTime.sunday) {
      // Call generateMealTable() here\
      // timetableCubit.generateMealTable();
    }
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
            width: CommonUtils.sw(context, s: 0.7),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/3.png',
                  semanticLabel: 'Meable Logo',
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
                Text('By'),
                Image.asset(
                  'assets/images/boll.png',
                  width: CommonUtils.sw(context, s: 0.3),
                  height: CommonUtils.sh(context, s: 0.1),
                ),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
    );
  }
}
