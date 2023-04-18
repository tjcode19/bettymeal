import 'package:bettymeals/ui/screens/onboarding/step_one.dart';
import 'package:bettymeals/ui/screens/onboarding/step_three.dart';
import 'package:bettymeals/ui/screens/onboarding/step_two.dart';
import 'package:flutter/material.dart';

import 'dot_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  static const _kDuration = Duration(milliseconds: 500);

  static const _kCurve = Curves.ease;

  late final PageController _controller;

  changePage(int page) {
    _controller.animateToPage(
      page,
      duration: _kDuration,
      curve: _kCurve,
    );
  }

  final List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    _pages.add(ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: StepOne(changePage),
    ));
    _pages.add(ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: StepTwo(changePage),
    ));
    _pages.add(ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: StepThree(changePage),
    ));
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index % _pages.length];
          },
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            color: Colors.grey[800]!.withOpacity(0.5),
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: DotsIndicator(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageSelected: (int p) => changePage),
            ),
          ),
        ),
      ],
    );
  }
}
