import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/device_utils.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/auth_cubit.dart';
import '../../../routes.dart';
import '../../../utils/colours.dart';
import '../../../utils/enums.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  TextEditingController _deleteMe = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600), // Adjust the duration as needed
      reverseDuration: Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Account',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColour(context).secondaryColour.withOpacity(0.7),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColour(context).background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(CommonUtils.lpadding),
          child: Column(
            children: [
              Text(
                'We are sorry to see you go!!!',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              CustomLayout.xlPad.sizedBoxH,
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  );
                },
                child: Icon(
                  Icons.heart_broken,
                  size: 100,
                  color: Colors.red, // Change the color as needed
                ),
              ),
              Text(
                'Please note that this action is not reversible and all your information will be deleted from out database and your current subscription, if any, will be cancelled automatically',
                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
              ),
              CustomLayout.xlPad.sizedBoxH,
              RichText(
                text: TextSpan(
                  text: 'Type ',
                  children: [
                    TextSpan(
                      text: 'DELETE ACCOUNT',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: ' in the field below')
                  ],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.black.withOpacity(0.8),
                      ),
                ),
              ),
              CustomLayout.mPad.sizedBoxH,
              TextFormField(
                controller: _deleteMe,
              ),
              CustomLayout.mPad.sizedBoxH,
              ElevatedButton(
                onPressed: () async {
                  DeviceUtils.hideKeyboard(context);
                  if (_deleteMe.text == "DELETE ACCOUNT") {
                    // context.read<UserCubit>().updateUser({
                    //   "firstName": _firstNameController.text,
                    //   "lastName": _lastNameController.text,
                    //   "dob": _dobController.text,
                    //   "gender": _gender,
                    //   "phoneNumber": _phoneNumberController.text
                    // });
                    context.read<AuthCubit>().logout();
                    Navigator.pushReplacementNamed(context, Routes.loginScreen);
                  } else {
                    Notificatn.showErrorToast(context,
                        errorMsg: 'You must enter DELETE ACCOUNT');
                  }
                },
                child: const Text('Delete Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
