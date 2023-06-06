import 'package:bettymeals/cubit/food_cubit.dart';
import 'package:bettymeals/data/local/models/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/enums.dart';

class FoodListTile extends StatelessWidget {
  const FoodListTile({super.key, required this.meal});

  final FoodModel meal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(),
          borderRadius: BorderRadius.circular(20),
        ),
        leading: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(meal.image), fit: BoxFit.cover),
          ),
          child: const SizedBox(
            width: 50,
            height: 50,
          ),
        ),
        title: Text(meal.name, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(meal.description,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColour(context).secondaryColour)),
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
        trailing: PopupMenuButton<int>(
          onSelected: (item) {
            switch (item) {
              case 0:
                break;
              case 1:
                context.read<FoodCubit>().deleteFood(meal);
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: AppColour(context).primaryColour,
                    ),
                    CustomLayout.lPad.sizedBoxW,
                    Text('Edit'),
                  ],
                )),
            PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    CustomLayout.lPad.sizedBoxW,
                    Text(
                      'Delete',
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
