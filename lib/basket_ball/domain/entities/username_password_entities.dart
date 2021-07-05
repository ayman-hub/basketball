class UserNameAndPasswordEntities{
  String userName;
  String password;

  UserNameAndPasswordEntities({this.userName, this.password});

  factory UserNameAndPasswordEntities.fromJson(Map<dynamic, dynamic> mapName){
    return UserNameAndPasswordEntities(
      userName: mapName['userName'],
      password: mapName['password'],
    );
  }

  toJson(){
    Map<String, String> json = Map();
    json['userName']=userName;
    json['password']=password;
    return json;
  }
}