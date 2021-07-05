class GetRefereesConditionsEntities {
  String status;
  String message;
  GetRefreesConditionsEntitiesData data;

  GetRefereesConditionsEntities({this.status, this.message, this.data});

  GetRefereesConditionsEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    data = json['data'] != null ? new GetRefreesConditionsEntitiesData.fromJson(json['data']) : null;
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

class GetRefreesConditionsEntitiesData {
  String contents;

  GetRefreesConditionsEntitiesData({this.contents});

  GetRefreesConditionsEntitiesData.fromJson(Map<String, dynamic> json) {
    contents = json['contents'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contents'] = this.contents;
    return data;
  }
}