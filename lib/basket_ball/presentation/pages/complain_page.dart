
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
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
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              Res.wightbasketimage,
              fit: BoxFit.fill,
            ),
          ),
          Form(
           // key: formKey,
            child: Container(
              child: ListView(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset(
                            Res.backimage,
                            color: Color(0xffE31E24),
                          ),
                          onPressed: () =>
                              Move.to(context: context, page: MyHomePage())),
                    ],
                  ),
                  Container(
                   // padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Text(
                      "الشكاوى والاقتراحات",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:BorderRadius.circular(32.0)
                      ),
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
                        decoration: InputDecoration(
                            hintText: "الشكوي",
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:BorderRadius.circular(10)
                          ),
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
                              decoration: InputDecoration(
                                  hintText: "الإسم",
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:BorderRadius.circular(10)
                          ),
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
                              decoration: InputDecoration(
                                  hintText: "البريد الاكترونى",
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:BorderRadius.circular(10)
                          ),
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
                              decoration: InputDecoration(
                                  hintText: "رقم الموبايل",
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                      onPressed: () async {
                        if (email != ""&&phone != ""&& message != ""&&name != "") {
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
                                : showToast(context, "تم ارسال الشكوى بنجاح");
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
                        }else{
                          showToast(context, "من فضلك املأ البيانات اولا");
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
                          "ارسال",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      )),
                  SizedBox(height: 20,),
                  Container(
                    alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 30,left: 30),
                      child:Text(":يمكنك التواصل معنا من خلال ",style: GoogleFonts.cairo(fontSize: 20),)
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(right: 20,left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: (){
                              launchPhone("0224011635");
                            },
                            label: Text("0224011635",style: GoogleFonts.cairo(color: Colors.grey,fontSize: 20),),
                            icon: Image.asset("images/phone_contact_us.png"),
                          ),
                        ),
                        //  SizedBox(width: 20,),
                        // Text("الهاتف",style: TextStyle(color: Colors.black,fontSize: 20),),
                        //  SizedBox(width: 20,),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(right: 20,left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: (){
                              launchPhone("0224011798");
                            },
                            label: Text("0224011798",style: GoogleFonts.cairo(color: Colors.grey,fontSize: 20),),
                          icon: Image.asset("images/phone_contact_us.png"),
                          ),
                        ),
                      //  SizedBox(width: 20,),
                       // Text("الهاتف",style: TextStyle(color: Colors.black,fontSize: 20),),
                      //  SizedBox(width: 20,),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.only(right: 20,left: 20,bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: (){
                              launchEmail("info@egypt.basketball");
                            },
                            label: Text("info@egypt.basketball",style: GoogleFonts.cairo(color: Colors.grey,fontSize: 20),),
                            icon: Image.asset("images/email_contact_us.png"),
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
    );
  }
}
