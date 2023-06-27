import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool _isElevated = true;
  bool _isVisible = true;

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

  void _onElevatedChanged(bool value) {
    setState(() {
      _isElevated = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size(10, 56),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CommonUtils.spadding, vertical: 0.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColour(context).primaryColour.withOpacity(0.7),
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: AppColour(context).background,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(CommonUtils.spadding),
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () => Navigator.pushNamed(context, Routes.profileScreen),
              title: Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Update your name, phone number, dob, etc'),
            ),
            ListTile(
              onTap: () =>
                  Navigator.pushNamed(context, Routes.changePasswordScreen),
              title: Text(
                'Change Password',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Remember to change password to a familiar word'),
            ),
            SwitchListTile(
              title: Text(
                'Push Notification',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
              subtitle:
                  const Text('This will notify you when it\'s time to eat'),
              value: _showFab,
              onChanged: _onShowFabChanged,
            ),

            SwitchListTile(
              title: Text(
                'Notifications',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                  'Send me notification 1 hour before the next meal'),
              value: _isElevated,
              onChanged: _onElevatedChanged,
            ),

            CustomLayout.mPad.sizedBoxH,

            Divider(
              color: AppColour(context).primaryColour,
            ),
            CustomLayout.mPad.sizedBoxH,

            ListTile(
              onTap: () => Navigator.pushNamed(context, Routes.aboutScreen),
              title: Text('About Mealble'),
            ),
            ListTile(
              onTap: () => logout(),
              title: Text('Logout'),
            ),
            ListTile(
              title: Text('Delete Profile'),
            ),
            // Expanded(
            //   child: ListView(
            //     controller: _controller,
            //     children: items.toList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
