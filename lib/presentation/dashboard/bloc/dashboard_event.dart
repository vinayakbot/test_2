part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent {

}

class DashboardPageChangeEvent extends DashboardEvent {
  final int pageNumber;
  int player;
// PlayerDataModel teamData;

  DashboardPageChangeEvent({required this.pageNumber , required this.player});
}

class PlayerChangeEvent extends DashboardPageChangeEvent {
int pageNumber;
int player;

  PlayerChangeEvent({   required this.player , required this.pageNumber}):super(pageNumber: pageNumber , player: player);

}





class PlayerScoreIncreaseEvent extends PlayerChangeEvent {
int pageNumber;
int score;
int player;
  PlayerScoreIncreaseEvent({   required this.score , required this.pageNumber  , required this.player}):super(pageNumber: pageNumber , player: player);
}

class PlayerScoreDecreaseEvent extends PlayerChangeEvent {
int pageNumber;
int score;
int player;
  PlayerScoreDecreaseEvent({ required this.score ,  required this.pageNumber , required this.player}):super(pageNumber: pageNumber , player: player);
}

  

  