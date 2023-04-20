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
import '../../utils/constants.dart';

class FoodSetup extends StatefulWidget {
  const FoodSetup({super.key});

  @override
  State<FoodSetup> createState() => _FoodSetupState();
}

class _FoodSetupState extends State<FoodSetup> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String gender = 'None';
  @override
  void initState() {
    super.initState();
    // context.read<FoodCubit>().getAllMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            // Text(
            //   'Welcome, Tolulope',
            //   style: Theme.of(context)
            //       .textTheme
            //       .titleLarge!
            //       .copyWith(color: AppColour(context).onPrimaryColour),
            // ),
            BlocBuilder<user.UserCubit, user.UserState>(
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
                  CustomLayout.sPad.sizedBoxH,
                  Text(
                      'To generate a meal table that is dynamic, we need you to enter at list 3 food for each meal',
                      style: Theme.of(context).textTheme.bodyLarge),
                  CustomLayout.xlPad.sizedBoxH,
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
                                badgeContent: Text(
                                  state.bf.length.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                label: const Text(
                                  'Breakfast',
                                ),
                              ),
                              badgeer(
                                badgeContent: Text(
                                  state.ln.length.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                label: const Text(
                                  'Lunch',
                                ),
                              ),
                              badgeer(
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
                  Text(
                    'The more food you tell us, the more robust the meal table we will give you 🤣',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  CustomLayout.sPad.sizedBoxH,
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.addFood);
                      },
                      child: const Text('Add Food'),
                    ),
                  ),
                  CustomLayout.xlPad.sizedBoxH,
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

                                Navigator.pushNamed(context, Routes.home);
                              },
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

  Widget badgeer({required Widget badgeContent, required Widget label}) {
    return badges.Badge(
      badgeContent: badgeContent,
      badgeStyle: badges.BadgeStyle(
        badgeColor: AppColour(context).primaryColour,
        padding: const EdgeInsets.all(8),
        borderSide: const BorderSide(color: Colors.white, width: 1),
      ),
      child: Chip(label: label),
    );
  }
}
