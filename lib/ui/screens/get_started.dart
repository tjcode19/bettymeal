import 'package:bettymeals/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/food_cubit.dart';
import '../../../cubit/timetable_cubit.dart';
import '../../../routes.dart';
import '../../../utils/colours.dart';
import '../../cubit/user_cubit.dart' as cs;

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocListener<cs.UserCubit, cs.UserState>(
            listener: (context, state) {},
            child: SingleChildScrollView(
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
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  CustomLayout.xlPad.sizedBoxH,
                  Text('What gender would you like to be identify with?',
                      style: Theme.of(context).textTheme.titleMedium),
                  RadioListTile(
                    title: const Text("Male"),
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text("Female"),
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text("Other"),
                    value: 'Other',
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
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<cs.UserCubit>()
                              .setUserDetails(_nameController.text, gender);

                          Navigator.pushNamed(context, Routes.home);
                        }
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
        ),
      ),
    );
  }
}
