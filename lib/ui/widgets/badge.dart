import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../utils/colours.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge(
      {super.key,
      required this.onTap,
      required this.badgeContent,
      required this.label});

  final Function() onTap;
  final Widget badgeContent;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: badges.Badge(
        badgeContent: badgeContent,
        badgeStyle: badges.BadgeStyle(
          badgeColor: AppColour(context).primaryColour,
          padding: const EdgeInsets.all(8),
          borderSide:
              BorderSide(color: AppColour(context).primaryColour, width: 1),
        ),
        child: Chip(
          label: label,
          side: BorderSide(color: AppColour(context).primaryColour),
        ),
      ),
    );
  }
}
