import 'package:bettymeals/cubit/timetable_cubit.dart';
import 'package:bettymeals/ui/screens/mealtable/mealtable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('mealtable ...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (context) => TimetableCubit(),
        child: MealTableScreen(),
      ),
    ));

    final ct = await find.byType(AppBar);
    expect(ct, findsOneWidget);
    final ctb = await find.byType(OutlinedButton);
    expect(ctb, findsOneWidget);
    final eBtn = await find.byType(ElevatedButton);
    expect(eBtn, findsOneWidget);
  });
}
