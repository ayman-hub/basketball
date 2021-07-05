class RefereeReportEntities {
  String status;
  String message;
  Data data;

  RefereeReportEntities({this.status, this.message, this.data});

  RefereeReportEntities.fromJson(Map<String, dynamic> json) {

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
  int acceptedCount;
  int rejectedCount;
  int uncompletedCount;
  List<AcceptedMatches> acceptedMatches;
  List<RejectedMatches> rejectedMatches;
  int balance;

  Data(
      {this.acceptedCount,
      this.rejectedCount,
      this.uncompletedCount,
      this.acceptedMatches,
      this.rejectedMatches,
      this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    acceptedCount = json['accepted_count'];
    rejectedCount = json['rejected_count'];
    uncompletedCount = json['uncompleted_count'];
    if (json['accepted_matches'] != null) {
      acceptedMatches = new List<AcceptedMatches>();
      json['accepted_matches'].forEach((v) {
        acceptedMatches.add(new AcceptedMatches.fromJson(v));
      });
    }
    if (json['rejected_matches'] != null) {
      rejectedMatches = new List<RejectedMatches>();
      json['rejected_matches'].forEach((v) {
        rejectedMatches.add(new RejectedMatches.fromJson(v));
      });
    }
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accepted_count'] = this.acceptedCount;
    data['rejected_count'] = this.rejectedCount;
    data['uncompleted_count'] = this.uncompletedCount;
    if (this.acceptedMatches != null) {
      data['accepted_matches'] =
          this.acceptedMatches.map((v) => v.toJson()).toList();
    }
    if (this.rejectedMatches != null) {
      data['rejected_matches'] =
          this.rejectedMatches.map((v) => v.toJson()).toList();
    }
    data['balance'] = this.balance;
    return data;
  }
}

class AcceptedMatches {
  String matchDate;
  String matchTime;
  String matchLeague;
  Match match;
  String status;

  AcceptedMatches(
      {this.matchDate,
      this.matchTime,
      this.matchLeague,
      this.match,
      this.status});

  AcceptedMatches.fromJson(Map<String, dynamic> json) {
    matchDate = json['match_date'].toString();
    matchTime = json['match_time'].toString();
    matchLeague = json['match_league'].toString();
    match = json['match'] != null ? new Match.fromJson(json['match']) : null;
    status = json['status'];
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
    return data;
  }
}

class RejectedMatches {
  String matchDate;
  String matchTime;
  String matchLeague;
  Match match;
  String status;

  RejectedMatches(
      {this.matchDate,
      this.matchTime,
      this.matchLeague,
      this.match,
      this.status});

  RejectedMatches.fromJson(Map<String, dynamic> json) {
    matchDate = json['match_date'].toString();
    matchTime = json['match_time'].toString();
    matchLeague = json['match_league'].toString();
    match = json['match'] != null ? new Match.fromJson(json['match']) : null;
    status = json['status'];
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
    id = json['id'];
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
