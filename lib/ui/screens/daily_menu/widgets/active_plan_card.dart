import 'package:bettymeals/data/api/models/GetUserDetails.dart';
import 'package:flutter/material.dart';

import '../../../../routes.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/helper.dart';

class ActivePlanCard extends StatelessWidget {
  const ActivePlanCard(this.plan, this.shuffle, {super.key});

  final ActiveSub plan;
  final int shuffle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.plans, arguments: ""),
      child: Container(
        width: CommonUtils.sw(context, s: 1),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
              padding: EdgeInsets.all(CommonUtils.spadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Active \n',
                      children: [
                        TextSpan(
                          text: plan.sub!.name,
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
                    'Shuffle',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white.withOpacity(0.7), fontSize: 12.0),
                  ),
                  Text(
                    '$shuffle Credits',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white,
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
                      text: 'Valid till' + '\n',
                      children: [
                        TextSpan(
                          text: HelperMethod.formatDate(plan.endDate),
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColour(context).primaryColour,
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
