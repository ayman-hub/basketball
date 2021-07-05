
class GetTeamPlayersEntities {
  String status;
  String message;
  List<Data> data;

  GetTeamPlayersEntities({this.status, this.message, this.data});

  GetTeamPlayersEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String teamId;
  String teamName;
  List<Players> players;

  Data({this.teamId, this.teamName, this.players});

  Data.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    teamName = json['team_name'];
    if (json['players'] != null) {
      players = new List<Players>();
      json['players'].forEach((v) {
        players.add(new Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['team_name'] = this.teamName;
    if (this.players != null) {
      data['players'] = this.players.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  int playerId;
  String playerName;

  Players({this.playerId, this.playerName});

  Players.fromJson(Map<String, dynamic> json) {
    playerId = json['player_id'];
    playerName = json['player_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player_id'] = this.playerId;
    data['player_name'] = this.playerName;
    return data;
  }
}


class ReportPlayerEntities {
  String id;
  String player;
  String report;
  ReportPlayerEntities(this.id, this.player, this.report);
}