class UserInfoEntities {
  String firstName;
  String lastName;
  String email;
  String password;

  UserInfoEntities({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
  });

  factory UserInfoEntities.fromJson(Map<String, dynamic> json) {
    return UserInfoEntities(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['password'] = this.password;
    return data;
  }
}
