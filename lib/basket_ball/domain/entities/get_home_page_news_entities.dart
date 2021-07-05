class GetHomePageNewsEntities {
  String status;
  String message;
  List<Data> data;

  GetHomePageNewsEntities({this.status, this.message, this.data});

  GetHomePageNewsEntities.fromJson(Map<String, dynamic> json) {
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
  int id;
  String title;
  String excerpt;
  String link;
  String thumb;

  Data({this.id, this.title, this.excerpt, this.link, this.thumb});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    excerpt = json['excerpt'].toString();
    link = json['link'].toString();
    thumb = json['thumb'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['excerpt'] = this.excerpt;
    data['link'] = this.link;
    data['thumb'] = this.thumb;
    return data;
  }
}