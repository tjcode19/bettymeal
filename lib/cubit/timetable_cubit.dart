import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/timetable.dart';
import '../data/repositories/timetable_repository.dart';

part 'timetable_state.dart';

class TimetableCubit extends Cubit<TimetableState> {
  final TimetableRepository _repository;

  TimetableCubit() : 
    _repository = TimetableRepository(),
    super(TimetableInitial());

  Future<void> loadMeals() async {
    try {
      final meals = await _repository.getAllMeals();
      emit(TimetableLoaded(timetable: meals));
    } catch (_) {
      emit(const TimetableError(errorMessage: ""));
    }
  }

  Future<void> addMeal(TimetableModel meal) async {
    try {
      await _repository.addMeal(meal);
      final meals = await _repository.getAllMeals();
      emit(TimetableLoaded(timetable: meals));
    } catch (_) {
      emit(const TimetableError(errorMessage: ''));
    }
  }
}
