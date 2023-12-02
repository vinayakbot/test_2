part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardPageChangedState extends DashboardState {
  PlayerCardWidget card;
  int score;
  int selectedPlayer;  
  DashboardPageChangedState(this.card , this.score , this.selectedPlayer);
}




// final class DashboardScoreChangeEvent extends DashboardPageChangedState {
 
//   PlayerCardWidget card;
//   DashboardScoreChangeEvent({required this.card , required this.score}):super(card);

// }