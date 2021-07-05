import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/referee_report_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_report_match_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';
import 'notification_page.dart';

class ReportRefereePage extends StatefulWidget {
  ReportRefereePage({Key key, this.image, @required this.refereeReportEntities})
      : super(key: key);
  File image;
  RefereeReportEntities refereeReportEntities;

  @override
  _ReportRefereePageState createState() {
    return _ReportRefereePageState();
  }
}

class _ReportRefereePageState extends State<ReportRefereePage> {
  int selected = 2;

  bool showEditProfile = false;

  String nationalID;

  String phone;

  final formKey = GlobalKey<FormState>();
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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getNotificationData() async {
    var response = await sl<Cases>().getNotification();
    if (response is NotificationEntities) {
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
              child: ListView(
                children: [
                  Container(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    // alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                              // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                              height: MediaQuery.of(context).size.height / 15,
                              // margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 10),
                              child: IconButton(
                                  icon: Image.asset(
                                    Res.backimage,
                                    color: Color(0xffE31E24),
                                  ),
                                  onPressed: () {
                                    Move.to(
                                        context: context,
                                        page: RefereeMainPage(
                                          image: widget.image,
                                        ));
                                  })),
                        ),
                        Flexible(
                          child: Container(
                            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: InkWell(
                              onTap: getImage,
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: sl<Cases>()
                                                .getLoginData()
                                                .data
                                                ?.profilePic !=
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
                            //   decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Image.asset("images/retern.png"),
                                  onPressed: () async {
                                    ProgressDialog dialog = ProgressDialog(context);
                                    dialog.show();
                                    var response =
                                        await sl<Cases>().refereeReport();
                                    dialog.hide();
                                    if (response is RefereeReportEntities) {
                                      setState(() {
                                        widget.refereeReportEntities = response;
                                      });
                                    } else if (response
                                        is ResponseModelFailure) {
                                      showToast(context, response.message);
                                    } else {
                                      showToast(context, "Connection Error");
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "رصيد الحكم",
                      style: GoogleFonts.cairo(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 114,
                    child: Material(
                      color: Colors.white,
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(10),
                      shadowColor: Colors.grey[400],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "الرصيد الحالى",
                                      style: GoogleFonts.cairo(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              30),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "جنيه",
                                          style: GoogleFonts.cairo(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "${widget.refereeReportEntities.data.balance}",
                                          style: GoogleFonts.cairo(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "تم رفضها",
                                      style: GoogleFonts.cairo(
                                          color: Color(0xffE31E24),
                                          fontWeight: FontWeight.w700,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              30),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "مباريات",
                                          style: GoogleFonts.cairo(
                                              color: Color(0xffE31E24),
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${widget.refereeReportEntities.data.rejectedCount}",
                                          style: GoogleFonts.cairo(
                                              color: Color(0xffE31E24),
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 20, right: 10, left: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "تم تحكيمها",
                                      style: GoogleFonts.cairo(
                                          color: Color(0xff31CF47),
                                          fontWeight: FontWeight.w700,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              30),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "مباراه",
                                          style: GoogleFonts.cairo(
                                              color: Color(0xff31CF47),
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          "${widget.refereeReportEntities.data.acceptedCount}",
                                          style: GoogleFonts.cairo(
                                              color: Color(0xff31CF47),
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  30),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 20),
                        child: Text(
                          "الإحصائيات",
                          style: GoogleFonts.cairo(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
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
                        // padding: EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "تم رفضها",
                                          style: GoogleFonts.cairo(
                                              color: Color(0xffE31E24),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.3,
                                      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                      child: ListView.builder(
                                        itemCount: widget.refereeReportEntities.data.rejectedMatches.length /*afterMatches.length*/,
                                        itemBuilder: (context, index) {
                                          return widget.refereeReportEntities.data.rejectedMatches[index].match.results.length < 2?Container(): Container(
                                            margin: EdgeInsets.only(
                                                right: 10, left: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            //  padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                            child: Image.network(
                                                                widget.refereeReportEntities.data.rejectedMatches[index].match.results.first.logo) /*Image.network(
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
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "${widget.refereeReportEntities.data.rejectedMatches[index].match.results.first.title}",
                                                            textAlign:TextAlign.center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      40),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                "${widget.refereeReportEntities.data.rejectedMatches[index].matchDate}",
                                                                style: GoogleFonts.cairo(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        45),
                                                              ),
                                                              Image.asset(
                                                                "images/Rectangle.png",
                                                                scale: 2,
                                                              ),
                                                              Text(
                                                                "${week[refactorDate(widget.refereeReportEntities.data.rejectedMatches[index].matchDate).weekday]}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        45),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "${widget.refereeReportEntities.data.rejectedMatches[index].matchTime}",
                                                                  style: GoogleFonts.cairo(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          MediaQuery.of(context).size.width /
                                                                              45),
                                                                ),
                                                                //    Text(" PM",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize:  MediaQuery.of(context).size.width / 45),),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "${widget.refereeReportEntities.data.rejectedMatches[index].matchLeague}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      55),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                            child: Image.network(widget.refereeReportEntities.data.rejectedMatches[index].match.results.last.logo) /*Image.network(
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
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "${widget.refereeReportEntities.data.rejectedMatches[index].match.results.last.title}",
                                                              textAlign:TextAlign.center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      40),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "تم الرفض",
                                                        style:
                                                            GoogleFonts.cairo(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                        width: 15,
                                                        child: CircleAvatar(
                                                            backgroundColor:
                                                                Color(
                                                                    0xffC40606),
                                                            child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
                                                              size: 10,
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 2,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.grey,
                              width: 2,
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Column(
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "تم تحكيمها",
                                          style: GoogleFonts.cairo(
                                              color: Colors.green,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.3,
                                      // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                      child: ListView.builder(
                                        itemCount: widget.refereeReportEntities.data.acceptedMatches.length /*beforeMatches.length*/,
                                        itemBuilder: (context, index) {
                                          return widget.refereeReportEntities.data.acceptedMatches[index].match.results.length < 2?Container():Container(
                                            margin: EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            // padding: EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      flex: 2,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                            child: Image.network(widget.refereeReportEntities.data.acceptedMatches[index].match.results.first.logo) /* Image.network(
                                                        beforeMatches[index]
                                                            .match
                                                            .results
                                                            .first
                                                            .logo)*/
                                                            ,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "${widget.refereeReportEntities.data.acceptedMatches[index].match.results.first.title}",
                                                              textAlign:TextAlign.center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                            //  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      60,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      "${widget.refereeReportEntities.data.acceptedMatches[index].matchDate}",
                                                                      style: GoogleFonts.cairo(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.width / 45),
                                                                    ),
                                                                    Flexible(
                                                                      child: SizedBox(
                                                                        width: 2,
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child: Image.asset(
                                                                        "images/Rectangle.png",
                                                                        scale: 2,
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child: SizedBox(
                                                                        width: 2,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "${week[refactorDate(widget.refereeReportEntities.data.acceptedMatches[index].matchDate).weekday]}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.width / 45),
                                                                    ),
                                                                  ],
                                                                ),
                                                                // SizedBox(height:20,),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "${widget.refereeReportEntities.data.acceptedMatches[index].match.results.first.result.points}",
                                                                      style: GoogleFonts.cairo(
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color: Color(
                                                                              0xffE31E24),
                                                                          fontSize:
                                                                              10),
                                                                    ),
                                                                    Text(
                                                                      "${widget.refereeReportEntities.data.acceptedMatches[index].match.results.last.result.points}",
                                                                      style: GoogleFonts.cairo(
                                                                          color: Color(
                                                                              0xffE31E24),
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              10),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "${getChatTime(widget.refereeReportEntities.data.acceptedMatches[index].matchTime)}",
                                                                      style: GoogleFonts.cairo(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height / 60),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    /*Text(
                                                                      " PM",
                                                                      style: GoogleFonts.cairo(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize:
                                                                              MediaQuery.of(context).size.height / 60),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),*/
                                                                  ],
                                                                ),
                                                                Text(
                                                                  "${widget.refereeReportEntities.data.acceptedMatches[index].matchLeague}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          MediaQuery.of(context).size.height /
                                                                              60),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 2,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                10,
                                                            child: Image.network(
                                                                "${widget.refereeReportEntities.data.acceptedMatches[index].match.results.last.logo}") /*Image.network(
                                                        beforeMatches[index]
                                                            .match
                                                            .results
                                                            .last
                                                            .logo)*/
                                                            ,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "${widget.refereeReportEntities.data.acceptedMatches[index].match.results.last.title}",
                                                              textAlign:TextAlign.center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 10),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                  thickness: 2,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        widget.image = File(image.path);
      });
      var respond = await sl<Cases>().updateUserPicture(widget.image);
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
            : showToast(context, failure.message);
      } else {
        var platform = Theme.of(context).platform;
        platform == TargetPlatform.iOS
            ? Get.snackbar("", "",
                messageText: Text(
                  "error connection",
                  textAlign: TextAlign.center,
                ))
            : showToast(context, "error connection");
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
}
