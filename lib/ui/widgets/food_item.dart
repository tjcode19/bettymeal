import 'package:bettymeals/data/models/timetable.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../utils/constants.dart';

class FoodItem extends StatelessWidget {
  const FoodItem(
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
    return SizedBox(
        child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 5, 79, 116),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // border: Border.fromBorderSide(
        //   BorderSide(width: 4.0, color: AppColour(context).primaryColour),
        // ),
      ),
      child: Container(
        // width: CommonUtils.sw(context),
        padding: const EdgeInsets.all(30),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColour(context).primaryColour.withOpacity(0.8)),
        child: Column(
          children: [
            Text(mealType,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColour(context).onPrimaryColour)),
            Image(
              image: Svg('assets/icons/meal.svg',
                  color: Colors.white, size: Size(sizeW, sizeW)),
            ),
            Text(timetable.foods[foodType].name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColour(context).onPrimaryColour)),
          ],
        ),
      ),
    ));
  }
}
