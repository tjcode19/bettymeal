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
              // Text('Welcome',
              //     style: Theme.of(context)
              //         .textTheme
              //         .displayMedium!
              //         .copyWith(color: AppColour(context).onPrimaryColour)),
              CustomLayout.xlPad.sizedBoxH,
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color:
                            AppColour(context).onPrimaryColour.withOpacity(0.6),
                        fontSize: 20,
                      ),
                  text: 'Having problem ',
                  children: [
                    TextSpan(
                      text: 'Budgeting \n',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColour(context).onPrimaryColour),
                    ),
                    TextSpan(
                      text: 'for your favourite meal? \n',
                      style: TextStyle(
                        color:
                            AppColour(context).onPrimaryColour.withOpacity(0.6),
                      ),
                    ),
                    TextSpan(
                      text: 'Worry no more with ',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColour(context).onPrimaryColour),
                    ),
                    TextSpan(
                      text: 'Meable',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
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
                        changePage(1);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.keyboard_arrow_left,
                              color: AppColour(context).primaryColour),
                          Text(
                            'Back',
                            style: TextStyle(
                                color: AppColour(context).primaryColour),
                          )
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, Routes.getStarted);
                      },
                      child: Row(
                        children: const [
                          Text(
                            'Get Started',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.white)
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
