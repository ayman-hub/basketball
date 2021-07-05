class NotificationEntities {
  String status;
  String message;
  List<NotificationData> data;

  NotificationEntities({this.status, this.message, this.data});

  NotificationEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    if (json['data'] != null) {
      data = new List<NotificationData>();
      json['data'].forEach((v) {
        data.add(new NotificationData.fromJson(v));
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

class NotificationData {
  String id;
  String refId;
  String matchId;
  String status;
  String date;
  String seen;
  String type;
  String msg;
  String notId;
  String matchName;
  String matchDate;
  String matchTime;
  String matchPlace;

  NotificationData(
      {this.id,
        this.refId,
        this.matchId,
        this.status,
        this.date,
        this.seen,
        this.type,
        this.msg,
        this.notId,
        this.matchName,
        this.matchDate,
        this.matchTime,this.matchPlace});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
    matchId = json['match_id'];
    status = json['status'];
    date = json['date'];
    seen = json['seen'];
    type = json['type'];
    msg = json['msg'];
    notId = json['not_id'];
    matchName = json['match_name'];
    matchDate = json['match_date'];
    matchTime = json['match_time'];
    matchPlace = json['match_place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_id'] = this.refId;
    data['match_id'] = this.matchId;
    data['status'] = this.status;
    data['date'] = this.date;
    data['seen'] = this.seen;
    data['type'] = this.type;
    data['msg'] = this.msg;
    data['not_id'] = this.notId;
    data['match_name'] = this.matchName;
    data['match_date'] = this.matchDate;
    data['match_time'] = this.matchTime;
    data['match_place'] = this.matchPlace;
    return data;
  }
}