class GetMatchIdEntities {
  List<String> data;

  GetMatchIdEntities({this.data});

  GetMatchIdEntities.fromJson(Map<String ,dynamic> json){
    if (json['data'] != null) {
      data = new List<String>();
      json['data'].forEach((v) {
        data.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v).toList();
    }
    return data;
  }
}

