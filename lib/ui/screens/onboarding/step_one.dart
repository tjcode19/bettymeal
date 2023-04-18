import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/enums.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../../cubit/food_cubit.dart';
import '../../../cubit/timetable_cubit.dart';
import '../../../routes.dart';
import '../../../utils/colours.dart';

class StepOne extends StatefulWidget {
  const StepOne({required this.onChange, super.key});

  final Function onChange;

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  bool isOkay = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FoodCubit>().getAllMeals();
  }

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

              // Image(
              //   width: 24,
              //   height: 24,
              //   image: Svg(
              //     'assets/icons/conf.svg',
              //     color: Colors.white,
              //   ),
              // ),
              CustomLayout.xlPad.sizedBoxH,
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onChange(1);
                  },
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget badgeer({required Widget badgeContent, required Widget label}) {
    return badges.Badge(
      badgeContent: badgeContent,
      badgeStyle: badges.BadgeStyle(
        badgeColor: AppColour(context).primaryColour,
        padding: const EdgeInsets.all(8),
        borderSide: const BorderSide(color: Colors.white, width: 1),
      ),
      child: Chip(label: label),
    );
  }
}
