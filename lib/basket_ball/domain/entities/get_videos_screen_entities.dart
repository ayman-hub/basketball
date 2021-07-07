import 'package:flutter/material.dart';

import 'get_home_page_videos_entities.dart';

class GetVideosScreenEntities {
  String status;
  String message;
  List<Data> data;

  GetVideosScreenEntities({this.status, this.message, this.data});

  GetVideosScreenEntities.fromJson(Map<String, dynamic> json) {
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
  List<Videos> videos;

  Data({this.id, this.title, this.videos});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    if (json['Videos'] != null) {
      videos = new List<Videos>();
      json['Videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.videos != null) {
      data['Videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  int id;
  String title;
  String attachmentUrl;

  VideoType videoType;

  Videos({this.id, this.title, this.attachmentUrl});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    print("1");
    String str = json['link'].toString();
    print("dd: $str");
    try{
      print(str.toLowerCase());
      print(str.toLowerCase().contains("youtu"));
      if (str.toLowerCase().contains("youtu")) {
        videoType = VideoType.youtube;
        print("youtubeLink");
       /* String start = "http";
        String end = '\"';
        final startIndex = str.indexOf(start);
        final endIndex = str.indexOf(end, startIndex + start.length);
        print(str.substring(startIndex + start.length, endIndex));*/
        attachmentUrl = str;//str.replaceAll("watch?v=","embed/");
      } else {
        videoType = VideoType.video;
        attachmentUrl = json['link'].toString();
      }
    }catch(e){
      print("error: $e");
      videoType = VideoType.video;
      attachmentUrl = json['link'].toString();
    }
   // attachmentUrl = json['attachment_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link'] = this.attachmentUrl;
    return data;
  }
}