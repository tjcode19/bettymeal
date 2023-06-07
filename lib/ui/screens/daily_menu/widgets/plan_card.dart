import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';

class PlanCard extends StatelessWidget {
  const PlanCard(
      {required this.duration, required this.plan, this.background, super.key});

  final String plan;
  final String duration;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CommonUtils.sw(context, s: 1),
      height: CommonUtils.sh(context, s: .2),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: background ??
            AppColour(context).primaryLightColour.withOpacity(0.2),
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
              Text(plan, style: Theme.of(context).textTheme.titleLarge!),
              CustomLayout.xlPad.sizedBoxH,
              RichText(
                text: TextSpan(
                  text: 'Plan for the next \n',
                  children: [
                    TextSpan(
                      text: duration,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
          SvgPicture.asset('assets/icons/think.svg',
              width: CommonUtils.sw(context, s: .4),
              semanticsLabel: 'A red up arrow')
        ],
      ),
    );
  }
}
