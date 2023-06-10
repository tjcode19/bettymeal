import 'package:bettymeals/ui/widgets/food_card_footer.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../data/api/models/GetTimetable.dart';
import '../../data/local/models/food.dart';
import '../../utils/colours.dart';
import 'food_card_head.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.food, required this.period});

  final Meals food;
  final String period;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(CommonUtils.padding),
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: NetworkImage('https://images.pexels.com/photos/1410235/pexels-photo-1410235.jpeg?auto=compress&cs=tinysrgb&w=1200'),
                fit: BoxFit.cover,
                opacity: 0.4),
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
            padding: EdgeInsets.all(CommonUtils.padding),
            child: Theme(
                data: Theme.of(context).copyWith(
                  textTheme: Theme.of(context).textTheme.apply(
                      displayColor: AppColour(context).onSecondaryColour,
                      bodyColor: AppColour(context).onSecondaryColour),
                ),
                child: FoodCardFooter(
                  meal: food.meal!,
                  extra: [],
                )),
          ),
        )
      ],
    );
  }
}
