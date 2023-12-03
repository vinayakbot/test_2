part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardInitialEvent extends DashboardEvent {

}

class DashboardPageChangeEvent extends DashboardEvent {
  int pageNumber;
  
// PlayerDataModel teamData;

  DashboardPageChangeEvent({required this.pageNumber });
}

class PlayerChangeEvent extends DashboardEvent {
int pageNumber;
int player;

  PlayerChangeEvent({   required this.player , required this.pageNumber});

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

  

  