class SingleTeamRelatedAlbumsEntities {
  String status;
  String message;
  List<Data> data;

  SingleTeamRelatedAlbumsEntities({this.status, this.message, this.data});

  SingleTeamRelatedAlbumsEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
  String albumThumb;
  List<String> thubmsUrls;

  Data({this.id, this.title, this.albumThumb, this.thubmsUrls});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    albumThumb = json['album_thumb'];
    thubmsUrls = json['thubms_urls'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['album_thumb'] = this.albumThumb;
    data['thubms_urls'] = this.thubmsUrls;
    return data;
  }
}