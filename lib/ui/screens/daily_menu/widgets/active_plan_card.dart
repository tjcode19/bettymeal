import 'package:bettymeals/cubit/sub_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/device_utils.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/helper.dart';
import '../../../widgets/shimmer_widget.dart';

class ActivePlanCard extends StatelessWidget {
  const ActivePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubCubit, SubState>(
      builder: (context, state) {
        if (state is ActiveSuccessLoaded) {
          return Container(
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
                              text: state.data.sub!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                        ),
                      ),
                      CustomLayout.sPad.sizedBoxH,
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Regenerate \n',
                              children: [
                                TextSpan(
                                  text:
                                      '${state.regenerate} ${state.regenerate > 1 ? "Units" : "Unit"} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                )
                              ],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
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
                              text: HelperMethod.formatDate(state.data.endDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
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
          );
        } else if (state is SubLoading) {
          return Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 8.0, top: 8.0),
            child: shimmerWidget(
                row: 1, height: (DeviceUtils.height(context) * 0.6).toDouble()),
          );
        } else {
          return Text('Error, please try again later');
        }
      },
    );
  }
}
