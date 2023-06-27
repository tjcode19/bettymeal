import 'dart:io';

import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/meal_cubit.dart';
import '../../../cubit/sub_cubit.dart';
import '../../../cubit/timetable_cubit.dart';
import '../../../data/shared_preference.dart';
import '../../../routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/device_utils.dart';
import '../../../utils/enums.dart';
import '../../../utils/noti.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final SharedPreferenceApp sharedPreference = SharedPreferenceApp();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exit(0); // Return a future value to allow the back navigation
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: CommonUtils.sh(context, s: 0.3),
                padding: EdgeInsets.only(
                    top: CommonUtils.xlpadding,
                    left: CommonUtils.padding,
                    right: CommonUtils.padding),
                decoration: BoxDecoration(
                  color: AppColour(context).primaryColour,
                  image: DecorationImage(
                      image: AssetImage('assets/images/6.png'),
                      fit: BoxFit.cover,
                      opacity: 0.1),
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(20),
                    bottom: Radius.elliptical(CommonUtils.sw(context), 40.0),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.apply(
                        displayColor: Colors.white, bodyColor: Colors.white),
                  ),
                  child: Container(
                    child: Image.asset(
                      'assets/images/5.png',
                      width: CommonUtils.sw(context, s: 0.6),
                      height: CommonUtils.sh(context, s: 0.2),
                    ),
                  ),
                ),
              ),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoading) {
                    Notificatn.showLoading(context, title: 'Loading');
                  }
                  if (state is AuthError) {
                    Notificatn.showErrorModal(context, errorMsg: state.msg);
                  }
                  if (state is LoginSuccess) {
                    Notificatn.hideLoading();
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      context.read<DashboardCubit>().prepareDashboard();
                      context.read<TimetableCubit>().getTimeableApi();
                      context.read<SubCubit>().getSubscription();
                      context.read<MealCubit>().getAllMeal();
                    });

                    Navigator.popAndPushNamed(context, Routes.home);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lock,
                              size: 25,
                            ),
                            CustomLayout.mPad.sizedBoxW,
                            Expanded(
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: AppColour(context)
                                            .primaryColour
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        CustomLayout.xlPad.sizedBoxH,
                        Text('Enter Email',
                            style: Theme.of(context).textTheme.titleMedium),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            }
                            return null;
                          },
                        ),
                        CustomLayout.mPad.sizedBoxH,
                        Text('Enter Password',
                            style: Theme.of(context).textTheme.titleMedium),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                        ),
                        CustomLayout.xlPad.sizedBoxH,
                        TextButton(
                          onPressed: () {
                            // context.read<cs.UserCubit>().sendOtp(widget.email);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: AppColour(context).primaryColour),
                          ),
                        ),
                        CustomLayout.lPad.sizedBoxH,
                        ElevatedButton(
                          onPressed: () async {
                            DeviceUtils.hideKeyboard(context);
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                  _emailController.text,
                                  _passwordController.text);
                            }
                          },
                          child: const Text('Login'),
                        ),
                        CustomLayout.lPad.sizedBoxH,
                        Center(
                          child: SizedBox(
                            height: CommonUtils.sh(context, s: 0.4),
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, Routes.getStarted),
                              child: RichText(
                                text: TextSpan(
                                  text: 'No Profile Yet?',
                                  children: [
                                    TextSpan(
                                      text: ' Create Now!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColour(context)
                                                .primaryColour,
                                          ),
                                    )
                                  ],
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
