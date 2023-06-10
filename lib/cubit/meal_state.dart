part of 'meal_cubit.dart';

abstract class MealState extends Equatable {
  const MealState();

  @override
  List<Object> get props => [];
}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealError extends MealState {
  const MealError(this.msg);

  final String msg;

  @override
  List<Object> get props => [msg];
}

class MealSuccess extends MealState {
  const MealSuccess(this.br, this.ln, this.dn);

  final List<MealData> br;
  final List<MealData> ln;
  final List<MealData> dn;

  @override
  List<Object> get props => [br, ln, dn];
}
