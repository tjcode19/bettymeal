import 'package:bettymeals/utils/colours.dart';
import 'package:flutter/material.dart';

import '../../../../utils/enums.dart';

class FeatureText extends StatelessWidget {
  const FeatureText(this.text,
      {this.iconColor, this.available = true, super.key});

  final String text;
  final bool available;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        available
            ? Icon(
                Icons.check_circle_outline,
                color: iconColor ?? AppColour(context).primaryColour,
              )
            : Icon(
                Icons.remove_circle_outline_sharp,
                color: AppColour(context).errorColor,
              ),
        CustomLayout.mPad.sizedBoxW,
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 13,
                color: Colors.black87),
          ),
        )
      ],
    );
  }
}
