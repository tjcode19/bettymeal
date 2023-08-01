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
  const MealSuccess(this.meals);

  final List<MealData> meals;

  @override
  List<Object> get props => [meals];
}

class MealSuccessFilter extends MealState {
  const MealSuccessFilter(this.meals);

  final List<MealData> meals;

  @override
  List<Object> get props => [meals];
}

class MealMoreSuccess extends MealState {
  const MealMoreSuccess(this.meals);

  final List<MealData> meals;

  @override
  List<Object> get props => [meals];
}

class MealReloadSuccess extends MealState {
  const MealReloadSuccess(this.meals);

  final List<MealData> meals;

  @override
  List<Object> get props => [meals];
}
