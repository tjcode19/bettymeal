part of 'records_cubit.dart';

abstract class RecordsState extends Equatable {
  const RecordsState();

  @override
  List<Object> get props => [];
}

class TimetableInitial extends RecordsState {}

class TimetableLoading extends RecordsState {}

class TimetableLoaded extends RecordsState {
  final List<TimetableModel> timetable;

  const TimetableLoaded({required this.timetable});

  @override
  List<Object> get props => [timetable];
}

class TimetableSuccess extends RecordsState {}

class TimetableAdded extends RecordsState {}

class TimetableUpdated extends RecordsState {}

class TimetableError extends RecordsState {
  final String errorMessage;

  const TimetableError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class TimetableInfo extends RecordsState {
  final String msg;

  const TimetableInfo({required this.msg});

  @override
  List<Object> get props => [msg];
}

class NoSubSuccess extends RecordsState {
  final String msg;

  const NoSubSuccess({required this.msg});

  @override
  List<Object> get props => [msg];
}

class GetTableSuccess extends RecordsState {
  const GetTableSuccess(this.data, this.allData, this.dataWeekly);

  final List<GetTimetableData> data;
  final List<GetTimetableData> allData;
  final List<List<Timetable>> dataWeekly;

  @override
  List<Object> get props => [data, allData];
}

class GetRecordSuccess extends RecordsState {
  const GetRecordSuccess(this.data);

  final List<GetTimetableData> data;

  @override
  List<Object> get props => [data];
}
