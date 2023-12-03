part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardPageChangedState extends DashboardState {
PlayerDataModel teamData;
  int score;
  int selectedPlayer;  
  DashboardPageChangedState(this.teamData , this.score , this.selectedPlayer);
}


