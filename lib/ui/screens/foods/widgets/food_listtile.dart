import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../data/api/models/MealResponse.dart';
import '../../../../routes.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({super.key, required this.meal , required this.w});

  final MealData meal;
  final double w;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, Routes.mealDetails, arguments: meal),
      child: Container(
        width: CommonUtils.sw(context),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
        child: Row(
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider('${meal.imageUrl}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                  ),
                ),
                CommonUtils.spaceW,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          meal.name!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        CommonUtils.spaceW,
                        GestureDetector(
                          onTap: () {
                            Notificatn.showSuccessToast(
                              context,
                              msg: 'Meal added to your favourite list',
                              toastPosition: EasyLoadingToastPosition.top,
                            );
                          },
                          child: Icon(
                            Icons.favorite_border,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: w,
                      child: Text(
                        "with ${meal.extra!.join(' / ')}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.7),
                            ),
                        overflow: TextOverflow
                            .ellipsis, // Add this line to handle overflow
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
