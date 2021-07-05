class GovernmentEntities {
  String status;
  String message;
  List<GovernmentData> data;

  GovernmentEntities({this.status, this.message, this.data});

  GovernmentEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    if (json['data'] != null) {
      data = new List<GovernmentData>();
      json['data'].forEach((v) {
        data.add(new GovernmentData.fromJson(v));
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

class GovernmentData {
  String id;
  String name;
  String slug;
  String extra;

  GovernmentData({this.id, this.name, this.slug, this.extra});

  GovernmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    slug = json['slug'].toString();
    extra = json['extra'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['extra'] = this.extra;
    return data;
  }
}