import 'package:bettymeals/data/api/models/GetSubscription.dart';
import 'package:bettymeals/data/api/models/GetTimetable.dart';
import 'package:bettymeals/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../cubit/food_cubit.dart';
import '../../../../cubit/timetable_cubit.dart';
import '../../../../routes.dart';
import '../../../../utils/colours.dart';
import '../../../cubit/user_cubit.dart' as cs;

import 'package:badges/badges.dart' as badges;

import '../../../cubit/user_cubit.dart' as user;
import '../../../cubit/user_cubit.dart';
import '../../../utils/constants.dart';
import '../../data/api/models/MealResponse.dart';
import 'plan_details/widgets/features.dart';

class MealDetails extends StatefulWidget {
  const MealDetails({required this.meal, super.key});

  final MealData meal;

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  String gender = 'None';
  @override
  void initState() {
    super.initState();

    context.read<UserCubit>().getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: CommonUtils.sh(context, s: 0.3),
            padding: EdgeInsets.only(
                top: CommonUtils.xlpadding,
                left: CommonUtils.padding,
                right: CommonUtils.padding),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/1410235/pexels-photo-1410235.jpeg?auto=compress&cs=tinysrgb&w=1200'),
                  fit: BoxFit.cover,
                  opacity: 0.5),
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
              child: Column(
                children: [
                  CustomLayout.lPad.sizedBoxH,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: CircleAvatar(
                            backgroundColor: AppColour(context).secondaryColour.withOpacity(0.4),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Row(
                            children: [
                              for (String a in widget.meal.category!)
                                Text(
                                  a + ' ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomLayout.xxlPad.sizedBoxH,
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: AppColour(context).secondaryColour,
                            width: 2.0),
                      ),
                    ),
                    child: Text(
                      widget.meal.name!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColour(context).onPrimaryColour,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLayout.lPad.sizedBoxH,
                  Text(
                    'Description',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.meal.description}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                  CustomLayout.lPad.sizedBoxH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Complementary Meals',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            for (String a in widget.meal.extra!)
                              FeatureText(
                                a,
                                iconColor: AppColour(context)
                                    .secondaryColour
                                    .withOpacity(0.6),
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Nutrients',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              for (String a in widget.meal.nutrients!)
                                Text(a,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget badgeer(
      {required int typeId,
      required Widget badgeContent,
      required Widget label}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.addFood, arguments: typeId);
      },
      child: badges.Badge(
        badgeContent: badgeContent,
        badgeStyle: badges.BadgeStyle(
          badgeColor: AppColour(context).primaryColour,
          padding: const EdgeInsets.all(8),
          borderSide:
              BorderSide(color: AppColour(context).primaryColour, width: 1),
        ),
        child: Chip(
          label: label,
          side: BorderSide(color: AppColour(context).primaryColour),
        ),
      ),
    );
  }
}
