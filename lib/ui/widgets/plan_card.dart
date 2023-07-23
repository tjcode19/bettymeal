import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;

import '../../data/api/models/GetSubscription.dart';
import '../../utils/colours.dart';
import '../../utils/constants.dart';
import '../../utils/enums.dart';

class PlanCard extends StatelessWidget {
  const PlanCard(
      {required this.plan,
      this.background,
      this.plainId,
      this.showBadge = false,
      required this.onPress,
      super.key});

  final SubscriptionData plan;
  final Color? background;
  final String? plainId;
  final bool showBadge;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -10, end: 5),
        badgeContent: Icon(
          Icons.check_circle_outline,
          size: 25,
          color: AppColour(context).onPrimaryColour,
        ),
        showBadge: showBadge,
        badgeAnimation: badges.BadgeAnimation.rotation(
          animationDuration: Duration(seconds: 1),
          colorChangeAnimationDuration: Duration(seconds: 1),
          loopAnimation: false,
          curve: Curves.fastOutSlowIn,
          colorChangeAnimationCurve: Curves.easeInCubic,
        ),
        badgeStyle: badges.BadgeStyle(
          badgeColor: AppColour(context).primaryColour,
          padding: const EdgeInsets.all(8),
          borderSide:
              BorderSide(color: AppColour(context).onPrimaryColour, width: 1),
        ),
        child: Container(
          width: CommonUtils.sw(context, s: 1),
          // height: CommonUtils.sh(context, s: .2),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
          decoration: BoxDecoration(
            color: background?.withOpacity(0.1) ??
                AppColour(context).primaryColour.withOpacity(0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black.withOpacity(0.7)),
                  ),
                  Text(
                    plan.name!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                  ),
                  CustomLayout.lPad.sizedBoxH,
                  RichText(
                    text: TextSpan(
                      text: 'Enjoy this plan ',
                      children: [
                        TextSpan(
                          text: 'plan',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: background ??
                                        AppColour(context)
                                            .primaryColour,
                                  ),
                        ),
                        TextSpan(
                          text: " for \nas low as",
                        ),
                        TextSpan(
                          text: " \$${plan.period?.week?.price}",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        TextSpan(
                          text: ".00",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                        )
                      ],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black.withOpacity(0.7)),
                    ),
                  )
                ],
              ),
              SvgPicture.asset('assets/icons/m-free.svg',
                  width: CommonUtils.sw(context, s: .2),
                  color: background?.withOpacity(0.3) ??
                      AppColour(context).primaryColour.withOpacity(0.3),
                  semanticsLabel: 'A red up arrow')
            ],
          ),
        ),
      ),
    );
  }
}
