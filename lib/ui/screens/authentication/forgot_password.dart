import 'package:bettymeals/data/api/models/SendOtp.dart';
import 'package:bettymeals/ui/screens/authentication/widgets/sent_otp.dart';
import 'package:bettymeals/ui/screens/authentication/widgets/set_password.dart';
import 'package:bettymeals/ui/screens/set_password.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final SharedPreferenceApp sharedPreference = SharedPreferenceApp();

  int stage = 1;
  late String userId;

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
                  if (state is SentOTPSuccess) {
                    Notificatn.hideLoading();
                    setState(() {
                      stage = 2;
                      userId = state.userId;
                    });

                    // Navigator.popAndPushNamed(context, Routes.home);
                  }
                  if (state is SetPasswordSuccess) {
                    Notificatn.hideLoading();
                    Notificatn.showSuccessToast(context,
                        msg: 'Password Set Successfully');

                    Navigator.popAndPushNamed(context, Routes.loginScreen);
                  }
                },
                child: stage == 1
                    ? SendOtpScreen(_emailController, _formKey)
                    : SetPasswordWidget(
                        _otpController, _passwordController, userId, _formKey)),
          ],
        ),
      ),
    );
  }
}
