import 'dart:async';
import 'dart:math';

import 'package:bettymeals/data/api/repositories/notiRepo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/api/models/GetNotifications.dart';

part 'tips_state.dart';

class TipsCubit extends Cubit<TipsState> {
  TipsCubit() : this.notiRepo = NotiRepository(), super(TipsInitial());

   final NotiRepository notiRepo;



  getTips() async {
    try {
      final cal = await notiRepo.getTips();
      if (cal.code != '000') {
        emit(TipsError(cal.message!));
      } else {
        startRandomizing(cal.data!);
      }
    } catch (e) {
      emit(TipsError("Error Occured"));
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

    emit(TipsLoad(currentString));
  }
}
