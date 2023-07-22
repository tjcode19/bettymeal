import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bettymeals/cubit/user_cubit.dart' as sd;

import '../../../cubit/auth_cubit.dart';
import '../../../routes.dart';
import '../../../utils/colours.dart';
import '../../../utils/enums.dart';
import '../../widgets/custom_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _showFab = true;

  String name = '';
  String email = '';

  final List<String> tribe = [
    "Hausa",
    "Igbo",
    "Yoruba",
  ];

  final List<String?> selectedTribe = [];

  void _onShowFabChanged(bool value) {
    setState(() {
      _showFab = value;
    });
  }

  logout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Warning",
            descriptions: "Are you sure you want to log out?",
            textPos: "Yes",
            textNeg: "No",
            posAction: () {
              context.read<AuthCubit>().logout();
              Navigator.pushReplacementNamed(context, Routes.loginScreen);
            },
          );
        },
        barrierDismissible: false);
  }

  // void _onElevatedChanged(bool value) {
  //   setState(() {
  //     _isElevated = value;
  //   });
  // }

  @override
  void initState() {
    context.read<sd.UserCubit>().spGetUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Account',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColour(context).primaryColour.withOpacity(0.7),
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColour(context).background,
      ),
      body: Padding(
        padding: EdgeInsets.all(CommonUtils.spadding),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColour(context).onPrimaryLightColour.withOpacity(0.7),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: AppColour(context).secondaryColour.withOpacity(0.3),
                ),
              ),
              child: BlocListener<sd.UserCubit, sd.UserState>(
                listener: (context, state) {
                  if (state is sd.SpGetData) {
                    name =
                        '${state.uData.user?.firstName!} ${state.uData.user?.lastName!}';
                    setState(() {
                      email = state.email;
                    });

                    selectedTribe.addAll(state.uData.user!.tribes!);
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(15),
                            // ),
                          ),
                          child: Icon(
                            Icons.person_outlined,
                            size: DeviceUtils.width(context) * 0.25,
                            color: AppColour(context).onPrimaryLightColour,
                          ),
                        ),
                        CustomLayout.sPad.sizedBoxH,
                        Text(
                          name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          email,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 10,
                      child: IconButton(
                        icon: Icon(
                          Icons.edit_note_outlined,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.profileScreen);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            CustomLayout.lPad.sizedBoxH,
            Text(
              'Preferences',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold),
            ),
            CustomLayout.sPad.sizedBoxH,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColour(context).onPrimaryLightColour.withOpacity(0.7),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: AppColour(context).secondaryColour.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Show me meals from the following tribes:',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        for (final e in tribe)
                          Row(
                            children: [
                              Text(e),
                              Checkbox(
                                  value: selectedTribe.contains(e),
                                  onChanged: (v) {
                                    setState(() {
                                      if (v == true) {
                                        selectedTribe.add(e);

                                        context
                                            .read<sd.UserCubit>()
                                            .setTribesPref(
                                                selectedTribe.join(','));
                                      } else {
                                        selectedTribe.remove(e);
                                        context
                                            .read<sd.UserCubit>()
                                            .setTribesPref(
                                                selectedTribe.join(','));
                                      }
                                    });
                                  }),
                              CustomLayout.sPad.sizedBoxW,
                            ],
                          ),
                      ],
                    ),
                  ),
                  SwitchListTile(
                    title: Text(
                      'Push Notification',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                        'You will get updates from us via Push Notification'),
                    value: _showFab,
                    onChanged: _onShowFabChanged,
                  ),
                  ListTile(
                    onTap: () => Navigator.pushNamed(
                        context, Routes.changePasswordScreen),
                    title: Text(
                      'Manage Subscription',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        Text('Upgrade plan or cancel subscription'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            CustomLayout.lPad.sizedBoxH,
            Text(
              'Security',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.bold),
            ),
            CustomLayout.sPad.sizedBoxH,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColour(context).onPrimaryLightColour.withOpacity(0.7),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: AppColour(context).secondaryColour.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Navigator.pushNamed(
                        context, Routes.changePasswordScreen),
                    title: Text(
                      'Change Password',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        Text('Remember to change password to a familiar word'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
            CustomLayout.mPad.sizedBoxH,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.aboutScreen),
                  child: Text(
                    'About Mealble 1.0.0',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                    onPressed: () => logout(),
                    child: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.red.withOpacity(0.8),
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
