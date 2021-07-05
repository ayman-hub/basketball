class LoginDataEntities {
  String status;
  String message;
  Data data;

  LoginDataEntities({this.status, this.message, this.data});

  LoginDataEntities.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
  String userID;
  String userLogin;
  String userEmail;
  String userName;
  String userRole;
  String userPhone;
  String nationalId;
  String bankName;
  String accountNo;
  String iban;
  String swiftCode;
  String profilePic;
  int isActivated;

  Data(
      {this.token,
        this.userID,
        this.userLogin,
        this.userEmail,
        this.userName,
        this.userRole,
        this.userPhone,
        this.nationalId,
        this.bankName,
        this.accountNo,
        this.iban,
        this.swiftCode,
        this.profilePic,
        this.isActivated});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userID = json['userID'];
    userLogin = json['userLogin'];
    userEmail = json['userEmail'];
    userName = json['userName'];
    userRole = json['userRole'];
    userPhone = json['userPhone'];
    nationalId = json['national_id'];
    bankName = json['bank_name'];
    accountNo = json['account_no'];
    iban = json['iban'];
    swiftCode = json['swift_code'];
    profilePic = json['profile_pic'];
    isActivated = json['is_activated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userID'] = this.userID;
    data['userLogin'] = this.userLogin;
    data['userEmail'] = this.userEmail;
    data['userName'] = this.userName;
    data['userRole'] = this.userRole;
    data['userPhone'] = this.userPhone;
    data['national_id'] = this.nationalId;
    data['bank_name'] = this.bankName;
    data['account_no'] = this.accountNo;
    data['iban'] = this.iban;
    data['swift_code'] = this.swiftCode;
    data['profile_pic'] = this.profilePic;
    data['is_activated'] = this.isActivated;
    return data;
  }
}