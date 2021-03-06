
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/entities/username_password_entities.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/referee_sign/referee_sing_up_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/main.dart';
import 'package:hi_market/main.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';
import '../main_page.dart';
import 'forget_password/ForgetPasswordPage.dart';

class RefereeSignINPage extends StatefulWidget {
  RefereeSignINPage({Key key}) : super(key: key);

  @override
  _RefereeSignINPageState createState() {
    return _RefereeSignINPageState();
  }
}

class _RefereeSignINPageState extends State<RefereeSignINPage> {
  String email;

  String password;


  ProgressDialog dialog ;
  final formkey = GlobalKey<FormState>();

  bool showProgress = false;

  @override
  void initState() {
    super.initState();
    dialog = ProgressDialog(context);
  }

  @override
  void dispose() {
    super.dispose();
    dialog.hide();
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
                margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
                child: Image.asset(Res.logo),
              ),
              SizedBox(height: 20,),
              Form(
                key: formkey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "???????????? ????????",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
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
                              return '???????? ?????? ?????????? ???????????? ???????????????????? ???? ?????????? ?????????? ????';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              hintText: "???????????? ????????????????????/?????? ????????????????",
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
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
                              return '???????? ?????? ?????????? ?????????? ?????????? ?????????? ????';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              hintText: "?????????? ??????????",
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () =>
                              Move.to(context: context, page: ForgetPasswordPage()),
                          child: Text(
                            "???????? ???????? ????????????",
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
                             setState(() {
                               showProgress = true;
                             });
                              var response = await sl<Cases>()
                                  .login(email: email, password: password);
                              setState(() {
                                showProgress = false;
                              });

                              if (response is LoginDataEntities) {
                                if (response.data.isActivated.toString() == "1") {

                                    sl<Cases>().setUserPassword(UserNameAndPasswordEntities(userName: email,password: password));
                                    sl<Cases>().setLoginData(response);
                                    Move.noBack(
                                        context: context,
                                        page: RefereeMainPage());
                                }else{
                                  Move.to(context: context, page:MyHomePage());
                                  showToast(context, "???????? ?????????? ???????? ???? ?????? ???????? ???????? ???? ??????????????");
                                }
                              }else if (response is ResponseModelFailure) {

                                var platform = Theme.of(context).platform;
                                platform == TargetPlatform.iOS
                                    ? Get.snackbar("", "",
                                    messageText: Text(
                                      response.message,
                                      textAlign: TextAlign.center,
                                    ))
                                    : showToast(context, response.message);
                              }else {
                                print("hsssss");

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
                              "?????????? ????????????",
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
                                  Move.to(context: context, page: RefereeSignUpPage()),
                              child: Text(
                                "???????? ????????",
                                style: TextStyle(color: Color(0xffE31E24)),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text(" ?????? ?????? ????????")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              FlatButton(
                onPressed: () => Move.to(context: context, page:MyHomePage()),
                child: Container(
                  //margin: EdgeInsets.only(left: 30),
                  // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 12,
                  alignment: Alignment.center,
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
            ],
          ),
          showProgress?getLoadingContainer(context):Container()
        ],
      ),
      bottomNavigationBar: getNavigationBar(context),
    );
  }
}
