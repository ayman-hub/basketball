import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_judge_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/referee_report_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/notification_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/referee_next_matches_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/referee_perivios_matches_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/referee_personal_file_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/report_referee_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/notificationxx.dart';
import 'package:hi_market/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';
import '../main_page.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key,this.image}) : super(key: key);
  File image;
  @override
  _EditProfilePageState createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                Res.hiclipart,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  Container(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    height: 180,
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                              height: MediaQuery.of(context).size.height /3.5,
                              //alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  SizedBox(height: 40,),
                                  IconButton(
                                      icon: Image.asset(
                                        Res.backimage,
                                        color: Color(0xffE31E24),
                                      ),
                                      onPressed: () {
                                          return Move.noBack(
                                              context: context, page:RefereeMainPage(image: widget.image,));
                                      }),
                                ],
                              )),
                        ),
                        Flexible(
                          child: Container(
                            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: InkWell(
                              onTap: getImage,
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child:sl<Cases>().getLoginData().data?.profilePic != null && sl<Cases>().getLoginData().data.profilePic != ""&& widget.image == null ?CircleAvatar(
                                  backgroundImage: Image.network(
                                    sl<Cases>().getLoginData().data?.profilePic,
                                    fit: BoxFit.fill,
                                  ).image,
                                ):(widget.image == null ? CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: Icon(
                                    Icons.person_outline,
                                    size: 50,
                                  ),
                                ):CircleAvatar(
                                  backgroundImage: Image.file(
                                    widget.image,
                                    fit: BoxFit.fill,
                                  ).image,
                                )),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 20),
                            height: MediaQuery.of(context).size.height / 3.5,
                            width: 50,
                            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                StreamBuilder(
                                    stream: countData.stream,
                                    builder: (context, snapshot) {
                                      if (snapshot.data
                                      is int) {
                                        /*     NotificationEntities
                                        getJudgeMatchesEntities =
                                            snapshot.data;
                                        if(getJudgeMatchesEntities.data.length > 0){
                                          //  setState(() {
                                          Future.delayed(Duration(milliseconds: 50),(){
                                            getNotification(getJudgeMatchesEntities);
                                          });
                                          //});
                                          // Get.snackbar("",              "نود إخباركم أنه تم أختياركم لأداره ${getJudgeMatchesEntities.data.last.matchName} يوم الموافق ${getJudgeMatchesEntities.data.last.matchDate} في تمام الساعه ${getJudgeMatchesEntities.data.last.matchTime}",);
                                        }*/
                                        return snapshot
                                            .data > 0
                                            ? Badge(
                                          position: BadgePosition(left: 20),
                                          badgeContent: Text(
                                            snapshot
                                                .data
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                          child: IconButton(
                                            icon: Image.asset(Res.bell,),
                                            onPressed: () => getNotificationData(context),
                                          ),
                                        )
                                            : Container(
                                          // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
                                            child: IconButton(
                                                icon: Image.asset(Res.bell),
                                                onPressed: () =>getNotificationData(context)));
                                      }
                                      return Container(
                                        // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 10),
                                          child: IconButton(
                                              icon: Image.asset(Res.bell),
                                              onPressed: () => getNotificationData(context)));
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
               showEditProfileWidget()
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: getNavigationBar(context),
    );
  }

  Future getImage() async {
    PickedFile image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        widget.image = File(image.path);
      });
      var respond =
      await sl<Cases>().updateUserPicture(widget.image);
      if (respond is bool) {
        print("nnnnnnnnnnnnnnn");
      }
      ResponseModelFailure failure = respond;
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
          messageText: Text(
            "تم تغيير الصورة",
            textAlign: TextAlign.center,
          ))
          : showToast(context, "تم تغيير الصورة");
      if (respond is ResponseModelFailure) {
        ResponseModelFailure failure = respond;
        var platform = Theme.of(context).platform;
        platform == TargetPlatform.iOS
            ? Get.snackbar("", "",
            messageText: Text(
              failure.message,
              textAlign: TextAlign.center,
            ))
            : showToast(context,failure.message);
      } else {
        var platform = Theme.of(context).platform;
        platform == TargetPlatform.iOS
            ? Get.snackbar("", "",
            messageText: Text(
              "error connection",
              textAlign: TextAlign.center,
            ))
            : showToast(context,"error connection");
      }
    }
    /*  if(_image == null){
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
          messageText: Text(
            "image not found",
            textAlign: TextAlign.center,
          ))
          : showToast(context,"image not found");
    }*/
  }
  final formKey = GlobalKey<FormState>();
  String nationalID;
  String bankName;
  String accountNo;
  String iban;
  String swiftCode;

  String phone;
  Widget showEditProfileWidget() {
    return Form(
      key: formKey,
      child: Container(
        height: MediaQuery.of(context).size.height /1.7,
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: Text(
                "رقم الهاتف",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: EdgeInsets.only(right: 25,top: 10,left: 25,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType:
                  TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                  validator: (value) {
                    if (value.length != 11 ) {
                      return "أدخل رقم هاتف صحيح";
                    }
                    if (value.isEmpty) {
                      return 'املأ البيانات';
                    }
                    return null;
                  },
                  style: TextStyle(fontSize: 15.0),
                  decoration: InputDecoration(
                      hintText: "الهاتف",
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: Text(
                "رقم البطاقة",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: EdgeInsets.only(right: 25,top: 10,left: 25,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType:
                  TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    setState(() {
                      nationalID = value;
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
                      hintText: "رقم البطاقة",
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: Text(
                "اسم البنك",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: EdgeInsets.only(right: 25,top: 10,left: 25,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType:
                  TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    setState(() {
                      bankName = value;
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
                      hintText: "اسم البنك",
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: Text(
                "رقم الحساب",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: EdgeInsets.only(right: 25,top: 10,left: 25,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType:
                  TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    setState(() {
                      accountNo = value;
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
                      hintText: "رقم الحساب",
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: Text(
                "الخدمات المصرفية",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: EdgeInsets.only(right: 25,top: 10,left: 25,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType:
                  TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    setState(() {
                      iban = value;
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
                      hintText: "الخدمات المصرفية",
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(right: 20),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerRight,
              child: Text(
                "سويفت كود البنك",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: EdgeInsets.only(right: 25,top: 10,left: 25,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextFormField(
                  maxLines: 1,
                  keyboardType:
                  TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    setState(() {
                      swiftCode = value;
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
                      hintText: "سويفت كود البنك",
                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: FlatButton(
                  onPressed: () async {
                    if(formKey.currentState.validate()){
                      var response = await sl<Cases>()
                          .updateUserProfile(
                          phone, nationalID,bankName,accountNo,iban,swiftCode);
                      if (response is bool) {
                        LoginDataEntities loginData =
                        sl<Cases>().getLoginData();
                        loginData.data.userPhone = phone;
                        loginData.data.nationalId =
                            nationalID;
                        sl<Cases>().setLoginData(loginData);
                        var platform =
                            Theme.of(context).platform;
                        platform == TargetPlatform.iOS
                            ? Get.snackbar("", "",
                            messageText: Text(
                              "تم حفظ البيانات",
                              textAlign: TextAlign.center,
                            ))
                            : showToast(
                            context, "تم حفظ البيانات");
                        Get.off(()=>RefereeMainPage(image: widget.image,),transition: Transition.fadeIn);
                      } else if (response
                      is ResponseModelFailure) {
                        var platform =
                            Theme.of(context).platform;
                        platform == TargetPlatform.iOS
                            ? Get.snackbar("", "",
                            messageText: Text(
                              response.message,
                              textAlign: TextAlign.center,
                            ))
                            : showToast(
                            context, response.message);
                      } else {
                        var platform =
                            Theme.of(context).platform;
                        platform == TargetPlatform.iOS
                            ? Get.snackbar("", "",
                            messageText: Text(
                              "Connection Error",
                              textAlign: TextAlign.center,
                            ))
                            : showToast(
                            context, "Connection Error");
                      }
                    }
                  },
                  child: Container(
                    width:
                    MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffE31E24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0,
                              2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "حفظ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}