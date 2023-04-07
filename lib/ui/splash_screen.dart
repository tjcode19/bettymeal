import 'dart:async';

import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/food_cubit.dart';
import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void finishSplashScreen() async {
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
    Timer(const Duration(seconds: 5), () {
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
                Image.asset('assets/images/bf.jpg'),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!,
                        // .copyWith(color: AppColour(context).secondaryColour),
                    text: 'Meal',
                    children: [
                      TextSpan(text: 'ble'),
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
