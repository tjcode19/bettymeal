import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../cubit/auth_cubit.dart';
import '../../../routes.dart';
import '../../../utils/colours.dart';
import '../../../utils/device_utils.dart';
import '../../../utils/enums.dart';
import '../../../utils/noti.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _oldController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(10, 56),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CommonUtils.spadding, vertical: 0.0),
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
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              Notificatn.showLoading(context, title: 'Loading');
            }
            if (state is AuthError) {
              Notificatn.showErrorModal(context, errorMsg: state.msg);
            }
            if (state is ChangePasswordSuccess) {
              Notificatn.hideLoading();

              Notificatn.showSuccessToast(context, toastPosition: EasyLoadingToastPosition.top);

              Navigator.pop(context);
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
                      Icon(Icons.lock,
                          size: 25,
                          color: AppColour(context)
                              .onSecondaryColour
                              .withOpacity(0.5)),
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
                  Text('Current Password',
                      style: Theme.of(context).textTheme.titleMedium),
                  TextFormField(
                    controller: _oldController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Current Password';
                      }
                      return null;
                    },
                  ),
                  CustomLayout.mPad.sizedBoxH,
                  Text('New Password',
                      style: Theme.of(context).textTheme.titleMedium),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter New Password';
                      }

                      return null;
                    },
                  ),
                  CustomLayout.mPad.sizedBoxH,
                  Text('Confirm Password',
                      style: Theme.of(context).textTheme.titleMedium),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password';
                      }
                      if (value != _passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  CustomLayout.xlPad.sizedBoxH,
                  ElevatedButton(
                    onPressed: () async {
                      DeviceUtils.hideKeyboard(context);
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().changePassword(
                            _oldController.text, _passwordController.text);
                      }
                    },
                    child: const Text('Change Password'),
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
