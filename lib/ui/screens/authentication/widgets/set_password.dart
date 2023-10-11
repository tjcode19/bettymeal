import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/auth_cubit.dart';
import '../../../../routes.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/device_utils.dart';
import '../../../../utils/enums.dart';

class SetPasswordWidget extends StatefulWidget {
  const SetPasswordWidget(
      this.otpController, this.passwordController, this.userId, this.formKey,
      {super.key});

  final TextEditingController otpController;
  final TextEditingController passwordController;
  final String userId;
  final formKey;

  @override
  State<SetPasswordWidget> createState() => _SetPasswordWidgetState();
}

class _SetPasswordWidgetState extends State<SetPasswordWidget> {
  bool hidePass = true;
  bool hidePassC = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.formKey,
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
            Text('Enter Code', style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              controller: widget.otpController,
              keyboardType: TextInputType.emailAddress,
              maxLength: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Verification Code';
                }
                return null;
              },
            ),
            CustomLayout.sPad.sizedBoxH,
            Text('Enter New Password',
                style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              controller: widget.passwordController,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: IconButton(
                  icon:
                      Icon(hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      hidePass = !hidePass;
                    });
                  },
                ),
              ),
              obscureText: hidePass,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter New Password';
                }
                return null;
              },
            ),
            CustomLayout.mPad.sizedBoxH,
            Text('Confirm New Password',
                style: Theme.of(context).textTheme.titleMedium),
            TextFormField(
              obscureText: hidePassC,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: IconButton(
                  icon:
                      Icon(hidePassC ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      hidePassC = !hidePassC;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    widget.passwordController.text != value) {
                  return 'Password does not match';
                }
                return null;
              },
            ),
            CustomLayout.xxlPad.sizedBoxH,
            ElevatedButton(
              onPressed: () async {
                DeviceUtils.hideKeyboard(context);
                if (widget.formKey.currentState!.validate()) {
                  context.read<AuthCubit>().setPassword(
                      widget.passwordController.text,
                      widget.userId,
                      widget.otpController.text);
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
