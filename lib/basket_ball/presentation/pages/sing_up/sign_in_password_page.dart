
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/entities/user_data_info.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/main.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';
import '../main_page.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key}) : super(key: key);
  @override
  _ChangePasswordPageState createState() {
    return _ChangePasswordPageState();
  }
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
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
          ListView(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height /30 ),
                child: Image.asset(Res.email_blocker),
              ),
              SizedBox(height: 30,),
              Form(
                key: formkey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                 /* margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 20,
                      right: MediaQuery.of(context).size.width / 20,
                      top: MediaQuery.of(context).size.height / 3,
                      bottom: MediaQuery.of(context).size.height / 8),*/
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "الرقم السري الجديد",
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
                              password = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'عفوا يجب كتابة الرقم السري الجديد الخاص بك';
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
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 1,
                          onChanged: (value) {
                          },
                          validator: (value) {
                            print(value);
                            print(password);
                            if (password != value) {
                              return 'عفوا يجب كتابة الرقم السري الخاص بك';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              hintText: "تأكيد الرقم السري",
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
                      SizedBox(
                        height: 5,
                      ),
                      TextButton(
                          onPressed: () async {
                            if (formkey.currentState.validate()) {
                              var response = await sl<Cases>()
                                  .updateUserPassword(password);
                              if (response is bool) {
                                Move.to(context: context, page: MainPage());
                                var platform = Theme.of(context).platform;
                                platform == TargetPlatform.iOS
                                    ? Get.snackbar("", "",
                                    messageText: Text(
                                      "تم تغير الرقم السري بنجاح",
                                      textAlign: TextAlign.center,
                                    ))
                                    : showToast(context, "تم تغير الرقم السري بنجاح");
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
                              "حفظ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              TextButton(
                onPressed: () => Move.back(context),
                child: Container(
              //    margin: EdgeInsets.only(left: 30),
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
            ],
          )
        ],
      ),
     // floatingActionButton: ,
    );
  }
}