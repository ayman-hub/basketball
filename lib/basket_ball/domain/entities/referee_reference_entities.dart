class RefereeReferenceEntities {
  String status;
  String message;
  RefreeReferenceData data;

  RefereeReferenceEntities({this.status, this.message, this.data});

  RefereeReferenceEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    data = json['data'] != null ? new RefreeReferenceData.fromJson(json['data']) : null;
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

class RefreeReferenceData {
  String text;
  String url;

  RefreeReferenceData({this.text, this.url});

  RefreeReferenceData.fromJson(Map<String, dynamic> json) {
    text = json['text'].toString();
    url = json['url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['url'] = this.url;
    return data;
  }
}