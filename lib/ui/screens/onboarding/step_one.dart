import 'package:bettymeals/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/food_cubit.dart';
import '../../../cubit/timetable_cubit.dart';
import '../../../routes.dart';
import '../../../utils/colours.dart';

class StepOne extends StatefulWidget {
  const StepOne({super.key});

  @override
  State<StepOne> createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  bool isOkay = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FoodCubit>().getAllMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Get Started',
          style: TextStyle(color: AppColour(context).onPrimaryColour),
        ),
        centerTitle: true,
        backgroundColor: AppColour(context).primaryColour,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome to',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color:
                          AppColour(context).onPrimaryColour.withOpacity(0.6))),
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: AppColour(context).onPrimaryColour),
                  text: 'Meal',
                  children: [
                    TextSpan(
                        text: 'ble',
                        style: TextStyle(
                            color: AppColour(context)
                                .onPrimaryColour
                                .withOpacity(0.6))),
                  ],
                ),
              ),
              CustomLayout.mPad.sizedBoxH,
              const Text(
                  'Let us get you started to start enjoying thus meal app'),
              CustomLayout.lPad.sizedBoxH,
              BlocConsumer<FoodCubit, FoodState>(
                listener: (context, state) {
                  if (state is FoodLoaded) {
                    if (state.bf.length >= 3 &&
                        state.ln.length >= 3 &&
                        state.dn.length >= 3) {
                      isOkay = true;
                    }
                  }
                },
                builder: (context, state) {
                  if (state is FoodLoaded) {
                    return Row(
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
                            style: TextStyle(color: Colors.white),
                          ),
                          label: const Text(
                            'Breakfast',
                          ),
                        ),
                        badgeer(
                          badgeContent: Text(
                            state.ln.length.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          label: const Text(
                            'Lunch',
                          ),
                        ),
                        badgeer(
                          badgeContent: Text(
                            state.dn.length.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          label: const Text(
                            'Dinner',
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text('No Record');
                  }
                },
              ),
              CustomLayout.xlPad.sizedBoxH,
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.addFood);
                  },
                  child: const Text('Add meal'),
                ),
              ),
              BlocListener<FoodCubit, FoodState>(
                listener: (context, state) {
                  if (state is FoodLoaded) {
                    if (state.bf.length >= 3 &&
                        state.ln.length >= 3 &&
                        state.dn.length >= 3) {
                      isOkay = true;
                    }
                  }
                },
                child: isOkay
                    ? Center(
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<TimetableCubit>().generateMealTable();

                            Navigator.pushNamed(context, Routes.home);

                          },
                          child: const Text('Generate Mealtable'),
                        ),
                      )
                    : const Text(''),
              )
            ],
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
