part of 'timetable_cubit.dart';

abstract class TimetableState extends Equatable {
  const TimetableState();

  @override
  List<Object> get props => [];
}

class TimetableInitial extends TimetableState {}

class TimetableLoading extends TimetableState {}

class TimetableLoaded extends TimetableState {
  final List<TimetableModel> timetable;

  const TimetableLoaded({required this.timetable});

  @override
  List<Object> get props => [timetable];
}

class TimetableSuccess extends TimetableState {}

class TimetableAdded extends TimetableState {}

class TimetableUpdated extends TimetableState {}

class TimetableError extends TimetableState {
  final String errorMessage;

  const TimetableError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class TimetableInfo extends TimetableState {
  final String msg;

  const TimetableInfo({required this.msg});

  @override
  List<Object> get props => [msg];
}

class NoSubSuccess extends TimetableState {
  final String msg;

  const NoSubSuccess({required this.msg});

  @override
  List<Object> get props => [msg];
}

class GetTableSuccess extends TimetableState {
  const GetTableSuccess(this.data, this.allData, this.dataWeekly);

  final List<GetTimetableData> data;
  final List<GetTimetableData> allData;
  final List<List<Timetable>> dataWeekly;

  @override
  List<Object> get props => [data, allData];
}

class GetRecordSuccess extends TimetableState {
  const GetRecordSuccess(this.data);

  final List<GetTimetableData> data;

  @override
  List<Object> get props => [data];
}
