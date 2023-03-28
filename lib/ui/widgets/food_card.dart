import 'package:bettymeals/data/models/timetable.dart';
import 'package:bettymeals/ui/widgets/food_card_footer.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../utils/colours.dart';
import 'food_card_head.dart';

class FoodCard extends StatelessWidget {
  const FoodCard(
      {super.key,
      required this.timetable,
      required this.period,
      required this.img});

  final TimetableModel timetable;
  final String period;
  final String img;

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
                image: AssetImage(img), fit: BoxFit.cover, opacity: 0.4),
            borderRadius: BorderRadius.vertical(
                bottom:
                    Radius.elliptical(MediaQuery.of(context).size.width, 50.0)),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              textTheme: Theme.of(context)
                  .textTheme
                  .apply(displayColor: Colors.white, bodyColor: Colors.white),
            ),
            child: FoodCardHead(
              timetable: timetable,
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
              child: FoodCardFooter()
            ),
          ),
        )
      ],
    );
  }

 
}
