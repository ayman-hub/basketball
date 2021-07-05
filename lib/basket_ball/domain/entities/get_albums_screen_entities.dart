class GetAlbumScreenEntities {
  String status;
  String message;
  List<GetAlbumScreenEntitiesData> data;

  GetAlbumScreenEntities({this.status, this.message, this.data});

  GetAlbumScreenEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    if (json['data'] != null) {
      data = new List<GetAlbumScreenEntitiesData>();
      json['data'].forEach((v) {
        data.add(new GetAlbumScreenEntitiesData.fromJson(v));
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

class GetAlbumScreenEntitiesData {
  int id;
  String title;
  String albumThumb;
  List<String> thubmsUrls;

  GetAlbumScreenEntitiesData({this.id, this.title, this.albumThumb, this.thubmsUrls});

  GetAlbumScreenEntitiesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    albumThumb = json['album_thumb'].toString();
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