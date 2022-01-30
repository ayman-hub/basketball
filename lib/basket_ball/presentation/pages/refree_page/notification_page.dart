
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_judge_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/notificationxx.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key,this.notificationEntities}) : super(key: key);
  NotificationEntities notificationEntities;
  @override
  _NotificationPageState createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {
 NotificationEntities notificationEntities  =  NotificationEntities(data: List());

  bool showProgress = false;
 DateTime refactorNotificationDate(String date) {
   List formateDate = date.contains("/")?date.split("/").toList():date.split("-").toList();
   print("formateData: ${formateDate}");
   DateTime dateTime = DateTime(int.parse(formateDate[0]),int.parse(formateDate[1]),int.parse(formateDate[2]));
   //print("formDate: ${"${formateDate[2]}-${formateDate[1].toString().padLeft(2,"0")}-${formateDate[0].toString().length<(2)?"0${formateDate[0]}":formateDate[0]}"}");
   return dateTime;//"${"${formateDate[2]}-${formateDate[1].toString().padLeft(2,"0")}-${formateDate[0].toString().length<(2)?"0${formateDate[0]}":formateDate[0]}"}";
 }
  getData() async {
    var response = await sl<Cases>().judgeSeeNotification();
    if (response is bool) {

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
     errorDialog(context);
    }
  }


@override
  void initState() {
   String matchID = "";
   notificationEntities = widget.notificationEntities;
   print("notification ddd: ${sl<Cases>().getNotificationIdSharedPreference()}");
 /* widget.notificationEntities.data.reversed.toList().forEach((element) {
    if(element.matchId == matchID && element.type == "2"){
      print("notification add : ${element.notId}  ${element.matchId}  ${element.matchName}");
      notificationEntities.data.last = element;
    }else{
      notificationEntities.data.add(element);
      print("notification edit : ${element.notId}  ${element.matchId}  ${element.matchName}");
   if(element.type == "2"){
     matchID = element.matchId;
   }
    }
  });*/
  print("notification last: ${notificationEntities.data.map((element) =>       "notification data : ${element.notId}  ${element.matchId}  ${element.matchName}")}");
    notificationCount = 0 ;
  // getData();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  WillPopScope(
      onWillPop: () async {
        Move.noBack(context: context, page: RefereeMainPage());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(Res.hiclipart),
            ),
            Container(
              child: ListView(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Image.asset(
                            Res.backimage,
                            color: Color(0xffE31E24),
                          ),
                          onPressed: () => Move.noBack(context: context, page: RefereeMainPage()))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...notificationEntities.data.map((e) {
                    print(refactorNotificationDate(e.date));
                    print(DateTime.now().subtract(Duration(days: 1)));
                    print("is Before ${ refactorNotificationDate(e.date).isBefore(DateTime.now().subtract(Duration(days: 1)))}");
                    return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(Res.basketiconlistimage),
                                ),
                                //Text("EBBFED .8 min")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                    flex: 4,
                                    child: Text(
                                     "${e.msg}" /*e.type == "2"?"نود إخباركم أنه تم تغيير موعد المباراه في ملعب ${e.matchPlace} ${e.matchName} يوم الموافق ${e.matchDate} في تمام الساعه ${e.matchTime}":"${e.msg}"*/,
                                      textDirection: TextDirection.rtl,
                                      maxLines: 3,
                                    )),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                    child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(Res.basketiconlistimage),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            refactorNotificationDate(e.date).isBefore(DateTime.now().subtract(Duration(days: 1)))/*||e.type == "2" || sl<Cases>().getNotificationIdSharedPreference().contains(e.notId)*/?Container(): Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        showProgress = true;
                                      });
                                      var response = await sl<Cases>()
                                          .judgeNotificationAction(
                                              not_id: e.notId, res: false);
                                      setState(() {
                                        showProgress = false;
                                      });
                                      if (response is bool) {
                                        setState(() {
                                          notificationEntities.data.remove(e);
                                        });
                                        var platform = Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                                messageText: Text(
                                                  "تم ارسال الرد",
                                                  textAlign: TextAlign.center,
                                                ))
                                            : showToast(context, "تم ارسال الرد");
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
                                        errorDialog(context);
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 3,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "رفض",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )),
                                TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        showProgress = true;
                                      });
                                      var response = await sl<Cases>()
                                          .judgeNotificationAction(
                                              not_id: e.notId, res: true);
                                      setState(() {
                                        showProgress = false;
                                      });
                                      if (response is bool) {
                                        setState(() {
                                          notificationEntities.data.remove(e);
                                          List data = sl<Cases>().getNotificationIdSharedPreference()??List<String>.empty(growable: true);
                                          data.add(e.notId);
                                          sl<Cases>().setNotificationIdSharedPreference(data);
                                        });
                                        var platform = Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                                messageText: Text(
                                                  "تم ارسال الرد",
                                                  textAlign: TextAlign.center,
                                                ))
                                            : showToast(context, "تم ارسال الرد");
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
                                        errorDialog(context);
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width / 3,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "قبول",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      );
                  })
                ],
              ),
            ),
            showProgress ?getLoadingContainer(context) :Container()
          ],
        ),
        bottomNavigationBar: getNavigationBar(context),
      ),
    );
  }
}
