class GetHomePageVideosEntities {
  String status;
  String message;
  List<Data> data;

  GetHomePageVideosEntities({this.status, this.message, this.data});

  GetHomePageVideosEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        print("aa1");
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
  String link;
  VideoType videoType;

  Data({this.id, this.title, this.link});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    print("1");
    String str = json['link'].toString();
    print("dd: $str");
    try{
      if (str.toLowerCase().contains("youtu")) {
        videoType = VideoType.youtube;
        /*String start = "http";
        String end = '\"';
        final startIndex = str.indexOf(start);
        final endIndex = str.indexOf(end, startIndex + start.length);
        print(str.substring(startIndex + start.length, endIndex));*/
        link  = str;//str.replaceAll("watch?v=","embed/");;
      } else {
        videoType = VideoType.video;
        link = json['link'].toString();
      }
    }catch(e){
      print("error: $e");
      videoType = VideoType.video;
      link = json['link'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.link;
    return data;
  }
}

enum VideoType {
  youtube,video
}