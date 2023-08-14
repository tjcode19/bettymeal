import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../utils/enums.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColour(context).background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: CommonUtils.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                        text: ' New',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColour(context)
                                .primaryColour
                                .withOpacity(0.8)),
                      ),
                    ],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                CustomLayout.xxlPad.sizedBoxH,

                Container(
                  width: CommonUtils.sw(context),
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
                      Padding(
                        padding: EdgeInsets.all(CommonUtils.padding),
                        child: Text(
                          '',
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColour(context)
                                      .onSecondaryColour
                                      .withOpacity(0.8),
                                  fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomLayout.xxlPad.sizedBoxH,

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                    ),
                  ],
                ),

                // BlocBuilder<SubCubit, SubState>(
                //   builder: (context, state) {
                //     if (state is SubSuccess) {
                //       var a = state.data.map(
                //         (e) {
                //           int pos = state.data.indexOf(e);
                //           return PlanCard(
                //             duration: "7 Days",
                //             plan: e.name!,
                //             price: e.price.toString(),
                //             showBadge: widget.planId == e.sId,
                //             background: pos == 1
                //                 ? AppColour(context)
                //                     .secondaryColour
                //                     .withOpacity(0.1)
                //                 : pos == 2
                //                     ? Colors.blue.withOpacity(0.1)
                //                     : null,
                //             onPress: () {
                //               Navigator.pushNamed(
                //                   context, Routes.planDetails,
                //                   arguments: e);
                //             },
                //           );
                //         },
                //       );

                //       return Column(children: [...a]);
                //     } else {
                //       return Text('No record');
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
