import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colours.dart';
import '../../../utils/constants.dart';
import '../../../utils/enums.dart';

class StepTwo extends StatelessWidget {
  const StepTwo(this.onChange, {super.key});

  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColour(context).secondaryColour,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLayout.xlPad.sizedBoxH,
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color:
                          AppColour(context).onPrimaryColour.withOpacity(0.6),
                      fontSize: 20),
                  text: 'Have you been ',
                  children: [
                    TextSpan(
                      text: 'Thinking ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColour(context).onPrimaryColour),
                    ),
                    TextSpan(
                      text: 'on how to ',
                      style: TextStyle(
                        color:
                            AppColour(context).onPrimaryColour.withOpacity(0.6),
                      ),
                    ),
                    TextSpan(
                      text: 'Plan ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColour(context).onPrimaryColour),
                    ),
                    TextSpan(
                      text: 'your meal/diet/menu for a \n',
                      style: TextStyle(
                        color:
                            AppColour(context).onPrimaryColour.withOpacity(0.6),
                      ),
                    ),
                    TextSpan(
                      text: 'day/week/month?',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        onChange(0);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.keyboard_arrow_left,
                              color: AppColour(context).secondaryColour),
                          Text(
                            'Back',
                            style: TextStyle(
                                color: AppColour(context).secondaryColour),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        onChange(2);
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(Icons.keyboard_arrow_right, color: Colors.white)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
