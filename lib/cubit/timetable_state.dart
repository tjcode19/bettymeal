part of 'timetable_cubit.dart';

abstract class TimetableState extends Equatable {
  const TimetableState();

  @override
  List<Object> get props => [];
}

class TimetableInitial extends TimetableState {}

class TimetableLoading extends TimetableState {}

class TimetableLoaded extends TimetableState {
  final List<Timetable> timetable;

  const TimetableLoaded({required this.timetable});

  @override
  List<Object> get props => [timetable];
}

class TimetableAdded extends TimetableState {}

class TimetableUpdated extends TimetableState {}

class TimetableError extends TimetableState {
  final String errorMessage;

  const TimetableError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
