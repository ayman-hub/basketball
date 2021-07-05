class UnCompletedMatchEntities {
  String status;
  String message;
  List<Data> data;

  UnCompletedMatchEntities({this.status, this.message, this.data});

  UnCompletedMatchEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
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
  String matchId;
  String matchTitle;
  String matchStatus;

  Data({this.matchId, this.matchTitle, this.matchStatus});

  Data.fromJson(Map<String, dynamic> json) {
    matchId = json['match_id'].toString();
    matchTitle = json['match_title'].toString();
    matchStatus = json['match_status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['match_id'] = this.matchId;
    data['match_title'] = this.matchTitle;
    data['match_status'] = this.matchStatus;
    return data;
  }
}