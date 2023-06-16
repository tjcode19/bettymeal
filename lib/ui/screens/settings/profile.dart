import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../routes.dart';
import '../../../utils/colours.dart';
import '../../../utils/device_utils.dart';
import '../../../utils/enums.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneNumberController = TextEditingController();

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
              'Profile',
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
                    Icon(Icons.person_3,
                        size: 25,
                        color: AppColour(context)
                            .onSecondaryColour
                            .withOpacity(0.5)),
                    CustomLayout.mPad.sizedBoxW,
                    Expanded(
                      child: Text(
                        'User Profile',
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
                Text('First Name',
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter FirstName';
                    }
                    return null;
                  },
                ),
                CustomLayout.mPad.sizedBoxH,
                Text('Last Name',
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: _lastNameController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter LastName';
                    }
                    return null;
                  },
                ),
                CustomLayout.mPad.sizedBoxH,
                Text('Date Of Birth',
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: _dobController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter DOB';
                    }
                    return null;
                  },
                ),
                CustomLayout.mPad.sizedBoxH,
                Text('Gender', style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: _genderController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Select Gender';
                    }
                    return null;
                  },
                ),
                CustomLayout.mPad.sizedBoxH,
                Text('Phone Number',
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Phone Number';
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
                  child: const Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
