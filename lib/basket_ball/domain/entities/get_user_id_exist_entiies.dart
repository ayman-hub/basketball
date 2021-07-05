class GetUserIdExistDataEntities {
  String status;
  String message;
  Data data;

  GetUserIdExistDataEntities({this.status, this.message, this.data});

  GetUserIdExistDataEntities.fromJson(Map<String, dynamic> json) {
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
  String token;
  UserID userID;
  bool userExists;
  String userLogin;
  String userEmail;
  String userRole;
  bool userPhone;
  bool nationalId;
  String profilePic;

  Data(
      {this.token,
        this.userID,
        this.userExists,
        this.userLogin,
        this.userEmail,
        this.userRole,
        this.userPhone,
        this.nationalId,
        this.profilePic});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userID =
    json['userID'] != null ? new UserID.fromJson(json['userID']) : null;
    userExists = json['userExists'];
    userLogin = json['userLogin'];
    userEmail = json['userEmail'];
    userRole = json['userRole'];
    userPhone = json['userPhone'];
    nationalId = json['national_id'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userID != null) {
      data['userID'] = this.userID.toJson();
    }
    data['userExists'] = this.userExists;
    data['userLogin'] = this.userLogin;
    data['userEmail'] = this.userEmail;
    data['userRole'] = this.userRole;
    data['userPhone'] = this.userPhone;
    data['national_id'] = this.nationalId;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}

class UserID {
  Errors errors;
  List errorData;

  UserID({this.errors, this.errorData});

  UserID.fromJson(Map<String, dynamic> json) {
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    if (json['error_data'] != null) {
      errorData = new List();
      json['error_data'].forEach((v) {
        errorData.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    if (this.errorData != null) {
      data['error_data'] = this.errorData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  List<String> existingUserLogin;

  Errors({this.existingUserLogin});

  Errors.fromJson(Map<String, dynamic> json) {
    existingUserLogin = json['existing_user_login'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['existing_user_login'] = this.existingUserLogin;
    return data;
  }
}