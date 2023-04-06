import 'dart:async';

import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void finishSplashScreen() async {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, Routes.home);
    });
  }

  @override
  void initState() {
    super.initState();
    finishSplashScreen();
    // context.read<BaseCubit>().getTokenApi();
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
            child: Image.asset('assets/images/bf.jpg'),
          ),
        ),
      ]),
    );
  }
}
