import 'package:bettymeals/cubit/auth_cubit.dart';
import 'package:bettymeals/ui/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('login ...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (context) => AuthCubit(),
        child: LoginScreen(),
      ),
    ));

    final ct = await find.byType(AppBar);
    expect(ct, findsNothing);
    final ctx = await find.byType(TextFormField);
    expect(ctx, findsNWidgets(2));
    final ctb = await find.byType(TextButton);
    expect(ctb, findsOneWidget);
    final eBtn = await find.byType(ElevatedButton);
    expect(eBtn, findsOneWidget);
  });
}
