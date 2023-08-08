import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/api/models/GetTimetable.dart';
import '../data/api/repositories/timetableRepo.dart';

part 'records_state.dart';

class RecordsCubit extends Cubit<RecordsState> {
  final TimetableRepo apiRepo;

  RecordsCubit()
      : apiRepo = TimetableRepo(),
        super(RecordInitial());

  getRecords() async {
    try {
      final cal = await apiRepo.getTimetable();

      if (cal.code != '000') {
        emit(RecordError(errorMessage: cal.message!));
      } else {
        // getRecords(cal.data);

        emit(GetRecordSuccess(cal.data!));
      }
    } catch (e) {
      emit(RecordError(errorMessage: "Error Occured"));
    }
  }
}
