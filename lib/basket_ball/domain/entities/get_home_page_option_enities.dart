class GetHomePageOptionsEntities {
  String status;
  String message;
  List<Data> data;

  GetHomePageOptionsEntities({this.status, this.message, this.data});

  GetHomePageOptionsEntities.fromJson(Map<String, dynamic> json) {
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
 String streamLink;

  Data({this.streamLink});

  Data.fromJson(Map<String, dynamic> json) {
    String str = json['streaming_link'].toString();
   String   start = "http";
    String end = '\"';
    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);
    print(str.substring(startIndex + start.length, endIndex));
    streamLink ="http${str.substring(startIndex + start.length, endIndex)}";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streaming_link'] = this.streamLink;
    return data;
  }
}