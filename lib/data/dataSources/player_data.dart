import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class  PlayerDataSqfliteDBClass {
  late Database dbInstance;

  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'player.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE Player ( id INTEGER PRIMARY KEY , team INT, player Text , score TEXT)",
        );
      },
    );

    return dbInstance;
  }

  Future<int> createPlayer(
      {required String player,
      required String score,
      required int team,
      }) async {
   

    var map = new Map<String, dynamic>();
    map = {'player': player, 'team':team, 'score': score};

    final Database dbInstance = await initializedDB();

    final tables =
        await dbInstance.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');

    final id = await dbInstance.insert('Player', map,
        conflictAlgorithm: ConflictAlgorithm.replace);

    // for (var i = 0; i < tables.length; i++) {
    print(id);

    return id;
    // }
  }

  Future<Either<String, Map<String , dynamic>>>  getPlayer({ required int team , required String player  }) async {
    final Database dbInstance = await initializedDB();
    var note = await dbInstance.rawQuery(
        'SELECT * FROM Player WHERE team=? and player=?',
        [team, '$player']);


    print(note);

    if( note.isEmpty ){

      return  left('null') ;
    }else{
    var data = note[0];

  
    return right( data );
    }
  }

  Future<void> updatePlayerSore({required int id , required String score , required int team , required String player})async{

    final Database dbInstance = await initializedDB();
    // var note = await dbInstance.rawQuery(
    //     'SELECT * FROM Player WHERE team=? and player=?',
    //     [team, '$player']);
        
        var mapData = {
          "id": id,
          "team":  team,
          "player": player,
          "score": score
        };

   var res=  await    dbInstance.insert( 'Player'  , mapData ,conflictAlgorithm: ConflictAlgorithm.replace );

var note = await dbInstance.query('Player');
print(note);
//  var updateCount =  await dbInstance.rawInsert("UPDATE Player SET score = ?, WHERE id = ?", [score, id]);

    print(res);


  }

 deleteDatabase() async{
    final Database dbInstance = await initializedDB();
   var res = await dbInstance.delete('Player');
print(res);
  }
}
