import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/auth_cubit.dart';
import '../../../../routes.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/device_utils.dart';
import '../../../../utils/enums.dart';

class SetPasswordWidget extends StatelessWidget {
  const SetPasswordWidget(
      this.otpController, this.passwordController, this.userId, this.formKey,
      {super.key});

  final TextEditingController otpController;
  final TextEditingController passwordController;
  final String userId;
  final formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lock_person_outlined,
                  size: 25,
                ),
                CustomLayout.mPad.sizedBoxW,
                Expanded(
                  child: Text(
                    'Forgot Password',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color:
                            AppColour(context).primaryColour.withOpacity(0.7),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            CustomLayout.xlPad.sizedBoxH,
            Text('Enter OTP', style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Email';
                }
                return null;
              },
            ),
            Text('Enter New Password',
                style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter New Password';
                }
                return null;
              },
            ),
            Text('Confirm New Password',
                style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    passwordController.text != value) {
                  return 'Password does not match';
                }
                return null;
              },
            ),
            CustomLayout.xxlPad.sizedBoxH,
            ElevatedButton(
              onPressed: () async {
                DeviceUtils.hideKeyboard(context);
                if (formKey.currentState!.validate()) {
                  context.read<AuthCubit>().setPassword(
                      passwordController.text, userId, otpController.text);
                }
              },
              child: const Text('Continue'),
            ),
            CustomLayout.lPad.sizedBoxH,
            Center(
              child: SizedBox(
                height: CommonUtils.sh(context, s: 0.4),
                child: GestureDetector(
                  onTap: () =>
                      Navigator.popAndPushNamed(context, Routes.loginScreen),
                  child: RichText(
                    text: TextSpan(
                      text: 'I know my password.',
                      children: [
                        TextSpan(
                          text: ' Login Now!',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColour(context).primaryColour,
                                  ),
                        )
                      ],
                      style: Theme.of(context).textTheme.bodyMedium!,
                    ),
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
