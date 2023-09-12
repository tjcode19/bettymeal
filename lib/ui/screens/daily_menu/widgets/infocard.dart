import 'package:bettymeals/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/enums.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CommonUtils.sw(context),
      margin: EdgeInsets.symmetric(horizontal: CommonUtils.mpadding),
      decoration: BoxDecoration(
        color: AppColour(context).onPrimaryColour,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: -50,
            child: Transform.rotate(
              angle: -30 * 0.0174533,
              child: Icon(
                Icons.tips_and_updates_outlined,
                color: Colors.grey[200],
                size: 150,
              ),
            ),
          ),
          BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
            if (state is NotificationLoad) {
              return Padding(
                  padding: EdgeInsets.all(CommonUtils.padding),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0.0),
                    dense: false,
                    title: Row(children: [
                      // Icon(Icons.tips_and_updates,
                      //     color: AppColour(context).secondaryColour),
                      SizedBox(
                          height: 20,
                          width: 4,
                          child: VerticalDivider(
                            color: AppColour(context).secondaryColour,
                            thickness: 4,
                          )),
                      CustomLayout.mPad.sizedBoxW,
                      Text(
                        '${state.data.title}',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColour(context)
                                      .secondaryColour
                                      .withOpacity(0.7),
                                ),
                      )
                    ]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomLayout.mPad.sizedBoxH,
                        Text(
                          '${state.data.message}',
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColour(context)
                                      .onSecondaryColour
                                      .withOpacity(0.8),
                                  fontSize: 15),
                        ),
                      ],
                    ),
                    //   }
                    //   else {
                    //     return Column(
                    //       children: [
                    //         CustomLayout.mPad.sizedBoxH,
                    //         Text(
                    //           'Experts recommend that males consume 15.5 cups (3.7 liters) of water daily and females 11.5 cups (2.7 liters).',
                    //           textAlign: TextAlign.justify,
                    //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    //               color: AppColour(context)
                    //                   .onSecondaryColour
                    //                   .withOpacity(0.8),
                    //               fontSize: 15),
                    //         ),
                    //       ],
                    //     );
                    //   }
                    // }),
                  ));
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }
}
