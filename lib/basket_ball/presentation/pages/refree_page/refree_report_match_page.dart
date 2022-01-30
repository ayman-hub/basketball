import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_judge_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_match_id_entiies.dart';
import 'package:hi_market/basket_ball/domain/entities/get_team_players_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/match_details_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/referee_report_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/report_referee_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/notificationxx.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';
import '../main_page.dart';
import 'notification_page.dart';

class RefreeRoportMatchPage extends StatefulWidget {
  RefreeRoportMatchPage(
      {Key key,
      this.image,
      @required this.getMatchDetailsEntities,
      @required this.matchID,
      this.now})
      : super(key: key);
  String now;
  File image;
  GetMatchDetailsEntities getMatchDetailsEntities;
  String matchID;

  @override
  _GetBottomSheetWidgetState createState() {
    return _GetBottomSheetWidgetState();
  }
}

class _GetBottomSheetWidgetState extends State<RefreeRoportMatchPage> {
  matchType match = matchType.start;
  bool showEditProfile = false;
  String firstTeam = "";

  String secondTeam = "";

  bool showEdites = false;
  bool showProgress = false;

  GetTeamPlayersEntities getTeamPlayersEntities;

  String nationalID;
  String bankName;
  String accountNo;
  String iban;
  String swiftCode;

  ScrollController scrollController = ScrollController();

  String notes;

  String report;

  String phone;

  final formKey = GlobalKey<FormState>();

  TextEditingController firstTeamController = TextEditingController();
  TextEditingController secondTeamController = TextEditingController();

  int selected;

  getNotificationData() async {
    setState(() {
      showProgress = true;
    });
    var response = await sl<Cases>().getNotification();
    setState(() {
      showProgress = false;
    });
    if (response is NotificationEntities) {
      Move.to(
          context: context,
          page: NotificationPage(
            notificationEntities: response,
          ));
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
    super.initState();
    countData = StreamController<int>.broadcast();
    print("nowwwww: ${widget.now}");
    if (widget.now == "STARTED") {
      match = matchType.end;
    } else if (widget.now == "ENDED") {
      match = matchType.result;
    } else if (widget.now == "RESULTS") {
      match = matchType.note;
    } else if (widget.now == "REPORT") {
      match = matchType.report;
    } else if (widget.now == "NOTES") {
      match = matchType.report;
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstTeamController.dispose();
    secondTeamController.dispose();
    countData.close();
  }

  List<String> week = [
    "",
    "الإثنين",
    "الثلاثاء",
    "الأربعاء",
    "الخميس",
    "الجمعة",
    "السبت",
    "الأحد",
  ];

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
              Res.hiclipart,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  height: MediaQuery.of(context).size.height / 3.5,
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            height: MediaQuery.of(context).size.height / 3.5,
                            //alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                IconButton(
                                    icon: Image.asset(
                                      Res.backimage,
                                      color: Color(0xffE31E24),
                                    ),
                                    onPressed: () {
                                      if (showEditProfile) {
                                        setState(() {
                                          showEditProfile = false;
                                        });
                                      } else {
                                        return Move.noBack(
                                            context: context,
                                            page: RefereeMainPage());
                                      }
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
                              child:
                                  sl<Cases>().getLoginData().data?.profilePic !=
                                              null &&
                                          sl<Cases>()
                                                  .getLoginData()
                                                  .data
                                                  .profilePic !=
                                              "" &&
                                          widget.image == null
                                      ? CircleAvatar(
                                          backgroundImage: Image.network(
                                            sl<Cases>()
                                                .getLoginData()
                                                .data
                                                ?.profilePic,
                                            fit: BoxFit.fill,
                                          ).image,
                                        )
                                      : (widget.image == null
                                          ? CircleAvatar(
                                              backgroundColor: Colors.grey[200],
                                              child: Icon(
                                                Icons.person_outline,
                                                size: 50,
                                              ),
                                            )
                                          : CircleAvatar(
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
                                    if (snapshot.data is int) {
                                      return snapshot.data > 0
                                          ? Badge(
                                              position:
                                                  BadgePosition(start: 20),
                                              badgeContent: Text(
                                                snapshot.data.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                              child: IconButton(
                                                icon: Image.asset(
                                                  Res.bell,
                                                ),
                                                onPressed: () =>
                                                    getNotificationData(),
                                              ),
                                            )
                                          : Container(
                                              // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
                                              child: IconButton(
                                                  icon: Image.asset(Res.bell),
                                                  onPressed: () =>
                                                      getNotificationData()));
                                    }
                                    return Container(
                                        // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 10),
                                        child: IconButton(
                                            icon: Image.asset(Res.bell),
                                            onPressed: () =>
                                                getNotificationData()));
                                  }),
                              /*  showEditProfile
                                  ? Container()
                                  : IconButton(
                                      icon: Image.asset(Res.recycle),
                                      onPressed: () {
                                        setState(() {
                                          showEditProfile = true;
                                        });
                                      },
                                    ),*/
                              showEditProfile
                                  ? Container()
                                  : IconButton(
                                      icon: Image.asset("images/money.png"),
                                      onPressed: () async {
                                        setState(() {
                                          showProgress = true;
                                        });
                                        var response =
                                            await sl<Cases>().refereeReport();
                                        setState(() {
                                          showProgress = false;
                                        });
                                        if (response is RefereeReportEntities) {
                                          Move.to(
                                              context: context,
                                              page: ReportRefereePage(
                                                image: widget.image,
                                                refereeReportEntities: response,
                                              ));
                                        } else if (response
                                            is ResponseModelFailure) {
                                          showToast(context, response.message);
                                        } else {
                                          errorDialog(context);
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
              ),
              Expanded(
                flex: /*showEditProfile ? 2 :*/ 5,
                child:
                    /* showEditProfile
                    ? showEditProfileWidget()
                    :*/
                    Container(
                  color: Colors.white,
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Container(
                        //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                child: Column(
                                  /* mainAxisAlignment:
                                  MainAxisAlignment.center,*/
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width / 6,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Image.network(widget
                                          .getMatchDetailsEntities
                                          .data
                                          .match
                                          .results
                                          .first
                                          .logo) /*Image.network(
                                          afterMatches[index]
                                              .match
                                              .results
                                              .first
                                              .logo)*/
                                      ,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${widget.getMatchDetailsEntities.data.match.results.first.title}",
                                        textAlign: TextAlign.center,
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
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                    alignment: Alignment.center,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              "تقام الان مباراه في ${widget.getMatchDetailsEntities.data.matchLeague} بين فريقين  ${widget.getMatchDetailsEntities.data.match.results.first.title} و${widget.getMatchDetailsEntities.data.match.results.last.title}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  40),
                                        ),
                                        TextSpan(
                                          text: "   تحت قيادة الحكم  ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  40),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  Container(
                                    //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                    alignment: Alignment.center,
                                    child: Wrap(
                                      children: [
                                        ...widget.getMatchDetailsEntities.data.referees.map((e) =>   Text(
                                          "    ${e.username}    ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  40),
                                          textAlign: TextAlign.center,
                                        ),).toList()
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${widget.getMatchDetailsEntities.data.matchDate}",
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Image.asset("images/Rectangle.png"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${week[refactorDate(widget.getMatchDetailsEntities.data.matchDate).weekday]}",
                                          style: GoogleFonts.cairo(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                  //todo need to show only on specific time
                                  Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${widget.getMatchDetailsEntities.data.matchLeague}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.cairo(
                                                color: Colors.grey,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    45),
                                          ),
                                        ),
                                        Text(
                                          "تقام الأن",
                                          style: GoogleFonts.cairo(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: MediaQuery.of(context)
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
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                child: Column(
                                  /*   mainAxisAlignment:
                                  MainAxisAlignment.center,*/
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width / 6,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      child: Image.network(widget
                                          .getMatchDetailsEntities
                                          .data
                                          .match
                                          .results
                                          .last
                                          .logo) /* Image.network(
                                          afterMatches[index]
                                              .match
                                              .results
                                              .last
                                              .logo)*/
                                      ,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${widget.getMatchDetailsEntities.data.match.results.last.title}",
                                        textAlign: TextAlign.center,
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
                            ),
                          ],
                        ),
                      ),
                      match == matchType.start
                          ? startMatchWidget()
                          : match == matchType.end
                              ? endMatch()
                              : match == matchType.result
                                  ? resultMatch()
                                  : match == matchType.report
                                      ? reportMatchWidget()
                                      : noteMatchWidget()
                    ],
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

  startMatchWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            bool result = await displayTextInputDialog(context);
            if (result == true) {
              GetMatchIdEntities getMatchIdEntities =
                  sl<Cases>().getMatchIdSharedPreference();
              if (getMatchIdEntities.data == null) {
                getMatchIdEntities.data = List();
              }
              getMatchIdEntities.data.add(widget.matchID);
              sl<Cases>().setMatchIdSharedPreference(getMatchIdEntities);
              Get.off(RefereeMainPage(), transition: Transition.fadeIn);
            }
            /*    if(widget.getMatchDetailsEntities.data.isMainReferee == true){
                      var response = await sl<Cases>().endMatch(widget.matchID);
                      if (response is bool) {
                        setState(() {
                          match = matchType.result;
                          */ /* scrollController.animateTo(120.0,
                            duration: Duration(milliseconds: 50),
                            curve: Curves.fastOutSlowIn);*/ /*
                        });
                      } else if (response is ResponseModelFailure) {
                        showToast(context, response.message);
                      } else {
                        showToast(context, "Connection Error");
                      }
                    }*/
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
        InkWell(
          onTap: () async {
            if (widget.getMatchDetailsEntities.data.isMainReferee == true) {
              setState(() {
                showProgress = true;
              });
              var response = await sl<Cases>().startMatch(widget.matchID);
              setState(() {
                showProgress = false;
              });
              if (response is bool) {
                setState(() {
                  match = matchType.end;
                  GetMatchIdEntities getMatchIdEntities =
                      sl<Cases>().getMatchIdSharedPreference();
                  if (getMatchIdEntities.data == null) {
                    getMatchIdEntities.data = List();
                  }
                  getMatchIdEntities.data.add(widget.matchID);
                  sl<Cases>().setMatchIdSharedPreference(getMatchIdEntities);
                });
              } else if (response is ResponseModelFailure) {
                showToast(context, response.message);
              } else {
               errorDialog(context);
              }
            } else {
              showToast(context, "غير مصرح لك تسجيل تقرير المباراة");
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Color(0xff31CF4733))),
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(8),
            child: Text(
              "إبدأ المباراه",
              style: GoogleFonts.cairo(
                  color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  endMatch() {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff31CF47),
                  border: Border.all(color: Color(0xff31CF4733))),
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.all(7),
              child: Text(
                "بدأت المباراه",
                style: GoogleFonts.cairo(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    bool result = await displayTextInputDialog(context);
                    if (result == true) {
                      Get.off(RefereeMainPage(), transition: Transition.fadeIn);
                    }
                    /*    if(widget.getMatchDetailsEntities.data.isMainReferee == true){
                      var response = await sl<Cases>().endMatch(widget.matchID);
                      if (response is bool) {
                        setState(() {
                          match = matchType.result;
                          */ /* scrollController.animateTo(120.0,
                            duration: Duration(milliseconds: 50),
                            curve: Curves.fastOutSlowIn);*/ /*
                        });
                      } else if (response is ResponseModelFailure) {
                        showToast(context, response.message);
                      } else {
                        showToast(context, "Connection Error");
                      }
                    }*/
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
                InkWell(
                  onTap: () async {
                    if (widget.getMatchDetailsEntities.data.isMainReferee ==
                        true) {
                      setState(() {
                        showProgress = true;
                      });
                      var response = await sl<Cases>().endMatch(widget.matchID);
                      setState(() {
                        showProgress = false;
                      });
                      if (response is bool) {
                        setState(() {
                          match = matchType.result;
                          /* scrollController.animateTo(120.0,
                            duration: Duration(milliseconds: 50),
                            curve: Curves.fastOutSlowIn);*/
                        });
                      } else if (response is ResponseModelFailure) {
                        showToast(context, response.message);
                      } else {
                       errorDialog(context);
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xff31CF4733))),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.all(7),
                    child: Text(
                      "إنهاء المباراه",
                      style: GoogleFonts.cairo(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<ReportPlayerEntities> reportPlayers = List.empty(growable: true);

  resultMatch() {
    return Container(
        height: MediaQuery.of(context).size.height / 2.8,
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              // height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.network(widget.getMatchDetailsEntities.data
                            .match.results.first.logo),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.getMatchDetailsEntities.data.match.results.first.title}",
                        style: GoogleFonts.cairo(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 40,
                        width: 68,
                        child: showEdites
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Color(0xff31CF4733)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${firstTeam}",
                                  style: GoogleFonts.cairo(color: Colors.black),
                                ),
                              )
                            : TextField(
                                maxLines: 1,
                                controller: firstTeamController,
                                keyboardType: TextInputType.numberWithOptions(),
                                onChanged: (value) {
                                  if (value.length < 4) {
                                    setState(() {
                                      firstTeam = value;
                                    });
                                  } else {
                                    setState(() {
                                      showToast(
                                          context, "ادخل ٤ ارقام على الأكثر");
                                      print(value);
                                      print(firstTeam);
                                      FocusScope.of(context).unfocus();
                                      firstTeamController.clear();
                                      print(value);
                                      firstTeamController.text = null;
                                      print(value);
                                      firstTeamController.value =
                                          TextEditingValue(text: "");
                                      print(
                                          "secondTeamController : ${firstTeamController.text}");
                                      secondTeam = "";
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Color(0xff31CF4733))),
                                ),
                              ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "إدخل نتيجه المباراه",
                        style: GoogleFonts.cairo(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "VS",
                        style: GoogleFonts.cairo(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          if (widget
                                  .getMatchDetailsEntities.data.isMainReferee ==
                              true) {
                            if (showEdites) {
                              print("heeree");
                              setState(() {
                                firstTeam = "";
                                secondTeam = "";
                                showEdites = !showEdites;
                              });
                            } else if (firstTeam != '' &&
                                firstTeam != null &&
                                secondTeam != null &&
                                secondTeam != "") {
                              setState(() {
                                showProgress = true;
                              });
                              var response = await sl<Cases>().matchResultEntry(
                                  widget.matchID,
                                  widget.getMatchDetailsEntities.data.match
                                      .results.first.id
                                      .toString(),
                                  widget.getMatchDetailsEntities.data.match
                                      .results.last.id
                                      .toString(),
                                  firstTeam,
                                  secondTeam,
                                  reportPlayers);
                              setState(() {
                                showProgress = false;
                              });
                              if (response is bool) {
                                setState(() {
                                  showEdites = true;
                                  /* scrollController.animateTo(450,
                                  duration: Duration(milliseconds: 50),
                                  curve: Curves.fastOutSlowIn);*/
                                  match = matchType.note;
                                });
                              } else if (response is ResponseModelFailure) {
                                showToast(context, response.message);
                              } else {
                                showMessageAlert(context);
                              }
                            }
                          } else {
                            showToast(
                                context, "غير مصرح لك تسجيل تقرير المباراة");
                          }
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/saveMatch.png"),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "حفظ",
                                style: GoogleFonts.cairo(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.network(widget.getMatchDetailsEntities.data
                            .match.results.last.logo),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.getMatchDetailsEntities.data.match.results.last.title}",
                        style: GoogleFonts.cairo(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 40,
                        width: 68,
                        child: showEdites
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Color(0xff31CF4733)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${secondTeam}",
                                  style: GoogleFonts.cairo(color: Colors.black),
                                ),
                              )
                            : TextField(
                                //maxLines: 1,
                                controller: secondTeamController,
                                keyboardType: TextInputType.numberWithOptions(),
                                onChanged: (value) {
                                  if (value.length < 4) {
                                    setState(() {
                                      print(secondTeam);
                                      secondTeam = value;
                                    });
                                  } else {
                                    setState(() {
                                      showToast(
                                          context, "ادخل ٤ ارقام على الأكثر");
                                      print(value);
                                      print(secondTeam);
                                      FocusScope.of(context).unfocus();
                                      secondTeamController.clear();
                                      print(value);
                                      secondTeamController.text = null;
                                      print(value);
                                      secondTeamController.value =
                                          TextEditingValue(text: "");
                                      print(
                                          "secondTeamController : ${secondTeamController.text}");
                                      secondTeam = "";
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                  hoverColor: Colors.black,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                          color: Color(0xff31CF4733))),
                                ),
                              ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if (getTeamPlayersEntities == null) {
                 setState(() {
                       showProgress = true;
                     });
                  var response =
                      await sl<Cases>().getPlayersTeams(widget.matchID);
                  setState(() {
                    showProgress = false;
                  });
                  // Future.delayed(Duration(milliseconds: 100),(){

                  // });
                  if (response is GetTeamPlayersEntities) {
                    getTeamPlayersEntities = response;
                    getTeamPlayerReport(response);
                  } else if (response is ResponseModelFailure) {
                    showToast(context, response.message);
                  }
                } else {
                  getTeamPlayerReport(getTeamPlayersEntities);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "اضافة تقرير لاعب",
                    style: GoogleFonts.cairo(color: Colors.black),
                  ),
                  Icon(
                    Icons.add_circle,
                    color: Colors.red,
                  )
                ],
              ),
            ),
            ...reportPlayers
                .map((e) => ListTile(
                      title: Text(
                        e.player,
                        style: GoogleFonts.cairo(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Text(
                        e.report,
                        style: GoogleFonts.cairo(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                      ),
                      leading: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              reportPlayers.remove(e);
                            });
                          }),
                    ))
                .toList(),
          ],
        ));
  }

  noteMatchWidget() {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(7),
            child: Text(
              "ملاحظات عن المباراة",
              style: GoogleFonts.cairo(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            /* decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color:Colors.grey)),*/
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                maxLines: 10,
                onChanged: (value) {
                  setState(() {
                    notes = value;
                    print("note: $notes");
                  });
                },
                decoration: InputDecoration(
                    hintText: "أكتب ملاحظاتك عن المباراة :",
                    hintStyle: GoogleFonts.cairo(
                        color: Colors.black, fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              if (widget.getMatchDetailsEntities.data.isMainReferee == true) {
                if (notes != "") {
                  setState(() {
                    showProgress = true;
                  });
                  var response =
                      await sl<Cases>().matchNoteEntry(widget.matchID, notes);
                  setState(() {
                    showProgress = false;
                  });
                  if (response is bool) {
                    showToast(context, "تم ارسال الملاحظة بنجاح");
                    setState(() {
                      match = matchType.report;
                    });
                  } else if (response is ResponseModelFailure) {
                    showToast(context, response.message);
                  } else {
                    errorDialog(context);
                  }
                } else {
                  showMessageAlert(context);
                }
              } else {
                showToast(context, "غير مصرح لك تسجيل تقرير المباراة");
              }
            },
            child: Container(
              width: 102,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: notes != "" ? staticColor : Colors.grey),
              alignment: Alignment.center,
              child: Text(
                "إرسال",
                style: GoogleFonts.cairo(
                    color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  reportMatchWidget() {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(7),
            child: Text(
              "تقرير المباراة",
              style: GoogleFonts.cairo(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: getReportImage,
            child: Container(
              height: 100,
              width: 200,
              decoration: selectedReportImage == null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                      image: DecorationImage(
                          image:
                              Image.file(File(selectedReportImage.path)).image,
                          fit: BoxFit.fill)),
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: selectedReportImage != null
                  ? Container()
                  : Text(
                      "أضف صورة",
                      style: GoogleFonts.cairo(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            /*  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color:Colors.grey)),*/
            margin: EdgeInsets.only(left: 20, right: 20),
            // padding: EdgeInsets.all(7),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                maxLines: 10,
                onChanged: (value) {
                  setState(() {
                    report = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "أكتب تقرير المباراة :",
                    hintStyle: GoogleFonts.cairo(
                        color: Colors.black, fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              if (widget.getMatchDetailsEntities.data.isMainReferee == true) {
                if (report != "" && selectedReportImage != null) {
                 setState(() {
                       showProgress = true;
                     });
                  var responseReport = await sl<Cases>().matchReportEntry(
                      widget.matchID, report, selectedReportImage);
                  setState(() {
                    showProgress = false;
                  });
                  if (responseReport is bool) {
                    showToast(context, "تم ارسال التقرير بنجاح");
                    Move.noBack(context: context, page: RefereeMainPage());
/*                  GetMatchIdEntities  getMatchIdEntities =  sl<Cases>().getMatchReportIDSharedPreference();
                  if(getMatchIdEntities.data == null){
                    getMatchIdEntities.data = List();
                  }
                  getMatchIdEntities.data.add(widget.matchID);
                  sl<Cases>().setMatchReportIDSharedPreference(getMatchIdEntities);*/
                  } else if (responseReport is ResponseModelFailure) {
                    showToast(context, responseReport.message);
                  } else {
                    errorDialog(context);
                  }
                } else {
                  showMessageAlert(context);
                }
              } else {
                showToast(context, "غير مصرح لك تسجيل تقرير المباراة");
              }
            },
            child: Container(
              width: 102,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: report != "" ? staticColor : Colors.grey),
              alignment: Alignment.center,
              child: Text(
                "إرسال",
                style: GoogleFonts.cairo(
                    color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*detailsMatchWidget() {
    return Container(
      //height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff31CF47),
                border: Border.all(color: Color(0xff31CF4733))),
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(7),
            child: Text(
              "بدأت المباراه",
              style: GoogleFonts.cairo(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffE31E24),
                border: Border.all(color: Color(0xffE31E2433))),
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(7),
            child: Text(
              "إنتهت المباراه",
              style: GoogleFonts.cairo(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.network(widget.getMatchDetailsEntities.data
                          .match.results.first.logo),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.getMatchDetailsEntities.data.match.results.first.title}",
                      style: GoogleFonts.cairo(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 40,
                      width: 68,
                      child: showEdites
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xff31CF4733)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "${firstTeam}",
                                style: GoogleFonts.cairo(color: Colors.black),
                              ),
                            )
                          : TextField(
                              maxLines: 1,
                              controller: firstTeamController,
                              keyboardType: TextInputType.numberWithOptions(),
                              onChanged: (value) {
                                if (value.length < 4) {
                                  setState(() {
                                    firstTeam = value;
                                  });
                                } else {
                                  setState(() {
                                    showToast(
                                        context, "ادخل ٤ ارقام على الأكثر");
                                    print(value);
                                    print(firstTeam);
                                    FocusScope.of(context).unfocus();
                                    firstTeamController.clear();
                                    print(value);
                                    firstTeamController.text = null;
                                    print(value);
                                    firstTeamController.value =
                                        TextEditingValue(text: "");
                                    print(
                                        "secondTeamController : ${firstTeamController.text}");
                                    secondTeam = "";
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(color: Color(0xff31CF4733))),
                              ),
                            ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "إدخل نتيجه المباراه",
                      style: GoogleFonts.cairo(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "VS",
                      style: GoogleFonts.cairo(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        if (showEdites) {
                          print("heeree");
                          setState(() {
                            firstTeam = "";
                            secondTeam = "";
                            showEdites = !showEdites;
                          });
                        } else if (firstTeam != '' &&
                            firstTeam != null &&
                            secondTeam != null &&
                            secondTeam != "") {
                          var response = await sl<Cases>().matchResultEntry(
                              widget.matchID,
                              widget.getMatchDetailsEntities.data.match.results
                                  .first.id
                                  .toString(),
                              widget.getMatchDetailsEntities.data.match.results
                                  .last.id
                                  .toString(),
                              firstTeam,
                              secondTeam);
                          if (response is bool) {
                            setState(() {
                              showEdites = true;
                             */ /* scrollController.animateTo(450,
                                  duration: Duration(milliseconds: 50),
                                  curve: Curves.fastOutSlowIn);*/ /*
                              match = matchType.report;
                            });
                          } else if (response is ResponseModelFailure) {
                            showToast(context, response.message);
                          } else {
                            showMessageAlert(context);
                          }
                        }
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("images/saveMatch.png"),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                               "حفظ",
                              style: GoogleFonts.cairo(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.network(widget.getMatchDetailsEntities.data
                          .match.results.last.logo),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.getMatchDetailsEntities.data.match.results.last.title}",
                      style: GoogleFonts.cairo(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 40,
                      width: 68,
                      child: showEdites
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xff31CF4733)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "${secondTeam}",
                                style: GoogleFonts.cairo(color: Colors.black),
                              ),
                            )
                          : TextField(
                              //maxLines: 1,
                              controller: secondTeamController,
                              keyboardType: TextInputType.numberWithOptions(),
                              onChanged: (value) {
                                if (value.length < 4) {
                                  setState(() {
                                    print(secondTeam);
                                    secondTeam = value;
                                  });
                                } else {
                                  setState(() {
                                    showToast(
                                        context, "ادخل ٤ ارقام على الأكثر");
                                    print(value);
                                    print(secondTeam);
                                    FocusScope.of(context).unfocus();
                                    secondTeamController.clear();
                                    print(value);
                                    secondTeamController.text = null;
                                    print(value);
                                    secondTeamController.value =
                                        TextEditingValue(text: "");
                                    print(
                                        "secondTeamController : ${secondTeamController.text}");
                                    secondTeam = "";
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                hoverColor: Colors.black,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        BorderSide(color: Color(0xff31CF4733))),
                              ),
                            ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              setState(() {
                scrollController.animateTo(450,
                    duration: Duration(milliseconds: 50),
                    curve: Curves.fastOutSlowIn);
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.all(7),
              child: Text(
                "ملاحظات عن المباراة",
                style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            */ /* decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color:Colors.grey)),*/ /*
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                maxLines: 10,
                onChanged: (value) {
                  setState(() {
                    notes = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "أكتب ملاحظاتك عن المباراة :",
                    hintStyle: GoogleFonts.cairo(
                        color: Colors.black, fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                scrollController.animateTo(750,
                    duration: Duration(milliseconds: 50),
                    curve: Curves.fastOutSlowIn);
              });
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.all(7),
              child: Text(
                "تقرير المباراة",
                style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            */ /*  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color:Colors.grey)),*/ /*
            margin: EdgeInsets.only(left: 20, right: 20),
            // padding: EdgeInsets.all(7),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                maxLines: 10,
                onChanged: (value) {
                  setState(() {
                    report = value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "أكتب تقرير المباراة :",
                    hintStyle: GoogleFonts.cairo(
                        color: Colors.black, fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              if (notes != "" && firstTeam != '' && secondTeam != ""&&report != "") {
                var response =
                    await sl<Cases>().matchNoteEntry(widget.matchID, notes);
                if (response is bool) {
                  var responseReport = await sl<Cases>()
                      .matchReportEntry(widget.matchID, report);
                  if (responseReport is bool) {
                    Navigator.pop(context);
                  } else if (responseReport is ResponseModelFailure) {
                    showToast(context, responseReport.message);
                  } else {
                    showToast(context, "Connection Error");
                  }
                } else if (response is ResponseModelFailure) {
                  showToast(context, response.message);
                } else {
                  showToast(context, "Connection Error");
                }
              } else {
                showMessageAlert(context);
              }
            },
            child: Container(
              width: 102,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
              alignment: Alignment.center,
              child: Text(
                "إرسال",
                style: GoogleFonts.cairo(
                    color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }*/

  Future getImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        widget.image = File(image.path);
      });
      setState(() {
        showProgress = true;
      });
      var respond = await sl<Cases>().updateUserPicture(widget.image);
      setState(() {
        showProgress = false;
      });
      if (respond is bool) {
        print("nnnnnnnnnnnnnnn");
      }
      ResponseModelFailure failure = respond;
      showToast(context, "تم تغيير الصورة");
      if (respond is ResponseModelFailure) {
        ResponseModelFailure failure = respond;
        showToast(context, failure.message);
      } else {
        errorDialog(context);
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

  File selectedReportImage;

  Future getReportImage() async {
    if (selected != null) {
      PickedFile image = await ImagePicker.platform.pickImage(
          source: selected == 0 ? ImageSource.gallery : ImageSource.camera,imageQuality: 0);
      if (image != null) {
        setState(() {
          selectedReportImage = File(image.path);
        });
        print('image in pytes: ${await selectedReportImage.lengthSync() / 1024} kb');
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
    }else{
   selected =  await   showDialogWidget();
   if(selected != null){
     getReportImage();
     selected = null;
   }
    }
  }

  showDialogWidget() async {
    return await showDialog<int>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 10),
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              content: Container(
                height: 301,
                width: MediaQuery.of(dialogContext).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Image.asset(
                            "images/backimage.png",
                            //scale: 3,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            "",
                            style: GoogleFonts.cairo(
                                color: Color(0xffE31E24),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selected = 0;
                        });
                      },
                      child: Container(
                        height: 148,
                        // margin: EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(dialogContext).size.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selected == 0
                                      ? Color(0xffE31E24)
                                      : Colors.white,
                                  border: Border.all(
                                      color: selected == 0
                                          ? Color(0xffE31E24)
                                          : Colors.black)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /* Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "images/spoon.png",
                                      scale: 2,
                                      color: selected == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),*/
                                  Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          "معرض الصور",
                                          style: GoogleFonts.ptSans(
                                              color: selected == 0
                                                  ? Colors.white
                                                  : Colors.black),),
                                        SizedBox(height:10),
                                            Icon(
                                              Icons.image,
                                              color: selected == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                            )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selected = 1;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selected == 1
                                        ? Color(0xffE31E24)
                                        : Colors.white,
                                    border: Border.all(
                                        color: selected == 1
                                            ? Color(0xffE31E24)
                                            : Colors.black)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /*     Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        "images/big_comic.png",
                                        scale: 3,
                                        color: selected == 1
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),*/
                                    Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "كاميرا",
                                            style: GoogleFonts.ptSans(
                                                color: selected == 1
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          SizedBox(height: 10,),
                                          Icon(
                                            Icons.camera,
                                            color: selected == 1
                                                ? Colors.white
                                                : Colors.black,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if(selected != null){
                          return Navigator.pop(dialogContext, selected);
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selected != null? Color(0xffE31E24):Colors.grey,
                        ),
                        child: Text(
                          "اختر",
                          style: GoogleFonts.ptSans(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  void showMessageAlert(context) {
    showDialog(
      context: context,
      builder: (contextt) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          content: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            height: 143,
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "قم بإكمال الخطوات أولا",
                      style: GoogleFonts.cairo(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 21),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset("images/warning.png"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(contextt);
                      },
                      child: Container(
                        width: 102,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffE31E24)),
                        alignment: Alignment.center,
                        child: Text(
                          "موافق",
                          style: GoogleFonts.cairo(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  TextEditingController _textFieldController = TextEditingController();

  Future<bool> displayTextInputDialog(BuildContext context) async {
    return showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(
              'سبب الإعتذار',
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
                  if (widget.getMatchDetailsEntities.data.isMainReferee ==
                      true) {
                    if (valueText.isNotEmpty) {
                     setState(() {
                       showProgress = true;
                     });
                      var response = await sl<Cases>()
                          .cancelMatch(widget.matchID, valueText);
                    setState(() {
                      showProgress = false;
                    });
                      if (response is bool) {

                        Get.back(result: true);
                      } else if (response is ResponseModelFailure) {
                        showToast(context, response.message);
                      } else {
                       errorDialog(context);
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

  String codeDialog;
  String valueText;

  Widget getBottomSheetWidget(GetTeamPlayersEntities response) {
    ReportPlayerEntities reportPlayerEntities;
    return SolidBottomSheet(
      headerBar: Container(),
      draggableBody: true,
      canUserSwipe: true,
      autoSwiped: true,
      minHeight: MediaQuery.of(context).size.height / 2,
      maxHeight: MediaQuery.of(context).size.height,
      body: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState
            /*You can rename this!*/) {
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: reportPlayerEntities != null
                ? Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "التقرير",
                          style: GoogleFonts.cairo(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          reportPlayerEntities.player,
                          textAlign: TextAlign.right,
                        ),
                        leading: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                reportPlayerEntities = null;
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          maxLines: 3,
                          onChanged: (value) {
                            reportPlayerEntities.report = value;
                          },
                          style: TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                              //hintText: "name",
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            if (reportPlayerEntities.report.toString() !=
                                    "null" &&
                                reportPlayerEntities.report != "") {
                              Get.back(result: reportPlayerEntities);
                            } else {
                              showToast(context, "يجب كتابة التقرير");
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.red)),
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.all(7),
                            child: Text(
                              "تأكيد",
                              style: GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "إختر اللاعب",
                            style: GoogleFonts.cairo(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          child: Container(
                        child: ListView.builder(
                            itemCount: response.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.only(right: 10, left: 10),
                                child: Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                      response.data[index].teamName,
                                      textAlign: TextAlign.right,
                                    )),
                                    ...response.data[index].players
                                        .map((e) => ListTile(
                                              onTap: () {
                                                setState(() {
                                                  reportPlayerEntities =
                                                      ReportPlayerEntities(
                                                          e.playerId.toString(),
                                                          e.playerName,
                                                          null);
                                                });
                                              },
                                              title: Text(
                                                e.playerName,
                                                textAlign: TextAlign.right,
                                              ),
                                            ))
                                        .toList()
                                  ],
                                ),
                              );
                            }),
                      ))
                    ],
                  ),
          );
        },
      ),
    );
  }

  void getTeamPlayerReport(GetTeamPlayersEntities response) async {
    ReportPlayerEntities reportEntities =
        await Get.bottomSheet<ReportPlayerEntities>(
      getBottomSheetWidget(response),
      enableDrag: true,
      isScrollControlled: true,
    );
    print(reportEntities);
    bool noInthere = true;
    if (reportEntities != null) {
      /*    reportPlayers.forEach((element) {
        if(reportEntities.id == element.id){
          print("there");
          setState(() {
            noInthere = false;
            print(element.report);
            reportPlayers. = reportEntities;
            print(element.report);
            print(noInthere);
          });
        }
      });*/
      for (int x = 0; x < reportPlayers.length; x++) {
        print(
            "reportEntities: ${reportEntities.id}  ${reportPlayers[x].id}  ${reportEntities.id == reportPlayers[x].id}");
        if (reportEntities.id == reportPlayers[x].id) {
          print("there");
          setState(() {
            noInthere = false;
            print(reportPlayers[x].report);
            reportPlayers[x] = reportEntities;
            print(reportPlayers[x].report);
            print(noInthere);
          });
        }
      }
      if (noInthere) {
        setState(() {
          reportPlayers.add(reportEntities);
        });
      }
      print("list : ${reportPlayers.map((e) => e.id).toList()}");
    }
  }
}
