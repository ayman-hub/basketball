class GetJudgeMatchesEntities {
  String status;
  String message;
  GetJudgeMatchesData data;

  GetJudgeMatchesEntities({this.status, this.message, this.data});

  GetJudgeMatchesEntities.fromJson(Map<String, dynamic> json) {
    print("1");
    status = json['status'].toString();
    print("2");
    message = json['message'].toString();
    print("3");
    data = json['data'] != null && !(json["data"] is List) ? new GetJudgeMatchesData.fromJson(json['data']) : null;
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

class GetJudgeMatchesData {
  List<Matches> matches;
  List<Notifications> notifications;

  GetJudgeMatchesData({this.matches, this.notifications});

  GetJudgeMatchesData.fromJson(Map<String, dynamic> json) {
    if (json['matches'] != null) {
      print("4");
      matches = new List<Matches>();
      json['matches'].forEach((v) {
        print("5");
        matches.add(new Matches.fromJson(v));
      });
    }
    if (json['notifications'] != null) {
      print("6");
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.matches != null) {
      data['matches'] = this.matches.map((v) => v.toJson()).toList();
    }
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matches {
  String matchDate;
  String matchTime;
  String matchLeague;
  Match match;
  String status;
  String seen;

  Matches(
      {this.matchDate,
        this.matchTime,
        this.matchLeague,
        this.match,
        this.status,
        this.seen});

  Matches.fromJson(Map<String, dynamic> json) {
    print("7");
    matchDate = json['match_date']??"".toString();
    print("8");
    matchTime = json['match_time']??"".toString();
    print("9");
    matchLeague = json['match_league']??"".toString();
    print("10");
    match = json['match'] != null ? new Match.fromJson(json['match']) : null;
    print("11");
    status = json['status']??"".toString();
    print("12");
    seen = json['seen']??"".toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_date'] = this.matchDate;
    data['match_time'] = this.matchTime;
    data['match_league'] = this.matchLeague;
    if (this.match != null) {
      data['match'] = this.match.toJson();
    }
    data['status'] = this.status;
    data['seen'] = this.seen;
    return data;
  }
}

class Match {
  String id;
  String name;
  List<Results> results;

  Match({this.id, this.name, this.results});

  Match.fromJson(Map<String, dynamic> json) {
    print("13");
    id = json['id'];
    print("14");
    name = json['name'].toString();
    print("15");
    if (json['results'] != null) {
      print("16");
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
    print("17");
    id = json['id'].toString();
    print("18");
    title = json['title']??"".toString();
    print("19");
    logo = json['logo']??"".toString();
    print("20");
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
    print(json.toString());
    print("21");
    one = json['one'].toString();
    print("22");
    two = json['two'].toString();
    print("23");
    three = json['three'].toString();
    print("24");
    four = json['four'].toString();
    print("25");
    ot = json['ot'].toString();
    print("26");
    points = json['points']??"".toString();
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

class Notifications {
  String id;
  String matchId;
  String notId;
  String matchName;
  String matchDate;
  String matchTime;

  Notifications(
      {this.id,
        this.matchId,
        this.notId,
        this.matchName,
        this.matchDate,
        this.matchTime});

  Notifications.fromJson(Map<String, dynamic> json) {
    print("27");
    id = json['id'].toString();
    print("28");
    matchId = json['match_id'].toString();
    print("29");
    notId = json['not_id'].toString();
    print("30");
    matchName = json['match_name']??"".toString();
    print("31");
    matchDate = json['match_date']??"".toString();
    print("32");
    matchTime = json['match_time']??"".toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['match_id'] = this.matchId;
    data['not_id'] = this.notId;
    data['match_name'] = this.matchName;
    data['match_date'] = this.matchDate;
    data['match_time'] = this.matchTime;
    return data;
  }
}