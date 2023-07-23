import 'package:bettymeals/cubit/dashboard_cubit.dart';
import 'package:bettymeals/ui/widgets/otp_widget.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../cubit/meal_cubit.dart';
import '../../cubit/notification_cubit.dart';
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
  bool otpSet = false;

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
          otpSet ? 'Set Password' : 'Verify Email',
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
                  Notificatn.showErrorToast(context,
                      errorMsg: state.msg,
                      toastPosition: EasyLoadingToastPosition.bottom);
                  setState(() {
                    otpSet = false;
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                  });
                }
                if (state is cs.VerifyEmailSuccess) {
                  Notificatn.hideLoading();
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    context
                        .read<DashboardCubit>()
                        .prepareDashboard('Set Password Screen');
                    context.read<TimetableCubit>().getTimeableApi();
                    context.read<SubCubit>().getSubscription();
                    context.read<MealCubit>().getAllMeal();
                    context
                        .read<NotificationCubit>()
                        .subscribeToTopic(topic: 'all');
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
                padding: EdgeInsets.all(CommonUtils.padding),
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
                                    'A verification code was sent to your email for email verification. Kindly enter the CODE below and set',
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
                      if (!otpSet)
                        Column(
                          children: [
                            CustomLayout.xlPad.sizedBoxH,
                            CustomOtpField(
                              completeAction: (c) {
                                setState(() {
                                  otpSet = true;
                                  _otpController.text = c;
                                });
                              },
                              validator: (v) {
                                if (v.length < 6) {
                                  return "Invalid OTP";
                                }
                                return null;
                              },
                            ),
                            CustomLayout.lPad.sizedBoxH,
                            TextButton(
                              // style: TextButton.styleFrom(
                              //     side: BorderSide(
                              //         color: AppColour(context).primaryColour)),
                              onPressed: () {
                                context
                                    .read<cs.UserCubit>()
                                    .sendOtp(widget.email);
                              },
                              child: Text(
                                'Resend OTP',
                                style: TextStyle(
                                    color: AppColour(context).primaryColour),
                              ),
                            ),
                          ],
                        ),
                      if (otpSet)
                        Column(
                          children: [
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
                                if (value != _passwordController.text) {
                                  return 'Enter Same Password As Above';
                                }

                                return null;
                              },
                            ),
                            CustomLayout.xlPad.sizedBoxH,
                            CustomLayout.lPad.sizedBoxH,
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    // style: TextButton.styleFrom(
                                    //     side: BorderSide(
                                    //         color: AppColour(context).primaryColour)),
                                    onPressed: () {
                                      setState(() {
                                        otpSet = false;
                                      });
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color:
                                              AppColour(context).primaryColour),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      DeviceUtils.hideKeyboard(context);
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<cs.UserCubit>()
                                            .verifyEmail(
                                                _otpController.text,
                                                _passwordController.text,
                                                widget.userId);
                                      }
                                    },
                                    child: const Text('Continue'),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
