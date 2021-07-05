class GetCompetitionNewsLoadMoreEntities {
  String status;
  String message;
  List<Data> data;

  GetCompetitionNewsLoadMoreEntities({this.status, this.message, this.data});

  GetCompetitionNewsLoadMoreEntities.fromJson(Map<String, dynamic> json) {
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
  String contents;
  String thumb;
  String date;
  String author;
  String comments;

  Data(
      {this.id,
        this.title,
        this.contents,
        this.thumb,
        this.date,
        this.author,
        this.comments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    contents = json['contents'].toString();
    thumb = json['thumb'].toString();
    date = json['date'].toString();
    author = json['author'].toString();
    comments = json['comments'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['contents'] = this.contents;
    data['thumb'] = this.thumb;
    data['date'] = this.date;
    data['author'] = this.author;
    data['comments'] = this.comments;
    return data;
  }
}