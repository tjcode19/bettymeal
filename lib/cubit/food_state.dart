part of 'food_cubit.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<Food> foods;

  const FoodLoaded({required this.foods});

  @override
  List<Object> get props => [foods];
}

class FoodAdded extends FoodState {}

class FoodUpdated extends FoodState {}

class FoodError extends FoodState {
  final String errorMessage;

  const FoodError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
