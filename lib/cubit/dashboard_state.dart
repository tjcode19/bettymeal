part of 'dashboard_cubit.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class LoadDashboard extends DashboardState {
  const LoadDashboard(
    this.data,
    this.isActiveSub,
  );

  final UserData data;
  final bool isActiveSub;

  @override
  List<Object> get props => [
        data,
        isActiveSub,
      ];
}
