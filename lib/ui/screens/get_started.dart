import 'package:bettymeals/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/food_cubit.dart';
import '../../../cubit/timetable_cubit.dart';
import '../../../routes.dart';
import '../../../utils/colours.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  bool isOkay = false;
  final _foodNameController = TextEditingController();

  int gender = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FoodCubit>().getAllMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Let\'s get started',
                  style: Theme.of(context).textTheme.displaySmall),
              CustomLayout.sPad.sizedBoxH,
              Text('We will like to know little about you',
                  style: Theme.of(context).textTheme.bodyLarge),
              CustomLayout.xlPad.sizedBoxH,
              Text('What is your name?',
                  style: Theme.of(context).textTheme.titleMedium),
              // CustomLayout.sPad.sizedBoxH,
              TextFormField(
                controller: _foodNameController,
              ),
              CustomLayout.xlPad.sizedBoxH,
              Text('What gender would you like to be identify with?',
                  style: Theme.of(context).textTheme.titleMedium),
              RadioListTile(
                title: const Text("Male"),
                value: 1,
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Female"),
                value: 2,
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              RadioListTile(
                title: const Text("Other"),
                value: 3,
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value!;
                  });
                },
              ),
              CustomLayout.lPad.sizedBoxH,
             
              CustomLayout.xlPad.sizedBoxH,
              Center(
                child: ElevatedButton(
                  
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.home);
                  },
                  child: const Text('Continue'),
                ),
              ),
              // BlocListener<FoodCubit, FoodState>(
              //   listener: (context, state) {
              //     if (state is FoodLoaded) {
              //       if (state.bf.length >= 3 &&
              //           state.ln.length >= 3 &&
              //           state.dn.length >= 3) {
              //         isOkay = true;
              //       }
              //     }
              //   },
              //   child: isOkay
              //       ? Center(
              //           child: OutlinedButton(
              //             onPressed: () {
              //               context.read<TimetableCubit>().generateMealTable();

              //               Navigator.pushNamed(context, Routes.home);
              //             },
              //             child: const Text('Generate Mealtable'),
              //           ),
              //         )
              //       : const Text(''),
              // )
            ],
          ),
        ),
      ),
    );
  }

  
}
