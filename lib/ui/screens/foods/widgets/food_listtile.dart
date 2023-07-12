import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../data/api/models/MealResponse.dart';
import '../../../../data/api/network_request.dart';
import '../../../../routes.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({super.key, required this.meal});

  final MealData meal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
      child: ListTile(
        onTap: () =>
            Navigator.pushNamed(context, Routes.mealDetails, arguments: meal),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.circular(10),
        ),
        minVerticalPadding: 15.0,
        leading: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black38,
            shape: BoxShape.circle,
            image: DecorationImage(
                image:
                    NetworkImage('${NetworkRequest.baseUrl}${meal.imageUrl}.png'),
                fit: BoxFit.cover),
          ),
          child: const SizedBox(
            width: 50,
            height: 50,
          ),
        ),
        title: Row(
          children: [
            Text(meal.name!, style: Theme.of(context).textTheme.titleMedium),
            CommonUtils.spaceW,
            GestureDetector(
                onTap: () {
                  Notificatn.showSuccessToast(context,
                      msg: 'Meal added to your favourite list',
                      toastPosition: EasyLoadingToastPosition.top);
                },
                child: Icon(
                  Icons.favorite_border,
                  size: 25,
                ))
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "${meal.description!.length > 60 ? meal.description!.substring(0, 60) : meal.description}...",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black.withOpacity(0.7))),
            // Text(
            //   meal.type == 0
            //       ? 'Breakfast'
            //       : meal.type == 1
            //           ? 'Lunch'
            //           : 'Dinner',
            //   style: Theme.of(context)
            //       .textTheme
            //       .bodyMedium!
            //       .copyWith(color: AppColour(context).secondaryColour),
            // ),
          ],
        ),
        // trailing: PopupMenuButton<int>(
        //   onSelected: (item) {
        //     switch (item) {
        //       case 0:
        //         break;
        //       case 1:
        //         // context.read<FoodCubit>().deleteFood(meal);
        //         break;
        //     }
        //   },
        //   itemBuilder: (context) => [
        //     PopupMenuItem<int>(
        //         value: 0,
        //         child: Row(
        //           children: [
        //             Icon(
        //               Icons.edit,
        //               color: AppColour(context).primaryColour,
        //             ),
        //             CustomLayout.lPad.sizedBoxW,
        //             Text('Edit'),
        //           ],
        //         )),
        //     PopupMenuItem<int>(
        //         value: 1,
        //         child: Row(
        //           children: [
        //             Icon(
        //               Icons.delete,
        //               color: Colors.red,
        //             ),
        //             CustomLayout.lPad.sizedBoxW,
        //             Text(
        //               'Delete',
        //             ),
        //           ],
        //         )),
        //   ],
        // ),
      ),
    );
  }
}
