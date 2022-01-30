class GetChildCompetitionInitiationEntities {
  String status;
  String message;
  Data data;

  GetChildCompetitionInitiationEntities({this.status, this.message, this.data});

  GetChildCompetitionInitiationEntities.fromJson(Map<String, dynamic> json) {
    print("1");
    status = json['status'].toString();
    message = json['message'].toString();
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<OrderedTable> orderedTable = List();
  List<Matches> matches;
  List<NewsCompetition> news;
  List<Scorers> scorers;

  Data({this.orderedTable, this.matches, this.news, this.scorers});

  Data.fromJson(Map<String, dynamic> json) {
    print("2");
    if (json['ordered_table'] != null) {
      try{
        json['ordered_table'].keys.forEach((key) {
          orderedTable
              .add(new OrderedTable.fromJson(json['ordered_table'][key]));
        });
        /*   orderedTable = new List<OrderedTable>();
      int itr = json['ordered_table'].length;
      print(itr);
      for(int x = 0 ; x<itr ;x++){
        orderedTable.add(new OrderedTable.fromJson(json['orderd_table'][x]));
      };*/

        /*  while(itr.moveNext()){
        String keys = itr.current;
        print("keys: "+keys);
        orderedTable.add(new OrderedTable.fromJson(json['orderd_table'][x++]));
        // Your stuff here
      }*/
        /* json['ordered_table'].forEach((v) {
        print("3");
        orderedTable.add(new OrderedTable.fromJson(v));
      });*/
      }catch(e){
        print(e);
      }
    }
    if (json['matches'] != null) {
      print("3");
      matches = new List<Matches>();
      json['matches'].forEach((v) {
        print("matches: ${matches.length}");
        matches.add(new Matches.fromJson(v));
      });
    }
    if (json['news'] != null) {
      print("4");
      news = new List<NewsCompetition>();
      print("here news 1");
      json['news'].forEach((v) {
        print("news ${news.length}");
        news.add(new NewsCompetition.fromJson(v));
      });
    }
    if (json['scorers'] != null) {
      print("5");
      scorers = new List<Scorers>();
      json['scorers'].forEach((v) {
        scorers.add(new Scorers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderedTable != null) {
      data['ordered_table'] = this.orderedTable.map((v) => v.toJson()).toList();
    }
    if (this.matches != null) {
      data['matches'] = this.matches.map((v) => v.toJson()).toList();
    }
    if (this.news != null) {
      data['news'] = this.news.map((v) => v.toJson()).toList();
    }
    if (this.scorers != null) {
      data['scorers'] = this.scorers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderedTable {
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

  OrderedTable(
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

  OrderedTable.fromJson(Map<String,dynamic> json) {
    try{
      print("e");
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
    }catch(e){
      print("order table Error : $e");
    }
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

class Matches {
  List<Teams> teams;
  String date;
  String time;

  Matches({this.teams, this.date, this.time});

  Matches.fromJson(Map<String, dynamic> json) {
    print("matches form json : 1");
    if (json['teams'] != null) {
      try{
        print("team 1");
        teams = new List<Teams>();
        if (json['teams'].length == 2) {
          print("matches 2");
          json['teams'].forEach((v) {
            print("teams 3");
            teams.add(new Teams.fromJson(v));
          });
          print("teams to list: ${teams.map((e) => "${e.id}-${e.title}-${e.result.toJson()}-${e.logo}").toList()}");
        } else {
          print("team 2");
          teams.add(Teams(logo: "", result: Result(points: ""), title: ""));
          teams.add(Teams(logo: "", result: Result(points: ""), title: ""));
          print("teams to list: ${teams.map((e) => "${e.id}-${e.title}-${e.result.toJson()}-${e.logo}").toList()}");
        }
      }catch(e){
        print("team Error");
        print("getChildCompetitionInitialError: $e");
        teams.add(Teams(logo: "",result: Result(points: ""),title: ""));
        teams.add(Teams(logo: "",result: Result(points: ""),title: ""));
      }
    }
    date = json['date'].toString();
    time = json['time'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teams != null) {
      data['teams'] = this.teams.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}

class Teams {
  int id;
  String title;
  String logo;
  Result result;

  Teams({this.id, this.title, this.logo, this.result});

  Teams.fromJson(Map<String, dynamic> json) {
    print("team from json 1");
    id = json['id'];
    print("team from json 2");
    title = (json['title']??"").toString();
    print("team from json 3");
    logo = (json['logo']??"").toString();
    print("team from json 4");
    result = json['result'] != null ? new Result.fromJson(json['result']) : "";
    print("team from json 4");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['logo'] = this.logo;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String one;
  String two;
  String three;
  String four;
  String ot;
  String points;
  List<String> outcome;

  Result(
      {this.one,
        this.two,
        this.three,
        this.four,
        this.ot,
        this.points,
        this.outcome});

  Result.fromJson(Map<String, dynamic> json) {
    print("result from json 1");
    one = json['one'].toString();
    print("result from json 1");
    two = json['two'].toString();
    print("result from json 1");
    three = json['three'].toString();
    print("result from json 1");
    four = json['four'].toString();
    print("result from json 1");
    ot = json['ot'].toString();
    print("result from json 1");
    points = json['points'].toString();
    print("result from json 1");
   // outcome = json['outcome'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['one'] = this.one;
    data['two'] = this.two;
    data['three'] = this.three;
    data['four'] = this.four;
    data['ot'] = this.ot;
    data['points'] = this.points;
    data['outcome'] = this.outcome;
    return data;
  }
}

class NewsCompetition {
  int id;
  String title;
  String contents;
  String thumb;
  String date;
  String author;
  String comments;

  NewsCompetition(
      {this.id,
        this.title,
        this.contents,
        this.thumb,
        this.date,
        this.author,
        this.comments});

  NewsCompetition.fromJson(Map<String, dynamic> json) {
    print("news 1");
    id = json['id'];
    print("news 2");
    title = json['title'].toString();
    print("news 3");
    contents = json['contents'].toString();
    print("news 4");
    thumb = json['thumb'].toString();
    print("news 5");
    date = json['date'].toString();
    print("news 6");
    author = json['author'].toString();
    print("news 7");
    comments = json['comments'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    print("news 1");
    data['id'] = this.id;
    print("news 2");
    data['title'] = this.title;
    print("news 3");
    data['contents'] = this.contents;
    print("news 4");
    data['thumb'] = this.thumb;
    print("news 5");
    data['date'] = this.date;
    print("news 6");
    data['author'] = this.author;
    print("news 7");
    data['comments'] = this.comments;
    return data;
  }
}

class Scorers {
  String name;
  List<Players> players;

  Scorers({this.name, this.players});

  Scorers.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    if (json['players'] != null) {
      players = new List<Players>();
      json['players'].forEach((v) {
        players.add(new Players.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.players != null) {
      data['players'] = this.players.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Players {
  String name;
  String team;
  String position;
  String dob;
  String pts;
  int id;
  String thumb;

  Players(
      {this.name,
        this.team,
        this.position,
        this.dob,
        this.pts,
        this.id,
        this.thumb});

  Players.fromJson(Map<String, dynamic> json) {
    name = json['name'].toString();
    team = json['team'].toString();
    position = json['position'].toString();
    dob = json['dob'].toString();
    pts = json['pts'].toString();
    id = json['id'];
    thumb = json['thumb'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['team'] = this.team;
    data['position'] = this.position;
    data['dob'] = this.dob;
    data['pts'] = this.pts;
    data['id'] = this.id;
    data['thumb'] = this.thumb;
    return data;
  }
}