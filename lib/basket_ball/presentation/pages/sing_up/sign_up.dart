
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/entities/user_data_info.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/referee_sign/forget_password/ForgetPasswordPage.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/sing_up/sing_in.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../sign_with_google.dart';
import '../../../../toast_utils.dart';
import '../main_page.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  String email;

  String password;

  final formkey = GlobalKey<FormState>();

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
          Container(
            alignment: Alignment.topCenter,
            //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height /30 ),
            child: Image.asset(Res.logo),
          ),
          Form(
            key: formkey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 20,
                  right: MediaQuery.of(context).size.width / 20,
                  top: MediaQuery.of(context).size.height / 5.5,
                  bottom: MediaQuery.of(context).size.height / 10),
              child: ListView(
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
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'عفوا يجب كتابة البريد الالكتروني الخاص بك';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 15.0),
                      decoration: InputDecoration(
                          hintText: "البريد الالكتروني",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                          return 'عفوا يجب كتابة الرقم السري الخاص بك';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 15.0),
                      decoration: InputDecoration(
                          hintText: "الرقم السري",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () =>
                        Move.to(context: context, page: ForgetPasswordPage()),
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "نسيت كلمة المرور",
                        style: TextStyle(color: Color(0xffE31E24), fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FlatButton(
                      onPressed: () async {
                        if (formkey.currentState.validate()) {
                          var response = await sl<Cases>()
                              .login(email: email, password: password);
                          if (response is LoginDataEntities) {
                            var platform = Theme.of(context).platform;
                            platform == TargetPlatform.iOS
                                ? Get.snackbar("", "",
                                    messageText: Text(
                                      "تم تسجيل الدخول بنجاح",
                                      textAlign: TextAlign.center,
                                    ))
                                : showToast(context, "تم تسجيل الدخول بنجاح");
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
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                              Move.to(context: context, page: SignInPage()),
                          child: Text(
                            "حساب جديد",
                            style: TextStyle(color: Color(0xffE31E24)),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Text(" ليس لدي حساب")
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
                         /*   dynamic data = await loginFacebook();
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
                       /*     dynamic data = await signInWithGoogle();
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
        ],
      ),
      floatingActionButton: FlatButton(
        onPressed: () => Move.to(context: context, page: MainPage()),
        child: Container(
          margin: EdgeInsets.only(left: 30),
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
    );
  }
}
