import 'package:bettymeals/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../cubit/food_cubit.dart';
import '../../../cubit/timetable_cubit.dart';
import '../../../routes.dart';
import '../../../utils/colours.dart';
import '../../cubit/user_cubit.dart' as cs;

import 'package:badges/badges.dart' as badges;

import '../../cubit/user_cubit.dart' as user;
import '../../cubit/user_cubit.dart';
import '../../utils/constants.dart';

class FoodSetup extends StatefulWidget {
  const FoodSetup({super.key});

  @override
  State<FoodSetup> createState() => _FoodSetupState();
}

class _FoodSetupState extends State<FoodSetup> {
  String gender = 'None';
  @override
  void initState() {
    super.initState();

    context.read<UserCubit>().getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<user.UserCubit, user.UserState>(
          builder: (context, state) {
            String name = 'NA';

            if (state is user.GetUser) {
              name = state.name;
            }
            return RichText(
              text: TextSpan(
                text: 'Welcome ',
                children: [
                  TextSpan(
                    text: name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColour(context)
                              .onPrimaryColour
                              .withOpacity(0.7),
                        ),
                  )
                ],
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColour(context).onPrimaryColour),
              ),
            );
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColour(context).primaryColour,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocListener<cs.UserCubit, cs.UserState>(
            listener: (context, state) {},
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tell us your foods',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: AppColour(context).secondaryColour),
                  ),
                  // CustomLayout.sPad.sizedBoxH,
                  Text(
                      'To generate a meal table that is dynamic, input at least 3 foods for each meal delight.',
                      style: Theme.of(context).textTheme.bodyLarge),
                  CustomLayout.xlPad.sizedBoxH,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline),
                      CustomLayout.mPad.sizedBoxW,
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 13,
                                color: Colors.black87),
                            text: 'Tap on any meal to add more food. \n ',
                            children: [
                              TextSpan(
                                text: 'For example: tap ',
                              ),
                              TextSpan(
                                text: 'breakfast ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color:
                                            AppColour(context).secondaryColour),
                              ),
                              TextSpan(
                                text: 'to add food to breakfast list',
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  CustomLayout.sPad.sizedBoxH,
                  BlocConsumer<FoodCubit, FoodState>(
                    listener: (context, state) {
                      if (state is FoodLoaded) {
                        if (state.bf.length >= 3 &&
                            state.ln.length >= 3 &&
                            state.dn.length >= 3) {
                          // isOkay = true;
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is FoodLoaded) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: CommonUtils.padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              badgeer(
                                typeId: 3,
                                badgeContent: Text(
                                  (state.bf.length +
                                          state.ln.length +
                                          state.dn.length)
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                label: const Text(
                                  'All',
                                ),
                              ),
                              badgeer(
                                typeId: 0,
                                badgeContent: Text(
                                  state.bf.length.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                label: const Text(
                                  'Breakfast',
                                ),
                              ),
                              badgeer(
                                typeId: 1,
                                badgeContent: Text(
                                  state.ln.length.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                label: const Text(
                                  'Lunch',
                                ),
                              ),
                              badgeer(
                                typeId: 2,
                                badgeContent: Text(
                                  state.dn.length.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                label: const Text(
                                  'Dinner',
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Text('No Record');
                      }
                    },
                  ),
                  Center(
                    child: SvgPicture.asset('assets/icons/breakfast-icon.svg',
                        width: CommonUtils.sw(context, s: 0.7),
                        // height: 13,
                        semanticsLabel: 'A red up arrow'),
                  ),
                  CustomLayout.xlPad.sizedBoxH,
                  Container(
                    padding: EdgeInsets.all(CommonUtils.padding),
                    decoration: BoxDecoration(
                      color: AppColour(context).cardColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontStyle: FontStyle.italic,
                                color: Colors.black87),
                        text:
                            'The richer the variety of culinary delights you provide, the more sumptuous and satisfying menu ',
                        children: [
                          TextSpan(
                            text: 'Meable ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: AppColour(context).secondaryColour),
                          ),
                          const TextSpan(
                            text: 'will generate 😋',
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomLayout.xlPad.sizedBoxH,
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.addFood);
                      },
                      child: const Text('Add New Food'),
                    ),
                  ),
                  // CustomLayout.lPad.sizedBoxH,
                  BlocBuilder<FoodCubit, FoodState>(
                    builder: (context, state) {
                      if (state is FoodLoaded) {
                        if (state.bf.length >= 3 &&
                            state.ln.length >= 3 &&
                            state.dn.length >= 3) {
                          return Center(
                            child: OutlinedButton(
                              onPressed: () {
                                context
                                    .read<TimetableCubit>()
                                    .generateMealTable();

                                context.read<UserCubit>().setFirstTimer(false);

                                Navigator.pushNamed(context, Routes.home);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: AppColour(context).primaryColour),
                              ),
                              child: const Text('Generate Mealtable'),
                            ),
                          );
                        }
                      }
                      return const Text('');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
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
