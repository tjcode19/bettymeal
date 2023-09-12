import 'dart:async';
import 'dart:developer';
import 'dart:math';

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
    bool hasResumed = false;

    final uData = await sharedPreference.getSharedPrefs(
        sharedType: SpDataType.object, fieldName: 'noti');
    '';
    inspect(uData);

    NotiResponse data = NotiResponse.fromJson(uData);
    if (data.title == null || data.title == '') return;
    if (!hasResumed) {
      hasResumed = true;

      Navigator.pushNamed(context, Routes.notificationScreen, arguments: data);
    }
    sharedPreference.setData(
        sharedType: SpDataType.object, fieldName: 'noti', fieldValue: null);
  }

  getTips() async {
    try {
      final cal = await notiRepo.getTips();
      if (cal.code != '000') {
        emit(NotificationError(cal.message!));
      } else {
        startRandomizing(cal.data!);
      }
    } catch (e) {
      emit(NotificationError("Error Occured"));
      print(e);
    }
  }

  getNotis() async {
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

  void startRandomizing(List<Data> data) {
    _updateRandomString(data); // Initial call to set a random string
    Timer.periodic(Duration(hours: 6), (timer) {
      _updateRandomString(data); // Update random string every 6 hours
    });
  }

  _updateRandomString(List<Data> data) {
    Data currentString;
    Random random = Random();
    currentString = data[random.nextInt(data.length)];

    emit(NotificationLoad(currentString));
  }
}
