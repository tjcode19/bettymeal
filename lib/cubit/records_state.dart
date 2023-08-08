part of 'records_cubit.dart';

abstract class RecordsState extends Equatable {
  const RecordsState();

  @override
  List<Object> get props => [];
}

class RecordInitial extends RecordsState {}

class RecordLoading extends RecordsState {}

class RecordError extends RecordsState {
  final String errorMessage;

  const RecordError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class GetRecordSuccess extends RecordsState {
  const GetRecordSuccess(this.data);

  final List<GetTimetableData> data;

  @override
  List<Object> get props => [data];
}
