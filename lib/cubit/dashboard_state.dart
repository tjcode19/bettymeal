part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class LoadDashboard extends DashboardState {
  const LoadDashboard(
    this.data,
    this.isActiveSub,
    this.shuffle,
  );

  final UserData data;
  final bool isActiveSub;
  final int shuffle;

  @override
  List<Object> get props => [
        data,
        isActiveSub,
        shuffle
      ];
}
