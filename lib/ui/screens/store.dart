import 'package:bettymeals/cubit/sub_cubit.dart';
import 'package:bettymeals/ui/screens/daily_menu/widgets/plan_card.dart';
import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/user_cubit.dart';
import '../../../routes.dart';
import '../../cubit/store_cubit.dart';
import '../../utils/device_utils.dart';
import '../widgets/shimmer_widget.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({this.planId, super.key});

  final String? planId;

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // late final TimetableCubit _timetableCubit;

  DateTime currentDate = DateTime.now();
  final List<String> period = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  final today = HelperMethod.formatDate(DateTime.now().toIso8601String(),
      pattern: 'yyyy-MM-dd');

  final List<String> daysOfWeek = HelperMethod.dayOfWeek();

  int foodSize = 0;

  bool isActiveSub = false;

  @override
  void initState() {
    super.initState();

    isActiveSub = context.read<UserCubit>().isActiveSub();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColour(context).background,
        titleSpacing: 0.0,
        title: Text(
          'Store',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColour(context).primaryColour.withOpacity(0.7),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CommonUtils.padding,
                  vertical: CommonUtils.xspadding),
              child: RichText(
                text: TextSpan(
                  text: 'You should have all these in your ',
                  children: [
                    TextSpan(
                      text: 'Pantry ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColour(context).primaryColour,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'days',
                    )
                  ],
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black.withOpacity(0.7)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CommonUtils.padding,
                    vertical: CommonUtils.xspadding),
                child: Container(
                  padding: EdgeInsets.only(top: CommonUtils.padding),
                  decoration: BoxDecoration(
                    color: AppColour(context).primaryColour.withOpacity(0.1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: BlocBuilder<StoreCubit, StoreState>(
                    builder: (context, state) {
                      if (state is StoreSuccess) {
                        return ListView.separated(
                            itemBuilder: (_, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: CommonUtils.padding,
                                    vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(state
                                        .data[index].mealItem!.meal!.name!),
                                    Text('X ${state.data[index].count.toString()}'),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (_, index) {
                              return Divider(
                                color: AppColour(context)
                                    .primaryColour
                                    .withOpacity(0.4),
                              );
                            },
                            itemCount: state.data.length);
                      } else if (state is StoreLoading) {
                        return shimmerWidget(
                            row: 6,
                            height:
                                (DeviceUtils.height(context) * 0.6).toDouble());
                      } else {
                        return Text('No record');
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
