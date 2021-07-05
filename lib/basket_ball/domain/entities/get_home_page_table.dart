class GetHomePageTableEntities {
  String status;
  String message;
  List<Data> data;

  GetHomePageTableEntities({this.status, this.message, this.data});

  GetHomePageTableEntities.fromJson(Map<String, dynamic> json) {
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
  String name;
  String w;
  String l;
  String pct;
  String gb;
  String home;
  String road;
  String lten;
  String strk;
  String pf;
  String pa;
  String diff;
  int id;
  String logoUrl;

  Data(
      {this.name,
        this.w,
        this.l,
        this.pct,
        this.gb,
        this.home,
        this.road,
        this.lten,
        this.strk,
        this.pf,
        this.pa,
        this.diff,
        this.id,
        this.logoUrl});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    w = json['w'].toString();
    l = json['l'].toString();
    pct = json['pct'].toString();
    gb = json['gb'].toString();
    home = json['home'].toString();
    road = json['road'].toString();
    lten = json['lten'].toString();
    strk = json['strk'].toString();
    pf = json['pf'].toString();
    pa = json['pa'].toString();
    diff = json['diff'].toString();
    id = json['id'];
    logoUrl = json['logo_url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['w'] = this.w;
    data['l'] = this.l;
    data['pct'] = this.pct;
    data['gb'] = this.gb;
    data['home'] = this.home;
    data['road'] = this.road;
    data['lten'] = this.lten;
    data['strk'] = this.strk;
    data['pf'] = this.pf;
    data['pa'] = this.pa;
    data['diff'] = this.diff;
    data['id'] = this.id;
    data['logo_url'] = this.logoUrl;
    return data;
  }
}