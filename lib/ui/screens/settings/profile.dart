import 'package:bettymeals/cubit/user_cubit.dart' as sd;
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/dashboard_cubit.dart';
import '../../../cubit/user_cubit.dart';
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
  final _phoneNumberController = TextEditingController();
  String _email = '';

  String _gender = 'A';
  DateTime currentDate = DateTime.now().subtract(Duration(days: 365 * 12));
  DateTime firstDate = DateTime.now().subtract(Duration(days: 365 * 100));

  DateTime lastDate = DateTime.now().subtract(Duration(days: 365 * 10));
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        final currentD = HelperMethod.formatDate(pickedDate.toIso8601String(),
            pattern: 'yyyy-MM-dd');
        _dobController.text = currentD;
      });
  }

  _selectGender(v) {
    setState(() {
      _gender = v;
    });
  }

  @override
  void initState() {
    context.read<sd.UserCubit>().spGetUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 24,
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColour(context).primaryColour.withOpacity(0.7),
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColour(context).background,
        ),
        body: SingleChildScrollView(
          child: BlocListener<sd.UserCubit, sd.UserState>(
              listener: (context, state) {
                if (state is sd.SpGetData) {
                  _firstNameController.text = state.uData.user!.firstName!;
                  _lastNameController.text = state.uData.user!.lastName!;
                  _phoneNumberController.text = state.uData.user!.phoneNumber ?? '';
                  _gender = state.uData.user!.gender??'';
                  _dobController.text = state.uData.user!.dob??'';
                  setState(() {
                    _email = state.email;
                  });
                } else if (state is sd.UserLoading) {
                  Notificatn.showLoading(context, title: 'Updating Profile');
                } else if (state is sd.UpdateUserSuccess) {
                  context
                      .read<DashboardCubit>()
                      .prepareDashboard('Profile Screen');
                  Notificatn.showSuccessToast(context,
                      msg: 'Profile updated successfully');
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
                      Text(
                        'Username',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.7),
                            ),
                      ),
                      Text(_email,
                          style: Theme.of(context).textTheme.titleMedium),
                      CustomLayout.mPad.sizedBoxH,
                      Text(
                        'First Name',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.7),
                            ),
                      ),
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
                      Text(
                        'Last Name',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.7),
                            ),
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter LastName';
                          }
                          return null;
                        },
                      ),
                      CustomLayout.mPad.sizedBoxH,
                      Text(
                        'Date Of Birth',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.7),
                            ),
                      ),
                      TextFormField(
                        controller: _dobController,
                        onTap: () => _selectDate(context),
                        readOnly: true,
                      ),
                      CustomLayout.mPad.sizedBoxH,
                      Text(
                        'Phone Number',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.7),
                            ),
                      ),
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
                      Text(
                        'Gender',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black.withOpacity(0.7),
                            ),
                      ),
                      Row(
                        children: [
                          Text('Male'),
                          Radio(
                              value: 'M',
                              groupValue: _gender,
                              onChanged: (v) => _selectGender(v)),
                          Text('Female'),
                          Radio(
                              value: 'F',
                              groupValue: _gender,
                              onChanged: (v) => _selectGender(v)),
                          Text('Others'),
                          Radio(
                              value: 'O',
                              groupValue: _gender,
                              onChanged: (v) => _selectGender(v)),
                        ],
                      ),
                      CustomLayout.mPad.sizedBoxH,
                      ElevatedButton(
                        onPressed: () async {
                          DeviceUtils.hideKeyboard(context);
                          if (_formKey.currentState!.validate()) {
                            context.read<UserCubit>().updateUser({
                              "firstName": _firstNameController.text,
                              "lastName": _lastNameController.text,
                              "dob": _dobController.text,
                              "gender": _gender,
                              "phoneNumber": _phoneNumberController.text
                            });
                          }
                        },
                        child: const Text('Update Profile'),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
