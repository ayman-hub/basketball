class GetEtihadAchievmentsCategoriesEntities {
  String status;
  String message;
  List<Data> data;

  GetEtihadAchievmentsCategoriesEntities(
      {this.status, this.message, this.data});

  GetEtihadAchievmentsCategoriesEntities.fromJson(Map<String, dynamic> json) {
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
  List<Achievements> achievements;

  Data({this.id, this.title, this.achievements});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    if (json['achievements'] != null) {
      achievements = new List<Achievements>();
      json['achievements'].forEach((v) {
        achievements.add(new Achievements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.achievements != null) {
      data['achievements'] = this.achievements.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Achievements {
  int id;
  String title;
  String content;

  Achievements({this.id, this.title, this.content});

  Achievements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    content = json['content'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}