import 'package:bettymeals/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  BuildContext context;

  AppLifecycleObserver(this.context);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    bool hasResumed = false;
    if (state == AppLifecycleState.resumed && !hasResumed) {
      hasResumed = true;
      // App came to the foreground
      print('App resumed');
      // Add your logic here
      
      context.read<NotificationCubit>().gotoNoti(context);
    }
  }
}
