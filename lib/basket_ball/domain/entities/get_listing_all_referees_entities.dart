class GetListingAllRefereesEntities {
  String status;
  String message;
  List<Data> data;

  GetListingAllRefereesEntities({this.status, this.message, this.data});

  GetListingAllRefereesEntities.fromJson(Map<String, dynamic> json) {
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
  String newsThumb;
  String code;
  String degree;
  String branch;

  Data(
      {this.id,
        this.title,
        this.newsThumb,
        this.code,
        this.degree,
        this.branch});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    newsThumb = json['news_thumb'].toString();
    code = json['code'].toString();
    degree = json['degree'].toString();
    branch = json['branch'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['news_thumb'] = this.newsThumb;
    data['code'] = this.code;
    data['degree'] = this.degree;
    data['branch'] = this.branch;
    return data;
  }
}