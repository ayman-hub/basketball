class GetChildCompetitionInitiationChildrenEntities {
  String status;
  String message;
  Data data;

  GetChildCompetitionInitiationChildrenEntities(
      {this.status, this.message, this.data});

  GetChildCompetitionInitiationChildrenEntities.fromJson(
      Map<String, dynamic> json) {
    print("1");
    status = json['status'].toString();
    print("2");
    message = json['message'].toString();
    print("3");
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
  List<OrderedTable> orderedTable;
  List<Matches> matches;
  List<News> news;
  List<Scorers> scorers;

  Data({this.orderedTable, this.matches, this.news, this.scorers});

  Data.fromJson(Map<String, dynamic> json) {
    print("4");
    if (json['ordered_table'] != null) {
      orderedTable = new List<OrderedTable>();
      json['ordered_table'].forEach((v) {
        print("5");
        orderedTable.add(new OrderedTable.fromJson(v));
      });
    }
    if (json['matches'] != null) {
      print("6");
      matches = new List<Matches>();
      json['matches'].forEach((v) {
        matches.add(new Matches.fromJson(v));
      });
    }
    if (json['news'] != null) {
      print("7");
      news = new List<News>();
      json['news'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }
    if (json['scorers'] != null) {
      print("8");
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

  OrderedTable.fromJson(Map<String, dynamic> json) {
    print("9");
    name = json['name'].toString();
    print("10");
    w = json['w'].toString();
    print("11");
    l = json['l'].toString();
    print("12");
    pct = json['pct'].toString();
    print("13");
    gb = json['gb'].toString();
    print("14");
    home = json['home'].toString();
    print("15");
    road = json['road'].toString();
    print("16");
    lten = json['lten'].toString();
    print("17");
    strk = json['strk'].toString();
    print("18");
    pf = json['pf'].toString();
    print("19");
    pa = json['pa'].toString();
    print("20");
    diff = json['diff'].toString();
    print("21");
    id = json['id'];
    print("22");
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

class Matches {
  List<Teams> teams;
  String date;
  String time;

  Matches({this.teams, this.date, this.time});

  Matches.fromJson(Map<String, dynamic> json) {
    if (json['teams'] != null) {
      print("23");
      teams = new List<Teams>();
      json['teams'].forEach((v) {
        print("24");
        teams.add(new Teams.fromJson(v));
      });
    }
    date = json['date'];
    time = json['time'];
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
    id = json['id'];
    print("25");
    title = json['title'].toString();
    print("26");
    logo = json['logo'].toString();
    print("27");
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
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
    one = json['one'].toString();
    two = json['two'].toString();
    three = json['three'].toString();
    four = json['four'].toString();
    ot = json['ot'].toString();
    points = json['points'].toString();
    //outcome = json['outcome'].cast<String>();
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

class News {
  int id;
  String title;
  String contents;
  String thumb;
  String date;
  String author;
  String comments;

  News(
      {this.id,
        this.title,
        this.contents,
        this.thumb,
        this.date,
        this.author,
        this.comments});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'].toString();
    contents = json['contents'].toString();
    thumb = json['thumb'].toString();
    date = json['date'].toString();
    author = json['author'].toString();
    comments = json['comments'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['contents'] = this.contents;
    data['thumb'] = this.thumb;
    data['date'] = this.date;
    data['author'] = this.author;
    data['comments'] = this.comments;
    return data;
  }
}

class Scorers {
  String name;
  List<Players> players;

  Scorers({this.name, this.players});

  Scorers.fromJson(Map<String, dynamic> json) {
    print("22");
    name = json['name'];
    if (json['players'] != null) {
      players = new List<Players>();
      json['players'].forEach((v) {
        print("25");
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
    print("30");
    name = json['name'].toString();
    print("31");
    team = json['team'].toString();
    print("32");
    position = json['position'].toString();
    print("33");
    dob = json['dob'].toString();
    print("34");
    pts = json['pts'].toString();
    print("35");
    id = json['id'];
    print("36");
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