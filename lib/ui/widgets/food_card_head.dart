import 'package:bettymeals/data/models/food.dart';
import 'package:bettymeals/data/models/timetable.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class FoodCardHead extends StatelessWidget {
  const FoodCardHead(
      {super.key,
      required this.food,
      required this.foodType,
      this.sizeW = 70.0,
      required this.mealType});

  final FoodModel food;
  final int foodType;
  final double sizeW;
  final String mealType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('$mealType : ${food.name}'),
              content: Text('Message'),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    // do something
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),

        child: Column(
          children: [
            // Image(
            //   image: Svg('assets/icons/meal.svg',
            //       color: Colors.white, size: Size(sizeW, sizeW)),
            // ),
             SvgPicture.asset('assets/icons/conf.svg',
                  colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                  semanticsLabel: 'A red up arrow'),
            Text(
              mealType,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColour(context).onPrimaryColour),
            ),
          ],
        ),
      ),
    );
  }
}
