import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';
import '../../../utils/colours.dart';
import '../../../utils/device_utils.dart';
import '../../../utils/enums.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(10, 56),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: CommonUtils.spadding, vertical: 0.0),
          child: AppBar(
            leadingWidth: 24,
            title: Text(
              'Change Password',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColour(context).primaryColour.withOpacity(0.7),
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: AppColour(context).background,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                    Icon(
                        Icons.lock,
                        size: 25,
                        color:AppColour(context).onSecondaryColour.withOpacity(0.5)),
                    CustomLayout.mPad.sizedBoxW,
                    Expanded(
                      child: Text(
                        'Enter new password',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: AppColour(context)
                                    .onSecondaryColour
                                    .withOpacity(0.5),
                                fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                CustomLayout.xlPad.sizedBoxH,
                Text('New Password',
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
                Text('Confirm Password',
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
                ElevatedButton(
                  onPressed: () async {
                    DeviceUtils.hideKeyboard(context);
                    if (_formKey.currentState!.validate()) {
                      // context.read<AuthCubit>().login(
                      //     _emailController.text,
                      //     _passwordController.text);
                    }
                  },
                  child: const Text('Change Password'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
