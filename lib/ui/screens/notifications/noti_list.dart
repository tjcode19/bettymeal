import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import '../../../data/api/models/GetNotifications.dart';
import '../../../routes.dart';
import '../../../utils/enums.dart';

class NotificationList extends StatefulWidget {
  final List<Data> msgList;
  const NotificationList(this.msgList, {super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<Data> notii = [];


  @override
  void initState() {
    super.initState();

    notii = widget.msgList;
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
                    text: 'Messages (',
                    children: [
                      TextSpan(
                        text: notii.length.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColour(context)
                                .primaryColour
                                .withOpacity(0.8)),
                      ),
                      TextSpan(
                        text: ')',
                      ),
                    ],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                CustomLayout.lPad.sizedBoxH,

                for (final n in notii)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.notificationScreen,
                          arguments: n);
                    },
                    child: Container(
                      width: CommonUtils.sw(context),
                      margin: EdgeInsets.only(bottom: 10),
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
                                Icons.message,
                                color: Colors.grey[200],
                                size: 150,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(CommonUtils.padding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  n.title!,
                                  textAlign: TextAlign.justify,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColour(context)
                                              .onSecondaryColour,
                                          fontSize: 20),
                                ),
                                Text(
                                  n.message!,
                                  textAlign: TextAlign.justify,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: AppColour(context)
                                              .onSecondaryColour
                                              .withOpacity(0.6),
                                          fontSize: 15),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    HelperMethod.formatDate(n.date),
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: AppColour(context)
                                                .onSecondaryColour
                                                .withOpacity(0.8),
                                            fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
