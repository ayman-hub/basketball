import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/main.dart';
import 'package:hi_market/main.dart';

import '../../../injection.dart';
import '../../../res.dart';
import '../../../toast_utils.dart';
import 'main_page.dart';

class ComplainPage extends StatefulWidget {
  ComplainPage({Key key}) : super(key: key);

  @override
  _ComplainPageState createState() {
    return _ComplainPageState();
  }
}

class _ComplainPageState extends State<ComplainPage> {
  String message = "";
  String name = "";
  String email = "";
  String phone = "";

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
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            Res.wightbasketimage,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: Container(),
            title: Text(
              "الشكاوى والاقتراحات",
              style: GoogleFonts.cairo(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            actions: [
              backIconAction(() {
                Get.back();
              })
            ],
          ),
          body: Stack(
            children: [
              Form(
                // key: formKey,
                child: Container(
                  child: ListView(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            maxLines: 10,
                            onChanged: (value) {
                              setState(() {
                                message = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'املأ البيانات';
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: getTextFieldDecoration('الشكوي'),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  maxLines: 1,
                                  onChanged: (value) {
                                    setState(() {
                                      name = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'املأ البيانات';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(fontSize: 15.0),
                                  decoration: getTextFieldDecoration('الإسم'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Directionality(
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
                                  decoration: getTextFieldDecoration('البريد الاكترونى'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  maxLines: 1,
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
                                  decoration: getTextFieldDecoration('رقم الموبايل'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () async {
                            if (email != "" &&
                                phone != "" &&
                                message != "" &&
                                name != "") {
                              var response = await sl<Cases>().contactUs(
                                  email: email,
                                  phone: phone,
                                  message: message,
                                  name: name);
                              if (response is bool) {
                                var platform = Theme.of(context).platform;
                                platform == TargetPlatform.iOS
                                    ? Get.snackbar("", "",
                                        messageText: Text(
                                          "تم ارسال الشكوى بنجاح",
                                          textAlign: TextAlign.center,
                                        ))
                                    : showToast(
                                        context, "تم ارسال الشكوى بنجاح");
                                Move.to(context: context, page: MyHomePage());
                              } else if (response is ResponseModelFailure) {
                                var platform = Theme.of(context).platform;
                                platform == TargetPlatform.iOS
                                    ? Get.snackbar("", "",
                                        messageText: Text(
                                          response.message,
                                          textAlign: TextAlign.center,
                                        ))
                                    : showToast(context, response.message);
                              } else {
                                var platform = Theme.of(context).platform;
                                platform == TargetPlatform.iOS
                                    ? Get.snackbar("", "",
                                        messageText: Text(
                                          "Connection Error",
                                          textAlign: TextAlign.center,
                                        ))
                                    : showToast(context, "Connection Error");
                              }
                            } else {
                              showToast(context, "من فضلك املأ البيانات اولا");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: staticColor,
                           /*   boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0,
                                      2.0), // shadow direction: bottom right
                                )
                              ],*/
                            ),
                            //height: MediaQuery.of(context).size.height / 9,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              "ارسال",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 30, left: 30),
                          child: Text(
                            ":يمكنك التواصل معنا من خلال ",
                            style: GoogleFonts.cairo(fontSize: 20),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextButton.icon(
                                onPressed: () {
                                  launchPhone("0224011635");
                                },
                                label: Text(
                                  "0224011635",
                                  style: GoogleFonts.cairo(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                icon:
                                    Image.asset("images/phone_contact_us.png"),
                              ),
                            ),
                            //  SizedBox(width: 20,),
                            // Text("الهاتف",style: TextStyle(color: Colors.black,fontSize: 20),),
                            //  SizedBox(width: 20,),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextButton.icon(
                                onPressed: () {
                                  launchPhone("0224011798");
                                },
                                label: Text(
                                  "0224011798",
                                  style: GoogleFonts.cairo(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                icon:
                                    Image.asset("images/phone_contact_us.png"),
                              ),
                            ),
                            //  SizedBox(width: 20,),
                            // Text("الهاتف",style: TextStyle(color: Colors.black,fontSize: 20),),
                            //  SizedBox(width: 20,),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(right: 20, left: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextButton.icon(
                                onPressed: () {
                                  launchEmail("info@egypt.basketball");
                                },
                                label: Text(
                                  "info@egypt.basketball",
                                  style: GoogleFonts.cairo(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                icon:
                                    Image.asset("images/email_contact_us.png"),
                              ),
                            ),
                            // SizedBox(width: 20,),
                            //Text("البريد الإلكتروني",style: TextStyle(color: Colors.black,fontSize: 20),),
                            // SizedBox(width: 20,),
                          ],
                        ),
                      ),
                      //   SizedBox(width: 100,),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: getNavigationBar(context),
        ),
      ],
    );
  }


}
