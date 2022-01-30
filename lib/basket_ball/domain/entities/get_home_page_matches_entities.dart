
class GetHomePageMatchesEntities {
  String status;
  String message;
  List<GetHomePageMatchesData> data;

  GetHomePageMatchesEntities({this.status, this.message, this.data});

  GetHomePageMatchesEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    if (json['data'] != null) {
      data = new List<GetHomePageMatchesData>();
      json['data'].forEach((v) {
        data.add(new GetHomePageMatchesData.fromJson(v));
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

class GetHomePageMatchesData {
  int id;
  String title;
  String time;
  List<Teams> teams;
  List<String> points;

  GetHomePageMatchesData({this.id, this.title, this.time, this.teams,this.points});

  GetHomePageMatchesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = (json['title']??"").toString();
    time = (json['time']??"").toString();
    if (json['teams'] != null) {
      teams = new List<Teams>();
      json['teams'].forEach((v) {
        teams.add(new Teams.fromJson(v));
      });
    }
    points = List();
    print("sssssmm");
    print("result:${json['result']}");
    if(json['result']!= false ){
      List dd = json['result']??"";
      print("runType:${dd.first.runtimeType}");
      if (json['teams'] != null&&json['result']!=null&&dd.first.runtimeType.toString() == "_InternalLinkedHashMap<String, dynamic>") {
        print("sssss");
        List<dynamic> results = json['result'];
        print(results.toList());
        print("result:${results.length}");
        print(results.first[teams.first.id]);
        print(results.first[teams.first.id]['points']);
        print("result.length:${results.length}");
        try{
          for (int x = 0; x < 2; x++) {
            print("sssssss$x");
            // Map<String, dynamic> d = results[x];
            points.add((results[0][teams[x].id]['points']).toString());
          }
        }catch(e){
          print("error ${time}  : $e");
          points.add("");
          points.add("");
        }
      }else{
        points.add("");
        points.add("");
      }
    }else{
      points.add("");
      points.add("");
    }
    print(points.toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['time'] = this.time;
    if (this.teams != null) {
      data['teams'] = this.teams.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teams {
  String id;
  String name;
  String thumb;

  Teams({this.name, this.thumb,this.id});

  Teams.fromJson(Map<String, dynamic> json) {
    name = json['name']??"".toString();
    thumb = (json['thumb']??"").toString();
    id = json['team_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['thumb'] = this.thumb;
    data['team_id'] = this.id;
    return data;
  }
}

