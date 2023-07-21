import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../data/shared_preference.dart';
import '../routes.dart';
import '../utils/enums.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : sharedPreference = SharedPreferenceApp(),
        super(NotificationInitial());

  final SharedPreferenceApp sharedPreference;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void subscribeToTopic({required String topic}) async {
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.subscribeToTopic(topic);
    sharedPreference.setData(
        sharedType: SpDataType.bool,
        fieldName: topic,
        fieldValue: true);
    print('Subscribed to topic: $topic');
  }

  void unSubscribeToTopic({required String topic}) async {
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    sharedPreference.setData(
        sharedType: SpDataType.bool,
        fieldName: topic,
        fieldValue: false);
    print('Subscribed to topic: news');
  }

 
}
