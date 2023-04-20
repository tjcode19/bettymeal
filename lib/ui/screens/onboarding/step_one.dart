import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../../cubit/food_cubit.dart';
import '../../../routes.dart';
import '../../../utils/colours.dart';

class StepOne extends StatelessWidget {
  const StepOne(this.onChange, {super.key});

  final Function onChange;

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
              Text('Welcome 🤗',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: AppColour(context).onPrimaryColour)),
              const Divider(
                thickness: 2,
                color: Colors.white30,
              ),
              CustomLayout.xlPad.sizedBoxH,
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color:
                          AppColour(context).onPrimaryColour.withOpacity(0.8),
                      fontSize: 20),
                  text: 'Not too sure of what to eat ',
                  children: [
                    TextSpan(
                      text: 'Today? 🤔 \n',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColour(context).onPrimaryColour),
                    ),
                    TextSpan(
                      text: 'We got ',
                      style: TextStyle(
                        color:
                            AppColour(context).onPrimaryColour.withOpacity(0.8),
                      ),
                    ),
                    TextSpan(
                      text: 'You',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColour(context).onPrimaryColour),
                    ),
                    // TextSpan(
                    //   text: ' week or month?',
                    //   style: TextStyle(
                    //     color:
                    //         AppColour(context).onPrimaryColour.withOpacity(0.8),
                    //   ),
                    // ),
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
                        Navigator.pushNamed(context, Routes.getStarted);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_arrow_left,
                            color: AppColour(context).primaryColour,
                          ),
                          Text(
                            'Skip',
                            style: TextStyle(
                                color: AppColour(context).primaryColour),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        onChange(1);
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
