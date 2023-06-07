import 'package:flutter/material.dart';

class AppColour {
  AppColour(this.context);

  BuildContext context;

  Color get primaryColour => Theme.of(context).colorScheme.primary;
  Color get onPrimaryColour => Theme.of(context).colorScheme.onPrimary;

  Color get primaryLightColour => Color(0xff8EE2BF);
  Color get onPrimaryLightColour => Theme.of(context).colorScheme.onPrimary;

  Color get secondaryColour => Theme.of(context).colorScheme.secondary;
  Color get onSecondaryColour => Theme.of(context).colorScheme.onSecondary;

  Color get cardColor =>
      Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.2);
  Color get onBackground => Theme.of(context).colorScheme.onBackground;

  Color get errorColor => Color.fromARGB(255, 222, 7, 7);
}
