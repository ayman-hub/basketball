class GetMatchDetailsEntities {
  String status;
  String message;
  Data data;

  GetMatchDetailsEntities({this.status, this.message, this.data});

  GetMatchDetailsEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String matchDate;
  String matchTime;
  String matchLeague;
  String matchStatus;
  List<Referees> referees;
  bool isMainReferee;
  Match match;

  Data(
      {this.matchDate,
        this.matchTime,
        this.matchLeague,
        this.matchStatus,
        this.referees,
        this.isMainReferee,
        this.match});

  Data.fromJson(Map<String, dynamic> json) {
    matchDate = json['match_date'].toString();
    matchTime = json['match_time'].toString();
    matchLeague = json['match_league'].toString();
    matchStatus = json['match_status'].toString();
    if (json['referees'] != null) {
      referees = new List<Referees>();
      json['referees'].forEach((v) {
        referees.add(new Referees.fromJson(v));
      });
    }
    isMainReferee = json['is_main_referee'];
    match = json['match'] != null ? new Match.fromJson(json['match']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_date'] = this.matchDate;
    data['match_time'] = this.matchTime;
    data['match_league'] = this.matchLeague;
    data['match_status'] = this.matchStatus;
    if (this.referees != null) {
      data['referees'] = this.referees.map((v) => v.toJson()).toList();
    }
    data['is_main_referee'] = this.isMainReferee;
    if (this.match != null) {
      data['match'] = this.match.toJson();
    }
    return data;
  }
}

class Referees {
  String username;
  String refType;
  String localInter;

  Referees({this.username, this.refType, this.localInter});

  Referees.fromJson(Map<String, dynamic> json) {
    username = json['username'].toString();
    refType = json['ref_type'].toString();
    localInter = json['local_inter'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['ref_type'] = this.refType;
    data['local_inter'] = this.localInter;
    return data;
  }
}

class Match {
  String id;
  String name;
  List<Results> results;

  Match({this.id, this.name, this.results});

  Match.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String id;
  String title;
  String logo;
  Result result;

  Results({this.id, this.title, this.logo, this.result});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'].toString();
    logo = json['logo'].toString();
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['logo'] = this.logo;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String one;
  String two;
  String three;
  String four;
  String ot;
  String points;

  Result({this.one, this.two, this.three, this.four, this.ot, this.points});

  Result.fromJson(Map<String, dynamic> json) {
    one = json['one'].toString();
    two = json['two'].toString();
    three = json['three'].toString();
    four = json['four'].toString();
    ot = json['ot'].toString();
    points = json['points'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['one'] = this.one;
    data['two'] = this.two;
    data['three'] = this.three;
    data['four'] = this.four;
    data['ot'] = this.ot;
    data['points'] = this.points;
    return data;
  }
}