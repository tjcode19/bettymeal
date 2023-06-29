import 'package:flutter/material.dart';

import '../../../../routes.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.profileScreen),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: CommonUtils.padding),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: CommonUtils.padding, vertical: 6),
              margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.4)),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(children: [
            Icon(Icons.notification_important),
            CustomLayout.lPad.sizedBoxW,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your profile is 30% completed',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'Update your profile',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black.withOpacity(0.6),
                      ),
                ),
              ],
            )
          ],),
        ),
      ),
    );
  }
}
