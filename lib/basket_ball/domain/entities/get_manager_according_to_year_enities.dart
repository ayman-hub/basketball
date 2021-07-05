class GetManagerAccordingtoYearEntities {
  String status;
  String message;
  List<Data> data;

  GetManagerAccordingtoYearEntities({this.status, this.message, this.data});

  GetManagerAccordingtoYearEntities.fromJson(Map<String, dynamic> json) {
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
  List<Managers> managers;

  Data({this.id, this.title, this.managers});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    if (json['managers'] != null) {
      managers = new List<Managers>();
      json['managers'].forEach((v) {
        managers.add(new Managers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.managers != null) {
      data['managers'] = this.managers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Managers {
  int id;
  String title;
  String thumb;

  Managers({this.id, this.title, this.thumb});

  Managers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    thumb = json['thumb'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumb'] = this.thumb;
    return data;
  }
}