class GetSearchPageEntities {
String status;
String message;
List<Data> data = [];

GetSearchPageEntities({this.status, this.message, this.data});

GetSearchPageEntities.fromJson(Map<String, dynamic> json) {
status = json['status'].toString();
message = json['message'].toString();
if (json['data'] != null) {
data = new List<Data>();
json['data'].forEach((v) { data.add(new Data.fromJson(v)); });
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
  String title;
  String link;

  Data({this.title, this.link});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString();
    link = json['link'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    return data;
  }
}