import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/api/models/GetStoreItems.dart';
import '../data/api/repositories/storeRepo.dart';
import '../data/shared_preference.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit()
      : this.sharedPreference = SharedPreferenceApp(),
        this.storeRepository = StoreRepository(),
        super(StoreInitial());

  final SharedPreferenceApp sharedPreference;
  final StoreRepository storeRepository;


  getStoreItems() async {
    emit(StoreLoading());
    try {
      final cal = await storeRepository.getStoreItems();

      inspect(cal);
      if (cal.code != '000') {
        emit(StoreError(cal.message!));
      } else {
        emit(StoreSuccess(cal.data!));
      }
    } catch (e) {
      emit(StoreError("Error Occured"));
    }
  }
}
