import 'package:flutter/material.dart';

import '../../utils/colours.dart';
import '../../utils/constants.dart';

class FoodCardFooter extends StatelessWidget {
  const FoodCardFooter({super.key, required this.name, this.extra});

  final String name;
  final List<String>? extra;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColour(context).onBackground),
            ),
            ...?extra?.map((e) => itemRow(context, name: e)),
            // itemRow(context, name: 'Koko'),
            // itemRow(context, name: 'Kose/Bofloat/Kose bread'),
            // itemRow(context, name: 'Bread'),
          ],
        ),
        const CircleAvatar(child: Icon(Icons.arrow_forward))
      ],
    );
  }

  Widget itemRow(context, {required String name, TextStyle? style}) {
    return Row(
      children: [
        const Icon(Icons.check_circle),
        CommonUtils.spaceW,
        Text(
          name,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColour(context).onBackground),
        )
      ],
    );
  }
}
