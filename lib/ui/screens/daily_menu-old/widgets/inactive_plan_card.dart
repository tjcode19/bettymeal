import 'package:flutter/material.dart';
import '../../../../routes.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';

class InactivePlanCard extends StatelessWidget {
  const InactivePlanCard({super.key});

  // final String planName;
  // final String expDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.plans, arguments: ""),
      child: Container(
        width: CommonUtils.sw(context, s: 1),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: AppColour(context).primaryColour,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 6,
              blurRadius: 10,
              offset: Offset(2, 3), // changes the position of the shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(CommonUtils.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Inactive\n',
                      children: [
                        TextSpan(
                          text: 'No active plan',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black.withOpacity(0.4),
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                        )
                      ],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white.withOpacity(0.7),
                          ),
                    ),
                  ),
                  CustomLayout.sPad.sizedBoxH,
                  Text(
                    'Tap to renew subcription',
                    style: TextStyle(
                      color:
                          AppColour(context).onPrimaryColour.withOpacity(0.8),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(CommonUtils.padding),
              decoration: BoxDecoration(
                color: AppColour(context).onPrimaryColour.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  bottomLeft: const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Expired' + '\n',
                      children: [
                        TextSpan(
                          text: 'Expired',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColour(context).errorColor,
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
            ),
          ],
        ),
      ),
    );
  }
}
