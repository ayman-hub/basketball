
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/entities/user_data_info.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/sing_up/sign_in_password_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/sing_up/sign_up.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../sign_with_google.dart';
import '../../../../toast_utils.dart';
import '../main_page.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  String fName;
  String lName;
  String password;
  String email;
  String phone;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Image.asset(
              Res.blackballimage,
              fit: BoxFit.fill,
            ),
          ),
          ListView(
            children: [
              Container(
                alignment: Alignment.topCenter,
              //  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    child: Image.asset(Res.logo)),
              ),
              SizedBox(height: 5,),
              Form(
                key: formKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  /*       margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 20,
                  right: MediaQuery.of(context).size.width / 20,
                  top: MediaQuery.of(context).size.height / 5,
                  bottom: MediaQuery.of(context).size.height / 11),*/
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "سجل الأن",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 1,
                          onChanged: (value) {
                            setState(() {
                              fName = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'املأ البيانات';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              hintText: "الاسم",
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 1,
                          onChanged: (value) {
                            setState(() {
                              lName = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'املأ البيانات';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              hintText: "الاسم العائلة",
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 1,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'املأ البيانات';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              hintText: "البريد الالكتروني",
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 1,
                          keyboardType: TextInputType.numberWithOptions(),
                          onChanged: (value) {
                            setState(() {
                              phone = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'املأ البيانات';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              hintText: "الهاتف",
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 1,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'املأ البيانات';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              hintText: "الرقم السري",
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 1,
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'املأ البيانات';
                            }
                            if (value != password) {
                              return "لا يطابق الرقم السري";
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              hintText: "تأكيد الرقم السري",
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              var response = await sl<Cases>().userRegister(
                                  firstName: fName,
                                  lastName: lName,
                                  email: email,
                                  password: password,
                                  phone: phone);
                              if (response is bool) {
                                var platform = Theme.of(context).platform;
                                platform == TargetPlatform.iOS
                                    ? Get.snackbar("", "",
                                    messageText: Text(
                                      "تم التسجيل بنجاح",
                                      textAlign: TextAlign.center,
                                    ))
                                    : showToast(context, "تم التسجيل بنجاح");
                                Move.to(context: context, page: SignUpPage());
                              } else if (response is ResponseModelFailure) {
                                var platform = Theme.of(context).platform;
                                platform == TargetPlatform.iOS
                                    ? Get.snackbar("", "",
                                    messageText: Text(
                                      response.message,
                                      textAlign: TextAlign.center,
                                    ))
                                    : showToast(context, response.message);
                              }else{
                                var platform = Theme.of(context).platform;
                                platform == TargetPlatform.iOS
                                    ? Get.snackbar("", "",
                                    messageText: Text(
                                      "Connection Error",
                                      textAlign: TextAlign.center,
                                    ))
                                    : showToast(context,  "Connection Error");
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffE31E24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(
                                      2.0, 2.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            //height: MediaQuery.of(context).size.height / 9,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              "تسجيل",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () =>
                                  Move.to(context: context, page: SignUpPage()),
                              child: Text(
                                "سجل الأن",
                                style: TextStyle(color: Color(0xffE31E24)),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text("لديك حساب بالفعل ؟")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 12,right:  MediaQuery.of(context).size.width / 12),
                        child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: ()async{
                            /*    dynamic data = await loginFacebook();
                                if(data is UserInfoEntities){
                                  UserInfoEntities user = data;
                                  print("userInfo: ${user.toJson()}");
                                  var response = await sl<Cases>().socialMediaLogin(user.firstName, user.email, RoleType.Guest);
                                  if (response is LoginDataEntities) {
                                    var platform = Theme.of(context).platform;
                                    platform == TargetPlatform.iOS
                                        ? Get.snackbar("", "",
                                        messageText: Text(
                                          "Login successfully",
                                          textAlign: TextAlign.center,
                                        ))
                                        : showToast(context, "Login successfully");
                                    sl<Cases>().setLoginData(response);
                                    if (response.data.userRole == "Judge") {
                                      Move.to(context: context, page: RefereeMainPage());
                                    }else{
                                      Move.to(context: context, page: MainPage());
                                    }
                                  }if (response is ResponseModelFailure) {
                                    var platform = Theme.of(context).platform;
                                    platform == TargetPlatform.iOS
                                        ? Get.snackbar("", "",
                                        messageText: Text(
                                          response.message,
                                          textAlign: TextAlign.center,
                                        ))
                                        : showToast(context, response.message);
                                  }else {
                                    var platform = Theme.of(context).platform;
                                    platform == TargetPlatform.iOS
                                        ? Get.snackbar("", "",
                                        messageText: Text(
                                          "Connection Error",
                                          textAlign: TextAlign.center,
                                        ))
                                        : showToast(context, "Connection Error");
                                  }
                                  // Move.to(context: context, page: SignInPasswordPage(user: user));
                                }else{
                                  showToast(context, "error $data");
                                  print("error $data");
                                }*/
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue[800],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(
                                          2.0, 2.0), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text("Facebook",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width / 20),),
                              ),
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: ()async{
                              /*  dynamic data = await signInWithGoogle();
                                if(data is UserInfoEntities){
                                  UserInfoEntities user = data;
                                  print("userInfo: ${user.toJson()}");
                                  var response = await sl<Cases>().socialMediaLogin(user.firstName, user.email, RoleType.Guest);
                                  if (response is LoginDataEntities) {
                                    var platform = Theme.of(context).platform;
                                    platform == TargetPlatform.iOS
                                        ? Get.snackbar("", "",
                                        messageText: Text(
                                          "Login successfully",
                                          textAlign: TextAlign.center,
                                        ))
                                        : showToast(context, "Login successfully");
                                    sl<Cases>().setLoginData(response);
                                    if (response.data.userRole == "Judge") {
                                      Move.to(context: context, page: RefereeMainPage());
                                    }else{
                                      Move.to(context: context, page: MainPage());
                                    }
                                  }if (response is ResponseModelFailure) {
                                    var platform = Theme.of(context).platform;
                                    platform == TargetPlatform.iOS
                                        ? Get.snackbar("", "",
                                        messageText: Text(
                                          response.message,
                                          textAlign: TextAlign.center,
                                        ))
                                        : showToast(context, response.message);
                                  }else {
                                    var platform = Theme.of(context).platform;
                                    platform == TargetPlatform.iOS
                                        ? Get.snackbar("", "",
                                        messageText: Text(
                                          "Connection Error",
                                          textAlign: TextAlign.center,
                                        ))
                                        : showToast(context, "Connection Error");
                                  }
                                  // Move.to(context: context, page: SignInPasswordPage(user: user));
                                }else{
                                  showToast(context, "error $data");
                                  print("error $data");
                                }*/
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xffE31E24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(
                                          2.0, 2.0), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text("Google",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width / 20),),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              FlatButton(
                onPressed: () => Move.to(context: context, page: MainPage()),
                child: Container(
                  // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 12,
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 19,
                    width: MediaQuery.of(context).size.height / 19,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffE31E24),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ],
      ),
      //floatingActionButton: ,
    );
  }
}
