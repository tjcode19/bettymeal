import 'package:bettymeals/utils/device_utils.dart';
import 'package:bettymeals/utils/enums.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
  final _emailController = TextEditingController();
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
            listener: (context, state) {
              if (state is cs.UserLoading) {
                Notificatn.showLoading(context, title: 'Loading');
              }
              if (state is cs.UserError) {
                Notificatn.showErrorModal(context, errorMsg: state.msg);
              }
              if (state is cs.UserSuccess) {
                Notificatn.hideLoading();
                Navigator.pushNamed(context, Routes.setPassword,
                    arguments: [state.userId, state.email]);
              }
            },
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
                  Text('Enter your email',
                      style: Theme.of(context).textTheme.titleMedium),
                  // CustomLayout.sPad.sizedBoxH,
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  // CustomLayout.xlPad.sizedBoxH,
                  // Text('What gender would you like to be identify with?',
                  //     style: Theme.of(context).textTheme.titleMedium),
                  // RadioListTile(
                  //   title: const Text("Male"),
                  //   value: 'Male',
                  //   groupValue: gender,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       gender = value!;
                  //     });
                  //   },
                  // ),
                  // RadioListTile(
                  //   title: const Text("Female"),
                  //   value: 'Female',
                  //   groupValue: gender,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       gender = value!;
                  //     });
                  //   },
                  // ),
                  // RadioListTile(
                  //   title: const Text("Other"),
                  //   value: 'Other',
                  //   groupValue: gender,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       gender = value!;
                  //     });
                  //   },
                  // ),
                  CustomLayout.lPad.sizedBoxH,

                  CustomLayout.xlPad.sizedBoxH,
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        DeviceUtils.hideKeyboard(context);
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<cs.UserCubit>()
                              .userRegistration(_emailController.text);
                        }
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
