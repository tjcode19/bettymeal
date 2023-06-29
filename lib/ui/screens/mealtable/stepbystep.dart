import 'package:bettymeals/utils/colours.dart';
import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/store_cubit.dart';
import '../../../cubit/user_cubit.dart';
import '../../../utils/device_utils.dart';
import '../../widgets/shimmer_widget.dart';

class StepByStepScreen extends StatefulWidget {
  const StepByStepScreen({this.planId, super.key});

  final String? planId;

  @override
  State<StepByStepScreen> createState() => _StepByStepScreenState();
}

class _StepByStepScreenState extends State<StepByStepScreen> {
  // late final TimetableCubit _timetableCubit;

  DateTime currentDate = DateTime.now();
  final List<String> period = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  final today = HelperMethod.formatDate(DateTime.now().toIso8601String(),
      pattern: 'yyyy-MM-dd');

  final List<String> daysOfWeek = HelperMethod.dayOfWeek();

  int _currentStep = 0;

  void makeMove(int v) {
    setState(() {
      _currentStep = v;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColour(context).background,
        titleSpacing: 0.0,
        title: Text(
          'The Guide',
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
              child: Stepper(
                currentStep: _currentStep,
                onStepTapped: (value) => makeMove(value),
                onStepContinue: () => makeMove(_currentStep + 1),
                onStepCancel: () => makeMove(
                    _currentStep > 0 ? _currentStep - 1 : _currentStep),
                steps: [
                  Step(
                    title: Text('Put 50ml of water in the pot'),
                    content: Text(
                      'Put 50ml of water in the pot ' * 10,
                      textAlign: TextAlign.justify,
                    ),
                    state: _currentStep <= 0 ? StepState.editing : StepState.complete,
                    isActive: _currentStep >= 0
                  ),
                  const Step(
                      title: Text('Address'),
                      content: Center(
                        child: Text('Address'),
                      )),
                  const Step(
                      title: Text('Confirm'),
                      content: Center(
                        child: Text('Confirm'),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
