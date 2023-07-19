import 'package:bettymeals/ui/widgets/food_card_footer.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/api/models/GetTimetable.dart';
import '../../utils/colours.dart';
import 'food_card_head.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.food, required this.period});

  final Meals food;
  final String period;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      // Get the available height
      double availableHeight = constraints.maxHeight;

      // Calculate the height of the container based on the available height
      double containerHeight = availableHeight * 0.6;
      double textSize = (availableHeight * 0.4) * 0.15;

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: containerHeight,
            padding: EdgeInsets.all(CommonUtils.padding),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    '${food.meal!.imageUrl}',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.6),
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(20),
                bottom: Radius.elliptical(CommonUtils.sw(context), 50.0),
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                textTheme: Theme.of(context)
                    .textTheme
                    .apply(displayColor: Colors.white, bodyColor: Colors.white),
              ),
              child: FoodCardHead(
                food: food,
                foodType: 0,
                mealType: period,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: CommonUtils.padding),
              child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.apply(
                        displayColor: AppColour(context).onSecondaryColour,
                        bodyColor: AppColour(context).onSecondaryColour),
                  ),
                  child: FoodCardFooter(
                    meal: food.meal!,
                    extra: [],
                    textSize: textSize,
                  )),
            ),
          )
        ],
      );
    });
  }
}
