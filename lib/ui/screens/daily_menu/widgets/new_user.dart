import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/sub_cubit.dart';
import '../../../../routes.dart';
import '../../../../utils/colours.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/plan_card.dart';
import 'update_profile.dart';

class NewUserWidget extends StatefulWidget {
  const NewUserWidget({super.key});

  @override
  State<NewUserWidget> createState() => _NewUserWidgetState();
}

class _NewUserWidgetState extends State<NewUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CommonUtils.padding,
                  vertical: CommonUtils.xspadding),
              child: RichText(
                text: TextSpan(
                  text: 'Select from ',
                  children: [
                    TextSpan(
                      text: 'Our Plans ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColour(context).primaryColour,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'to get started',
                    )
                  ],
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black.withOpacity(0.7)),
                ),
              ),
            ),
            BlocBuilder<SubCubit, SubState>(
              builder: (context, state) {
                if (state is SubLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SubSuccess) {
                  var a = state.data.map(
                    (e) {
                      int pos = state.data.indexOf(e);
                      return PlanCard(
                        plan: e,
                        background: pos == 1
                            ? AppColour(context)
                                .secondaryColour
                                .withOpacity(0.1)
                            : pos == 2
                                ? Colors.blue.withOpacity(0.1)
                                : null,
                        onPress: () {
                          Navigator.pushNamed(context, Routes.planDetails,
                              arguments: e);
                        },
                      );
                    },
                  );

                  return Column(children: [...a]);
                } else {
                  return Text('No record');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
