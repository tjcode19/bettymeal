import 'package:bettymeals/data/api/models/GetNotifications.dart';
import 'package:bettymeals/data/api/models/NotiResponse.dart';
import 'package:bettymeals/data/api/repositories/notiRepo.dart';
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
        notiRepo = NotiRepository(),
        super(NotificationInitial());

  final SharedPreferenceApp sharedPreference;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final NotiRepository notiRepo;

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
    final notiData = {
      "title": msg.notification.title,
      "body": msg.notification.body,
      "date": msg.sentTime.toString()
    };

    sharedPreference.setData(
        sharedType: SpDataType.object, fieldName: 'noti', fieldValue: notiData);
  }

  gotoNoti(context, {msg}) async {
    bool hasResumed = false;

    final uData = await sharedPreference.getSharedPrefs(
        sharedType: SpDataType.object, fieldName: 'noti');
    '';
    NotiResponse data = NotiResponse.fromJson(uData);
    if (data.title == null || data.title == '') return;
    if (!hasResumed) {
      hasResumed = true;

      Data message = Data();
      message.title = data.title;
      message.message = data.body;
      message.date = data.date;

      Navigator.pushNamed(context, Routes.notificationScreen, arguments: message);
    }
    sharedPreference.setData(
        sharedType: SpDataType.object, fieldName: 'noti', fieldValue: null);
  }

  getNotis() async {
    emit(NotificationInitial());
    try {
      final cal = await notiRepo.getAllNotifications();
      if (cal.code != '000') {
        emit(NotificationError(cal.message!));
      } else {
        emit(MessageLoaded(cal.data!));
      }
    } catch (e) {
      emit(NotificationError("Error Occured"));
      print(e);
    }
  }
}
