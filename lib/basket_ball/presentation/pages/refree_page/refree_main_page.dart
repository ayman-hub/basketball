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
import 'package:hi_market/basket_ball/presentation/pages/refree_page/edit_profile_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/notification_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/referee_next_matches_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/referee_perivios_matches_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/referee_personal_file_page.dart';
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

class RefereeMainPage extends StatefulWidget {
  RefereeMainPage({Key key,this.image}) : super(key: key);
File image;
  @override
  _RefereeMainPageState createState() {
    return _RefereeMainPageState();
  }
}

class _RefereeMainPageState extends State<RefereeMainPage> {
  int selected = 2;


  String nationalID;
  String bankName;
  String accountNo;
  String iban;
  String swiftCode;

  String phone;

  final formKey = GlobalKey<FormState>();

  bool showNotification = false;

  NotificationEntities notifications;

  getNotificationData() async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.show();
    var response = await sl<Cases>().getNotification();
    dialog.hide();
    if (response is NotificationEntities) {
      dialog.hide();
      Move.to(context: context, page: NotificationPage(notificationEntities: response,));
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
            'Connection Error',
            textAlign: TextAlign.center,
          ))
          : showToast(context, 'Connection Error');
    }
    dialog.hide();
  }

/*  pushNotification()async{
    var response = await sl<Cases>().pushNotification();
    print("Push Notification : $response");
    if(response is bool){
      sl<Cases>().setNotificationFirebase(null);
    }
  }*/

  @override
  void initState() {
    super.initState();
    countData = StreamController<int>.broadcast();
    notifications  = NotificationEntities(data: List());
    notifications.data.add(NotificationData(id: ""));
   // if(sl<Cases>().getPutNotificaton()!= null&&sl<Cases>().getPutNotificaton()!= false){
     // pushNotification();
   // }
  /*  if(sl<Cases>().getNotificationIdSharedPreference()== null){
      sl<Cases>().setNotificationIdSharedPreference(GetNotificationIdEntities(data: List()));
    }*/
  /*  Future.delayed(Duration(milliseconds: 50),(){
      getNotification(null);
    });*/
  }

  @override
  void dispose() {
    super.dispose();
    countData.close();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              child:Column(
                children: [
                  Container(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                     height: MediaQuery.of(context).size.height / 3.6,
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
                                       return Move.to(
                                           context: context, page:MyHomePage());
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
                                 /*       NotificationEntities
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
                                                  onPressed: () => getNotificationData(),
                                                ),
                                              )
                                            : Container(
                                                // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
                                                child: IconButton(
                                                    icon: Image.asset(Res.bell),
                                                    onPressed: () =>getNotificationData()));
                                      }
                                      return Container(
                                          // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 10),
                                          child: IconButton(
                                              icon: Image.asset(Res.bell),
                                              onPressed: () => getNotificationData()));
                                    }),
                                IconButton(
                                  icon:Image.asset(Res.recycle),
                                  onPressed: () {
                                  Get.to(()=>EditProfilePage(image: widget.image,),transition: Transition.fadeIn);
                                  },
                                ),
                               IconButton(
                                  icon:Image.asset("images/money.png"),
                                  onPressed: ()async {
                                    ProgressDialog dialog = ProgressDialog(context);
                               bool isShowDialog = await  dialog.show();
                              var response = await sl<Cases>().refereeReport();
                              if(isShowDialog){
                                dialog.hide();
                              }
                              if(response is RefereeReportEntities){
                                Move.to(context: context, page: ReportRefereePage(image: widget.image, refereeReportEntities: response,));
                              }else if (response is ResponseModelFailure){
                                showToast(context, response.message);
                              }else{
                                showToast(context, "Connection Error");
                              }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                 Container(
                    height: 50,
                          decoration: BoxDecoration(
                           // border: Border.all(color: Colors.black),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selected = 0;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: selected == 0 ? BorderRadius.circular(10):BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      color: selected == 0
                                          ? Colors.white
                                          : Color(0xffE31E24),
                                    ),
                                    alignment: Alignment.center,
                                   /* padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width /
                                            20,
                                        bottom:
                                            MediaQuery.of(context).size.width /
                                                20),*/
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        selected == 0
                                            ? Image.asset(
                                                Res.whistle,
                                                scale: 25,
                                              )
                                            : Container(),
                                        Text(
                                          "المباريات القادمه",
                                          style: GoogleFonts.cairo(
                                              color:selected == 0 ?  Colors.black:Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  35,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selected = 1;
                                    });
                                  },
                                  child: Container(
                                   decoration: BoxDecoration(
                                       color: selected == 1
                                           ? Colors.white
                                           : Color(0xffE31E24),
                                     borderRadius: selected == 1 ? BorderRadius.circular(10):BorderRadius.circular(0)
                                   ),
                                    alignment: Alignment.center,
                                 /*   padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width /
                                            20,
                                        bottom:
                                            MediaQuery.of(context).size.width /
                                                20),*/
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        selected == 1
                                            ? Image.asset(
                                                Res.whistle,
                                                scale: 25,
                                              )
                                            : Container(),
                                        Text(
                                          "المباريات السابقة",
                                          style:  GoogleFonts.cairo(
                                              color:selected == 1 ?  Colors.black:Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  35,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selected = 2;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:selected == 2 ? BorderRadius.circular(10): BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: selected == 2
                                          ? Colors.white
                                          : Color(0xffE31E24),
                                    ),
                                    alignment: Alignment.center,
                                  /*  padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.width /
                                            20,
                                        bottom:
                                            MediaQuery.of(context).size.width /
                                                20),*/
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        selected == 2
                                            ? Image.asset(
                                                Res.whistle,
                                                scale: 25,
                                              )
                                            : Container(),
                                        Text(
                                          "الملف الشخصي",
                                          style:  GoogleFonts.cairo(
                                              color:selected == 2 ? Colors.black:Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  35,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
               Expanded(
                 flex: 4,
                 child: Container(
                   child: selected == 0
                       ? RefereeNextMatchesPage()
                       : (selected == 1
                       ? RefereePreviosMatchesPage()
                       : RefereePersonalFilePage(image: widget.image,)),
                 ),
               )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: getNavigationBar(context),
    );
  }

 // File _image;

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



 /* void getNotification(NotificationEntities notificationEntities)async{
    if(notificationEntities == null){
      print("notficiationnnnnnnnnnnnnn");
      var response = await sl<Cases>().getNotification();
      if (response is NotificationEntities) {
        if (sl<Cases>().getNotificationIdSharedPreference() == null) {
          sl<Cases>().setNotificationIdSharedPreference(
              NotificationEntities(data: List()));
        }
        setState(() {
          notifications = response;
          notifications.data.forEach((element) {
            print("getNotificationsEntities${element.notId}");
          });
          if (notifications.data.length > 0) {
            bool show = true;
            sl<Cases>().getNotificationIdSharedPreference().data.forEach((e) {
              print("SharedPreference: ${e.notId}");
            });
            notifications.data.forEach((element) {
              sl<Cases>().getNotificationIdSharedPreference().data.forEach((e) {
                if (element.notId == e.notId) {
                  show = false;
                  print("getNotitifcationFalse");
                }
              });
            });
            if (show) {
          *//*    Get.snackbar("", "",borderColor: Colors.white,titleText: Container(
                width: 100,
                child: Row(
                  children: [
                    Image.asset("images/sideMenuLogo.png"),
                    Text("new notification")
                  ],
                ),
              ));*//*
              showNotification = true;
              NotificationEntities data =
                  sl<Cases>().getNotificationIdSharedPreference();
              data.data.add(notifications.data.last);
              sl<Cases>().setNotificationIdSharedPreference(data);
            }
          }
        });
      }
    }else{
     // setState(() {
        notifications = notificationEntities;
        if(notifications.data.length>0){
          bool show = true;
          notifications.data.forEach((element) {
            sl<Cases>().getNotificationIdSharedPreference().data.forEach((e) {
              if (element.notId == e.notId) {
                show = false;
                print("getNotitifcationFalse");
              }
            });
          });
          if(show){
            showNotification = true;
            NotificationEntities data = sl<Cases>().getNotificationIdSharedPreference();
            data.data.add(notifications.data.last);
            sl<Cases>().setNotificationIdSharedPreference(data);
          }
        }
     // });
    }
  }*/

}
