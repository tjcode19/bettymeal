import 'package:bettymeals/data/models/timetable.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../utils/constants.dart';

class FoodItemSub extends StatelessWidget {
  const FoodItemSub(
      {super.key,
      required this.timetable,
      required this.foodType,
      this.sizeW = 25.0,
      required this.mealType});

  final TimetableModel timetable;
  final int foodType;
  final double sizeW;
  final String mealType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: AppColour(context).secondaryColour),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mealType, style: Theme.of(context).textTheme.bodySmall),
            // Image(
            //   image: Svg('assets/icons/meal.svg',
            //       size: Size(sizeW, sizeW),
            //       color: AppColour(context).onSecondaryColour),
            // ),
             SvgPicture.asset('assets/icons/meal.svg',
                  semanticsLabel: 'A red up arrow'),
            Text(timetable.foods[foodType].name,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
