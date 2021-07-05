import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_judge_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_match_id_entiies.dart';
import 'package:hi_market/basket_ball/domain/entities/match_details_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/entities/uncompleted_match_entities.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_report_match_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';
import 'notification_page.dart';

class RefereePersonalFilePage extends StatefulWidget {
  RefereePersonalFilePage({Key key, this.image}) : super(key: key);
  File image;

  @override
  _RefereePersonalFilePageState createState() {
    return _RefereePersonalFilePageState();
  }
}

class _RefereePersonalFilePageState extends State<RefereePersonalFilePage> {
  GetJudgeMatchesEntities getJudgeMatchesEntities = GetJudgeMatchesEntities(
      data: GetJudgeMatchesData(matches: List(), notifications: List()));
  List<Matches> beforeMatches = List<Matches>();
  List<Matches> afterMatches = List<Matches>();
  List<Matches> currentMatches = List<Matches>();
  UnCompletedMatchEntities unCompletedMatch =
      UnCompletedMatchEntities(data: List());



  getData() async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.show();
    var response = await sl<Cases>().getJudgeMatchesEntities();
    dialog.hide();
    if (response is GetJudgeMatchesEntities) {
      setState(() {
        currentMatches = List();
        getJudgeMatchesEntities = response;
        getJudgeMatchesEntities.data.matches.forEach((element) {
          if(element.matchDate != ""&&element.matchTime != ""&&element.match.results.length != 0 ){
            print("matchDate: ${refactorDate(element.matchDate)}");
            print(DateTime.now());
            if (refactorDate(element.matchDate)
                .isBefore(DateTime.now().subtract(Duration(days: 1)))) {
              setState(() {
                beforeMatches.add(element);
              });
            } else {
              setState(() {
                afterMatches.add(element);
                if (refactorDate(element.matchDate)
                    .isBefore(DateTime.now().add(Duration(days: 1)))) {
                  print("here");
                  setState(() {
                    if(element.status == "Accepted"&&!(sl<Cases>().getMatchIdSharedPreference().data.contains(element.match.id.toString())))
                      currentMatches.add(element);
                  });
                }
              });
            }

          }
        });
      });
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
    var responseUnCompletedMatches =
        await sl<Cases>().unCompletedMatchEntities();
    print("response uncompletedMatches: $responseUnCompletedMatches");
    if (responseUnCompletedMatches is UnCompletedMatchEntities) {
      setState(() {
        unCompletedMatch = responseUnCompletedMatches;
        print(unCompletedMatch.toJson());
      });
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
      print("unCompleteMatchError");
    }
  }



  @override
  void initState() {
    super.initState();
    getData();
    if(sl<Cases>().getMatchReportIDSharedPreference() == null){
      sl<Cases>().setMatchReportIDSharedPreference(GetMatchIdEntities(data: List()));
    }
    if(sl<Cases>().getMatchIdSharedPreference() == null){
      sl<Cases>().setMatchIdSharedPreference(GetMatchIdEntities(data: List()));
    }
    currentMatches.forEach((element) {
      print("eeeee");
      print(sl<Cases>().getMatchReportIDSharedPreference().data.contains(element.match.id));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      alignment: Alignment.topCenter,
      child: LiquidPullToRefresh(
        onRefresh: ()async{
          getData();
        },
        backgroundColor: Colors.white,
        color: staticColor,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "الإسم",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${sl<Cases>().getLoginData()?.data?.userName??""}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "رقم الهاتف",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${sl<Cases>().getLoginData()?.data?.userPhone??""}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "البريد الالكتروني",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${sl<Cases>().getLoginData()?.data?.userEmail??""}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "رقم البطاقة",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${sl<Cases>().getLoginData()?.data?.nationalId??""}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "المباريات القادمة",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                currentMatches.length == 0
                    ? Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "لا يوجد مباريات قادمة ",
                          style: GoogleFonts.cairo(
                              color: Colors.black, fontSize: 15),
                        ),
                      )
                    : Container(),
                ...currentMatches
                    .map((e) {
                      print("eeeee");
                      sl<Cases>().getMatchIdSharedPreference().data.forEach((element) {
                        print(element.toString());
                        print(e.match.id.toString());
                        print(e.match.id.toString() == element);
                      });
                      print("dddddd");
                      print(e.status != "Accepted");
                      print(e.status);
                      print(!(sl<Cases>().getMatchIdSharedPreference().data.contains(e.match.id.toString())));
                      return e.status == "Accepted"&&!(sl<Cases>().getMatchIdSharedPreference().data.contains(e.match.id.toString()))?Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
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
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height:
                                              MediaQuery.of(context).size.width /
                                                  4,
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  3,
                                          child: Image.network(
                                      e
                                          .match
                                          .results
                                          .first
                                          .logo)
                                          ,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${e.match.results.first.title}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${e.matchDate}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    25),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${e.matchTime}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            25),
                                              ),
                                              //    Text(" PM",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize:  MediaQuery.of(context).size.width / 45),),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${e.matchLeague}",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    40),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        //todo need to show only on specific time
                                        Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "تقام الأن",
                                                style: GoogleFonts.cairo(
                                                    color: Color(0xFF31CF47),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20),
                                              ),
                                              //    Text(" PM",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize:  MediaQuery.of(context).size.width / 45),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height:
                                              MediaQuery.of(context).size.width /
                                                  4,
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  3,
                                          child:  Image.network(
                                      e
                                          .match
                                          .results
                                          .last
                                          .logo)
                                          ,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${e.match.results.last.title}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  int hour = 00;
                                  int min = 00;
                                  if(e.matchTime != ""){
                                    hour = int.parse(e.matchTime.split(":").first);
                                    min = int.parse(e.matchTime.split(":").last);
                                  }
                                  print(refactorDate(e.matchDate).add(Duration(hours: hour,minutes: min)).isBefore(DateTime.now().subtract(Duration(minutes: 5))));
                                  print(refactorDate(e.matchDate).add(Duration(hours: hour,minutes: min)).subtract(Duration(minutes: 5)));
                                  print(DateTime.now());
                                  if(refactorDate(e.matchDate).add(Duration(hours: hour,minutes: min)).subtract(Duration(minutes: 5)).isBefore(DateTime.now())){
                                      ProgressDialog dialog =
                                          ProgressDialog(context);
                                      dialog.show();
                                      var response = await sl<Cases>()
                                          .getMatchEntities(e.match.id);
                                      if (dialog.isShowing()) {
                                        dialog.hide();
                                      }
                                      if (response is GetMatchDetailsEntities) {
                                        Move.to(
                                            context: context,
                                            page: RefreeRoportMatchPage(
                                              image: widget.image,
                                              getMatchDetailsEntities: response,
                                              matchID: e.match.id,
                                            ));
                                      } else if (response
                                          is ResponseModelFailure) {
                                        showToast(context, response.message);
                                      } else {
                                        showToast(context, "Error Connection");
                                      }
                                    }else{
                                    showToast(context, "لم يحن وقت المباراة بعد");
                                  }
                                  },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "اضغط",
                                        style: GoogleFonts.cairo(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(
                                          text: "  للدخول الى ملف المباراه",
                                          style: GoogleFonts.cairo(
                                              color: Color(0xff6E6E6E),
                                              fontSize: 15))
                                    ]),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              InkWell(
                                onTap: () async {
                                  ProgressDialog dialog =
                                  ProgressDialog(context);
                                  dialog.show();
                                  var response = await sl<Cases>()
                                      .getMatchEntities(e.match.id);
                                  if (dialog.isShowing()) {
                                    dialog.hide();
                                  }
                                  if (response is GetMatchDetailsEntities) {
                                    print("matchID ${response.data.match.id}      ${e.match.id}");
                                    bool result = await displayTextInputDialog(context,response);
                                    if (result == true) {
                                      GetMatchIdEntities  getMatchIDs = sl<Cases>().getMatchIdSharedPreference();
                                      getMatchIDs.data.add(e.match.id);
                                      sl<Cases>().setMatchIdSharedPreference(getMatchIDs);
                                      Get.off(RefereeMainPage(), transition: Transition.fadeIn);
                                    }
                                  } else if (response
                                  is ResponseModelFailure) {
                                    showToast(context, response.message);
                                  } else {
                                    showToast(context, "Error Connection");
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                      border: Border.all(color: Color(0xff31CF4733))),
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    "إلغاء المباراه",
                                    style: GoogleFonts.cairo(
                                        color: Colors.white, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ):Container();
                    })
                    .toList(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    "المباريات الغير مكتملة",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                unCompletedMatch.data.length == 0
                    ? Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "لا يوجد مباريات غير مكتملة ",
                          style: GoogleFonts.cairo(
                              color: Colors.black, fontSize: 15),
                        ),
                      )
                    : Container(),
                ...unCompletedMatch.data
                    .map((e) => e.matchStatus == "ENDED"?Container():Container(
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
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "${e.matchTitle}",
                                style: GoogleFonts.cairo(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "${e.matchStatus}",
                                style: GoogleFonts.cairo(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  ProgressDialog dialog = ProgressDialog(context);
                                  bool isShow = await dialog.show();
                                  var response = await sl<Cases>()
                                      .getMatchEntities(e.matchId);
                                  if(isShow) {
                                    dialog.hide();
                                  }
                                  if (response is GetMatchDetailsEntities) {
                                    Move.to(
                                        context: context,
                                        page: RefreeRoportMatchPage(
                                          image: widget.image,
                                          getMatchDetailsEntities: response,
                                          matchID: e.matchId,
                                          now: e.matchStatus,
                                        ));
                                  } else if (response is ResponseModelFailure) {
                                    showToast(context, response.message);
                                  } else {
                                    showToast(context, "Error Connection");
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: "اضغط",
                                        style: GoogleFonts.cairo(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      TextSpan(
                                          text: "  للدخول الى ملف المباراه",
                                          style: GoogleFonts.cairo(
                                              color: Color(0xff6E6E6E),
                                              fontSize: 15))
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController _textFieldController = TextEditingController();

  String codeDialog;
  String valueText;
  Future<bool> displayTextInputDialog(BuildContext context,GetMatchDetailsEntities getMatchDetailsEntities) async {
    return showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(
              'سبب إالغاء المباراه',
              textAlign: TextAlign.center,
            ),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(dialogContext);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () async {
                  if (getMatchDetailsEntities.data.isMainReferee ==
                      true) {
                    if (valueText.isNotEmpty) {
                      ProgressDialog dialog = ProgressDialog(context);
                      dialog.show();
                      var response = await sl<Cases>()
                          .cancelMatch(getMatchDetailsEntities.data.match.id, valueText);
                      dialog.hide();
                      if (response is bool) {
                        dialog.hide();
                        Get.back(result: true);
                      } else if (response is ResponseModelFailure) {
                        showToast(context, response.message);
                      } else {
                        showToast(context, "Connection Error");
                      }
                    } else {
                      showToast(context, "يجب كتابة السبب أولا");
                    }
                  } else {
                    showToast(context, "غير مصرح لك إلغاء المباراة");
                  }
                },
              ),
            ],
          );
        });
  }
}
