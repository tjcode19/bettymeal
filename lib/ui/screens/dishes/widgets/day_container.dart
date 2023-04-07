import 'package:bettymeals/data/models/food.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';

class DayContainer extends StatelessWidget {
  const DayContainer({
    super.key,
    required this.day,
    required this.food,
  });

  final String day;
  final List<FoodModel> food;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CommonUtils.sh(context, s: 0.3),
      width: CommonUtils.sw(context),
      padding: EdgeInsets.all(CommonUtils.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: TextStyle(color: AppColour(context).onBackground),
          ),
          CommonUtils.spaceHm,
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: food.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: CommonUtils.spadding),
                        // height: 200,
                        width: CommonUtils.sw(context, s: 0.3),
                        decoration: BoxDecoration(
                          // border: Border.all(width: 5),
                          borderRadius:
                              BorderRadius.circular(20), //<-- SEE HERE
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(CommonUtils.sw(context,
                                      s: 0.3)), // Image radius
                                  child: Image.network(food[index].image,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Text(
                              food[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: AppColour(context).onBackground),
                            ),
                            Text(
                              food[index].description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColour(context).onBackground),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
