class GetChildrenCompetitionListingEntities {
  String status;
  String message;
  List<Data> data;

  GetChildrenCompetitionListingEntities({this.status, this.message, this.data});

  GetChildrenCompetitionListingEntities.fromJson(Map<String, dynamic> json) {
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

  Data({this.id, this.title});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['term_id'];
    title = json['name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_id'] = this.id;
    data['name'] = this.title;
    return data;
  }
}