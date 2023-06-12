import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/meal_cubit.dart';
import '../../cubit/sub_cubit.dart';
import '../../cubit/timetable_cubit.dart';
import '../../data/shared_preference.dart';
import '../../routes.dart';
import '../../utils/constants.dart';
import '../../utils/device_utils.dart';
import '../../utils/enums.dart';
import '../../utils/noti.dart';

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
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 24.0,
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        title: Text(
          'Login',
          style: TextStyle(color: AppColour(context).onPrimaryColour),
        ),
        backgroundColor: AppColour(context).primaryColour,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                          Icon(Icons.info_outline),
                          CustomLayout.mPad.sizedBoxW,
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black87),
                                text: 'We need to',
                                children: [
                                  TextSpan(
                                    text: ' authenticate ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppColour(context)
                                                .secondaryColour),
                                  ),
                                  TextSpan(
                                    text: 'you',
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      CustomLayout.xlPad.sizedBoxH,
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(labelText: 'Enter Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                      ),
                      CustomLayout.mPad.sizedBoxH,
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Enter Password',
                        ),
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
                      SizedBox(
                        height: CommonUtils.sh(context, s: 0.4),
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, Routes.getStarted),
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
                                        color: AppColour(context).primaryColour,
                                      ),
                                )
                              ],
                              style: Theme.of(context).textTheme.bodyMedium!,
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
    );
  }
}
