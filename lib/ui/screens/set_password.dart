import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/meal_cubit.dart';
import '../../cubit/sub_cubit.dart';
import '../../cubit/timetable_cubit.dart';
import '../../data/shared_preference.dart';
import '../../routes.dart';
import '../../utils/device_utils.dart';
import '../../utils/enums.dart';
import '../../cubit/user_cubit.dart' as cs;
import '../../utils/noti.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({required this.userId, required this.email, Key? key})
      : super(key: key);

  final String userId;
  final String email;

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final SharedPreferenceApp sharedPreference = SharedPreferenceApp();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          'Set Password',
          style: TextStyle(color: AppColour(context).onPrimaryColour),
        ),
        backgroundColor: AppColour(context).primaryColour,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocListener<cs.UserCubit, cs.UserState>(
              listener: (context, state) {
                if (state is cs.UserLoading) {
                  Notificatn.showLoading(context, title: 'Loading');
                }
                if (state is cs.UserError) {
                  Notificatn.showErrorModal(context, errorMsg: state.msg);
                }
                // if (state is cs.VerifyEmailSuccess) {
                //   Notificatn.hideLoading();

                //   Navigator.pushNamed(context, Routes.home);
                // }
                if (state is cs.GetUser) {
                  Notificatn.hideLoading();
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    context.read<TimetableCubit>().getTimeableApi();
                    context.read<SubCubit>().getSubscription();
                    context.read<MealCubit>().getAllMeal();
                  });

                  Navigator.pushNamed(context, Routes.home);
                }
                if (state is cs.SendOtpSuccess) {
                  Notificatn.showSuccessToast(context,
                      msg: 'OTP Sent Successfully');

                  Notificatn.hideLoading();
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
                                text:
                                    'An OTP was sent to your email for email verification. Kindly enter the OTP below and set',
                                children: [
                                  TextSpan(
                                    text: ' your password ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppColour(context)
                                                .secondaryColour),
                                  ),
                                  TextSpan(
                                    text:
                                        'as you will need to authenticate with your ',
                                  ),
                                  TextSpan(
                                    text: 'email and password ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppColour(context)
                                                .secondaryColour),
                                  ),
                                  TextSpan(
                                    text: 'going forward.',
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      CustomLayout.xlPad.sizedBoxH,
                      TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: 'Enter OTP', hintText: '093743'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter OTP';
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
                      CustomLayout.mPad.sizedBoxH,
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Enter Password Again',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Same Password As Above';
                          }
                          return null;
                        },
                      ),
                      CustomLayout.xlPad.sizedBoxH,
                      TextButton(
                        // style: TextButton.styleFrom(
                        //     side: BorderSide(
                        //         color: AppColour(context).primaryColour)),
                        onPressed: () {
                          context.read<cs.UserCubit>().sendOtp(widget.email);
                        },
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                              color: AppColour(context).primaryColour),
                        ),
                      ),
                      CustomLayout.lPad.sizedBoxH,
                      ElevatedButton(
                        onPressed: () async {
                          DeviceUtils.hideKeyboard(context);
                          if (_formKey.currentState!.validate()) {
                            context.read<cs.UserCubit>().verifyEmail(
                                _otpController.text,
                                _passwordController.text,
                                widget.userId);
                          }
                        },
                        child: const Text('Continue'),
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
