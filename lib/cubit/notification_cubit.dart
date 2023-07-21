import 'dart:developer';

import 'package:bettymeals/data/api/models/NotiResponse.dart';
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
        sharedType: SpDataType.bool, fieldName: topic, fieldValue: true);
    print('Subscribed to topic: $topic');
  }

  void unSubscribeToTopic({required String topic}) async {
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    sharedPreference.setData(
        sharedType: SpDataType.bool, fieldName: topic, fieldValue: false);
    print('Subscribed to topic: news');
  }

  storeNoti(context, {msg}) {
    // print('We got here : $msg');

    final notiData = {
      "title": msg.notification.title,
      "body": msg.notification.body
    };

    inspect(notiData);
    sharedPreference.setData(
        sharedType: SpDataType.object, fieldName: 'noti', fieldValue: notiData);
  }

  gotoNoti(context, {msg}) async {
    // print('We got here : $msg');
    // showDialog(
    //     context: context,
    //     builder: (v) {
    //       return Text('Memo');
    //     });
    bool hasResumed = false;

    final uData = await sharedPreference.getSharedPrefs(
        sharedType: SpDataType.object, fieldName: 'noti');
    '';
    inspect(uData);

    if(uData == null) return;

    NotiResponse data = NotiResponse.fromJson(uData);
    if (!hasResumed) {
      hasResumed = true;

      Navigator.pushNamed(context, Routes.notificationScreen, arguments: data);
    }
    sharedPreference.setData(
        sharedType: SpDataType.object, fieldName: 'noti', fieldValue: null);
  }
}
