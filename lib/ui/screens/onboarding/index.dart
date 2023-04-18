import 'package:bettymeals/ui/screens/onboarding/step_one.dart';
import 'package:bettymeals/ui/screens/onboarding/step_three.dart';
import 'package:bettymeals/ui/screens/onboarding/step_two.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _controller = PageController(
    initialPage: 0,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: const [
        StepOne(),
        StepTwo(),
        StepThree(),
      ],
    );
  }
}
