
import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/api/models/GetTimetable.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class FoodCardHead extends StatelessWidget {
  const FoodCardHead(
      {super.key,
      required this.food,
      required this.foodType,
      this.sizeW = 70.0,
      required this.mealType});

  final Meals food;
  final int foodType;
  final double sizeW;
  final String mealType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text('$mealType : ${food.meal!.name}'),
        //       content: Text('Message'),
        //       actions: [
        //         TextButton(
        //           child: Text('Cancel'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //         TextButton(
        //           child: Text('OK'),
        //           onPressed: () {
        //             // do something
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
      },
      child: LayoutBuilder(builder: (context, constraints) {
        double iconSize = constraints.maxHeight * 0.5;
        double textSize = constraints.maxHeight * 0.15;

        return Container(
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              // Image(
              //   image: Svg('assets/icons/meal.svg',
              //       color: Colors.white, size: Size(sizeW, sizeW)),
              // ),
              SvgPicture.asset('assets/icons/food-icon-w.svg',
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  height: iconSize,
                  semanticsLabel: 'Meal'),

              Text(
                mealType,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColour(context).onPrimaryColour,
                    fontSize: textSize),
              ),
            ],
          ),
        );
      }),
    );
  }
}
