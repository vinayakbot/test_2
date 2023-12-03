import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:test_2/data/dataSources/player_data.dart';
import 'package:test_2/data/rawData/pl_data.dart';
import 'package:test_2/domain/models/player_data_model.dart';
import 'package:test_2/presentation/dashboard/ui/widget/playerCard_widget.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  PlayerDataSqfliteDBClass localDb;
  DashboardBloc({ required this.localDb }) : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {
      // TODO: implement event handler
    });


///
/////
////
////
///
List<PlayerDataModel> teamsData = [];
///
/////
///
///
///
///
///
///
///
///
///



on<DashboardInitialEvent>((event, emit) async{

var data = PlData.data;
for (var i = 0; i < data.length  ; i++) {
  teamsData.add(  PlayerDataModel.fromJson(data[i])  );
}


add(DashboardPageChangeEvent(pageNumber: 0  ));
  });

var playerIdInDatabase = 0;
var selectedTeamData = PlayerDataModel();
//
////
////
////
////
///
////
////
////
////
///
///
///
on<DashboardPageChangeEvent>((event, emit) async{
selectedTeamData = teamsData[event.pageNumber];



var getPlayerFromDb = await localDb.getPlayer(team: selectedTeamData.team! , player:  selectedTeamData.players![0].name!  );

var resfromDb;
 getPlayerFromDb.fold((l) {
resfromDb = l;
}, (r) {
resfromDb = r;
});




var setPlayerFromDb;

if( resfromDb == 'null' ){

playerIdInDatabase =   await localDb.createPlayer(player: selectedTeamData.players![0].name!, score: selectedTeamData.players![0].score!, team:  selectedTeamData.team! );
var playerData = await  localDb.getPlayer(team: selectedTeamData.team! , player:  selectedTeamData.players![0].name!  );

await playerData.fold((l) => null, (r) {

  resfromDb = r;
});


}else{

playerIdInDatabase = resfromDb['id'];
}

for (var i = 0; i < selectedTeamData.players!.length; i++) {

  print(selectedTeamData.players![i] );
  print(resfromDb['player']);
  
  if( selectedTeamData.players![i].name == resfromDb['player'] ){
    selectedTeamData.players![i].score = resfromDb['score'];
  }
}



var score = int.parse(selectedTeamData.players![0].score!);
      emit(DashboardPageChangedState(selectedTeamData ,   score  , 0 ));
    });


///
////
////
///
///
///
///
///
///
///
///

on<PlayerScoreIncreaseEvent>((event, emit) async{

  var currentScore = event.score;
currentScore++;




 await localDb.updatePlayerSore(id: playerIdInDatabase , score: currentScore.toString(), team: teamsData[event.pageNumber].team! , player: teamsData[event.pageNumber].players![event.player]!.name!  );

emit( DashboardPageChangedState(selectedTeamData , currentScore , event.player) );

});

on<PlayerScoreDecreaseEvent>((event, emit) async{

  var currentScore = event.score;

if( event.score == 0 ) return;

currentScore--;
 await localDb.updatePlayerSore(id: playerIdInDatabase , score: currentScore.toString(), team: teamsData[event.pageNumber].team! , player: teamsData[event.pageNumber].players![event.player]!.name!  );

// await localDb.deleteDatabase();

emit( DashboardPageChangedState( selectedTeamData , currentScore  , event.player ) );

});

on<PlayerChangeEvent>((event, emit) async{


selectedTeamData = teamsData[event.pageNumber];
print( selectedTeamData.players![event.player].name! );
var getPlayerFromDb = await localDb.getPlayer(team: selectedTeamData.team! , player:  selectedTeamData.players![event.player].name!  );

var resfromDb;
getPlayerFromDb.fold((l) {
resfromDb = l;
}, (r) {
resfromDb = r;
});




var setPlayerFromDb;


if( resfromDb == 'null' ){

playerIdInDatabase =   await localDb.createPlayer(player: selectedTeamData.players![event.player].name!, score: selectedTeamData.players![event.player].score!, team:  selectedTeamData.team! );
var playerData = await  localDb.getPlayer(team: selectedTeamData.team! , player:  selectedTeamData.players![0].name!  );

await playerData.fold((l) => null, (r) {

  resfromDb = r;
});
}else{

playerIdInDatabase = resfromDb['id'];
}

for (var i = 0; i < selectedTeamData.players!.length; i++) {

  print(selectedTeamData.players![i] );
  print(resfromDb['player']);
  
  if( selectedTeamData.players![i].name == resfromDb['player'] ){
    selectedTeamData.players![i].score = resfromDb['score'];
  }
}



var score = int.parse(selectedTeamData.players![event.player].score!);

emit( DashboardPageChangedState( selectedTeamData ,   score , event.player) );
});


// conditionalDBOperation({ required int team ,required String name , required String playerScore })async{

// var getPlayerFromDb = await localDb.getPlayer(team:  team  , player:  name );

// var resfromDb;
// getPlayerFromDb.fold((l) {
// resfromDb = l;
// }, (r) {
// resfromDb = r;
// });



// if( resfromDb == 'null' ){

// playerIdInDatabase =   await localDb.createPlayer(player: name, score: playerScore, team:  team );
// var playerData = await  localDb.getPlayer(team: team , player:  name   );

// await playerData.fold((l) => null, (r) {

//   resfromDb = r;
// });


// }else{

// playerIdInDatabase = resfromDb['id'];
// }

// for (var i = 0; i < selectedTeamData.players!.length; i++) {

  
//   if( selectedTeamData.players![i].name == resfromDb['player'] ){
//     selectedTeamData.players![i].score = resfromDb['score'];
//   }
// }



// var score = int.parse(selectedTeamData.players![0].score!);
//     };


///
////
////
///
///
///
///
///
///
///
///


  
  
  getCurrentScore(){

  }
  }




  
}
