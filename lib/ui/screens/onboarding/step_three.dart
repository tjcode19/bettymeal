import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../routes.dart';
import '../../../utils/colours.dart';
import '../../../utils/constants.dart';
import '../../../utils/enums.dart';

class StepThree extends StatelessWidget {
  const StepThree(this.changePage, {super.key});

  final Function changePage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColour(context).primaryColour,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: AppColour(context).onPrimaryColour)),
              CustomLayout.mPad.sizedBoxH,
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color:
                            AppColour(context).onPrimaryColour.withOpacity(0.6),
                      ),
                  text: 'Have you always been \n',
                  children: [
                    TextSpan(
                      text: 'Thinking \n',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColour(context).onPrimaryColour),
                    ),
                    TextSpan(
                      text: ' how to plan your meal for a \n',
                      style: TextStyle(
                        color:
                            AppColour(context).onPrimaryColour.withOpacity(0.6),
                      ),
                    ),
                    TextSpan(
                      text: ' whole week or month?',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColour(context).onPrimaryColour),
                    ),
                  ],
                ),
              ),
              CustomLayout.lPad.sizedBoxH,
              Center(
                child: SvgPicture.asset('assets/icons/think.svg',
                    width: CommonUtils.sw(context),
                    // height: 13,
                    semanticsLabel: 'A red up arrow'),
              ),
              CustomLayout.xlPad.sizedBoxH,
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.addFood);
                  },
                  child: const Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
