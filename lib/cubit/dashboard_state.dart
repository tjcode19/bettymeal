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
      this.data, this.isActiveSub, this.shuffle, this.regenerate);

  final UserData data;
  final bool isActiveSub;
  final int shuffle;
  final int regenerate;

  @override
  List<Object> get props => [data, isActiveSub, shuffle, regenerate];
}

class DashboardError extends DashboardState {
  const DashboardError(this.msg);

  final String msg;

  @override
  List<Object> get props => [
        msg,
      ];
}
