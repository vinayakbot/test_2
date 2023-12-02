class PlayerDataModel {
  int? team;
  String? teamName;
  String? color;
  List<Players>? players;

  PlayerDataModel({this.team, this.teamName, this.color, this.players});

  PlayerDataModel.fromJson(Map<String, dynamic> json) {
    team = json['team'];
    teamName = json['team_name'];
    color = json['color'];
    if (json['players'] != null) {
      players = <Players>[];
      json['players'].forEach((v) {
        players!.add(new Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team'] = this.team;
    data['team_name'] = this.teamName;
    data['color'] = this.color;
    if (this.players != null) {
      data['players'] = this.players!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  String? name;
  String? score;

  Players({this.name, this.score});

  Players.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['score'] = this.score;
    return data;
  }
}