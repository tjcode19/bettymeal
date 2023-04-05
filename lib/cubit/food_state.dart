part of 'food_cubit.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class FoodLoading extends FoodState {}

class FoodLoaded extends FoodState {
  final List<FoodModel> foods;
  final List<FoodModel> bf;
  final List<FoodModel> ln;
  final List<FoodModel> dn;

  const FoodLoaded({required this.bf, required this.ln, required this.dn, required this.foods});

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
