import 'dart:io';

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
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: CommonUtils.padding, vertical: 6),
        margin: EdgeInsets.symmetric(horizontal: CommonUtils.mpadding),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.5)),
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notification_important,
                  color: Colors.black.withOpacity(0.6),
                ),
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
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.profileScreen);
              },
              child: CircleAvatar(
                child: Icon(Platform.isAndroid
                    ? Icons.arrow_forward
                    : Icons.arrow_forward_ios),
                backgroundColor: Colors.black38,
              ),
            )
          ],
        ),
      ),
    );
  }
}
