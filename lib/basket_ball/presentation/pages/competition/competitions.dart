
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_child_competition_initial_children_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_child_competition_initial_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_children_competition_listing_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_competition_news_load_more_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/domain/use_cases/competition_controller.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/match_result_widget.dart';
import 'package:hi_market/main.dart';
import 'package:move_to_background/move_to_background.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';
import '../main_page.dart';

class CompetitionsPage extends StatefulWidget {
  CompetitionsPage({Key key,this.page}) : super(key: key);
int page;
  @override
  _CompetitionsPageState createState() {
    return _CompetitionsPageState();
  }
}

class _CompetitionsPageState extends State<CompetitionsPage> {
  int selected = 0;

  ShowCompetition showCometition = ShowCompetition.showMainCompetition;

  bool showShouterMen = false;

  int competitionID;

  int number = 0;

  ScrollController scrollController = ScrollController();

  List lastNewsData = List();
final competitionController = Get.find<CompetitionContoller>();
  @override
  void initState() {
    super.initState();
    if(widget.page != null){
      selected = widget.page;
    }
    //getgetListingCompetitionFutureData();
    getMainCompetitionData(widget.page);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
         // MoveToBackground.moveTaskToBack();
        return false;
      }, child:Scaffold(
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
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: MediaQuery.of(context).size.height / 10,
                    padding: EdgeInsets.only(bottom: 10),
                    child: IconButton(
                      icon: Image.asset(
                        Res.backimage,
                        color: Color(0xffE31E24),
                      ),
                      onPressed: () {
                        switch (showCometition) {
                          case ShowCompetition.showMainCompetition:
                            print(showCometition);
                            Move.to(context: context, page: MyHomePage());
                            break;
                          case ShowCompetition.showFirstCompetitionList:
                            setState(() {
                              showCometition = ShowCompetition.showMainCompetition;
                            });
                            break;
                        }
                      },
                    ),
                  ),
                  Container(
                    //  margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffE31E24),
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
                    child:     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              Move.to(context: context, page: MyHomePage(getPosition:3 ,getpage: 0,));
                              setState(() {
/*                              selected = 0;
                                showCometition =
                                    ShowCompetition.showMainCompetition;
                                getChildCompetitionInitiationEntities =
                                    GetChildCompetitionInitiationEntities();
                                getChildrenCompetitionListingEntities = GetChildrenCompetitionListingEntities(data: List());*/
                              });
                            },
                            child: Container(
                              decoration:BoxDecoration(
                                borderRadius: selected == 0 ? BorderRadius.circular(10):BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: selected == 0 ? Colors.white:Color(0xffE31E24),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "مسابقات الرجال",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              Move.to(context: context, page: MyHomePage(getPosition: 3,getpage: 1,));
                           /*   setState(() {
                               selected = 1;
                                showCometition =
                                    ShowCompetition.showMainCompetition;
                                getChildCompetitionInitiationEntities =
                                    GetChildCompetitionInitiationEntities();
                                getChildrenCompetitionListingEntities = GetChildrenCompetitionListingEntities(data: List());
                              });*/
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:selected == 1 ? Colors.white: Color(0xffE31E24),
                                borderRadius: selected == 1 ? BorderRadius.circular(10):BorderRadius.circular(0)
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "مسابقات السيدات",
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              Move.to(context: context, page: MyHomePage(getPosition: 3,getpage: 2,));
                         /*     setState(() {
                                selected = 2;
                                showCometition =
                                    ShowCompetition.showMainCompetition;
                                getChildCompetitionInitiationEntities =
                                    GetChildCompetitionInitiationEntities();
                                getChildrenCompetitionListingEntities = GetChildrenCompetitionListingEntities(data: List());
                              });*/
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color:selected == 2 ? Colors.white: Color(0xffE31E24),
                                  borderRadius: selected == 2 ? BorderRadius.circular(10):BorderRadius.circular(0)
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "مسابقات الناشئين",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              Move.to(context: context, page: MyHomePage(getPosition: 3,getpage: 3,));
                           /*   setState(() {
                                selected = 3;
                                showCometition =
                                    ShowCompetition.showMainCompetition;
                                getChildCompetitionInitiationEntities =
                                    GetChildCompetitionInitiationEntities();
                                getChildrenCompetitionListingEntities = GetChildrenCompetitionListingEntities(data: List());
                              });*/
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:selected == 3 ? BorderRadius.circular(10): BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color:selected == 3 ?Colors.white:Color(0xffE31E24),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "البطوله الدوليه",
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 8,
                    child: manCompetitionPage(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  manCompetitionPage() {
    switch (showCometition) {
      case ShowCompetition.showMainCompetition:
getMainCompetitionData(selected);
       return showManCompetition(selected);
        break;

      case ShowCompetition.showFirstCompetitionList:
        getgetListingCompetitionFutureData();
        return showListPage();
        break;
    }
  }

  Future getMainCompetitionFuture;
  Future getCompetitionListing;

  showManCompetition(int id) {
    return FutureBuilder(
      future: getMainCompetitionFuture ,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          print("SnapshotError: ${snapshot.error}");
          return IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 45,
              ),
              onPressed: () {
                setState(() {
                  getMainCompetitionFuture =
                      sl<Cases>().childrenCompetitionListing(id.toString());
                });
              });
        }
        if(snapshot.hasData){
          if (snapshot.data is GetChildrenCompetitionListingEntities) {
            getChildrenCompetitionListingEntities = snapshot.data;
            return Container(
              child: ListView(
                children: [
                  ...getChildrenCompetitionListingEntities.data
                      .map((e) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  showCometition =
                                      ShowCompetition.showFirstCompetitionList;
                                  competitionID = e.id;
                                });
                              },
                              leading: Container(
                                width: 10,
                                height: 50,
                                color: Color(0xffE31E24),
                              ),
                              title: Text(
                                "${e.title}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ))
                      .toList()
                ],
              ),
            );
          } else if (snapshot.data is ResponseModelFailure) {
            ResponseModelFailure failure = snapshot.data;
            showToast(context, failure.message);
            return IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 45,
                ),
                onPressed: () {
                  setState(() {
                    getMainCompetitionFuture = sl<Cases>()
                        .childrenCompetitionInitiation(
                            competitionID.toString());
                  });
                });
          } else if (snapshot.data == null) {
            return IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 45,
                ),
                onPressed: () {
                  setState(() {
                    getMainCompetitionFuture =
                        sl<Cases>().childrenCompetitionListing(id.toString());
                  });
                });
          }
        }
        return loading();
      },
    );
  }
  GetChildCompetitionInitiationEntities
  getChildCompetitionInitiationEntities =
  GetChildCompetitionInitiationEntities();
  GetChildrenCompetitionListingEntities
  getChildrenCompetitionListingEntities =
  GetChildrenCompetitionListingEntities(data: List());
  showListPage() {
    return FutureBuilder(
      future: getCompetitionListing ,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          print("SnapshotError: ${snapshot.error}");
          return IconButton(
              icon: Icon(
                Icons.refresh,
                color: Color(0xffE31E24),
                size: 45,
              ),
              onPressed: () {
                setState(() {
                  getMainCompetitionFuture = sl<Cases>()
                      .childrenCompetitionListing(competitionID.toString());
                });
              });
        }
        if(snapshot.hasData){
          if (snapshot.data is GetChildCompetitionInitiationEntities) {
            getChildCompetitionInitiationEntities = snapshot.data;
            getChildCompetitionInitiationEntities.data.matches
                .forEach((element) {
              element.teams.forEach((e) {
                print(e.title);
              });
            });
            print("nnnnnnnnnn");
           return Obx((){
             print("getCometitionIntial: ${competitionController.competitionIntial.value}");
             return Container(
               child: NotificationListener<ScrollNotification>(
                 onNotification: _getboolNotification,
                 child: ListView(
                   controller: scrollController,
                   children: [
                     Directionality(
                       textDirection: TextDirection.rtl,
                       child: ListTile(
                         onTap: () {
                           print("change table");
                       competitionController.changeCompetition(CompetitionIntial.showTables);
                         },
                         leading: Container(
                           width: 10,
                           height: 50,
                           color: Color(0xffE31E24),
                         ),
                         title: Text(
                           "جدول الفرق",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ),
                     ),
                     competitionController.competitionIntial.value == CompetitionIntial.showTables && getChildCompetitionInitiationEntities.data.orderedTable.length > 0
                         ? Container(
                       decoration: BoxDecoration(border:Border.all(color:Colors.black),color: Color(0xffE31E24),),
                       padding: EdgeInsets.all(10),
                       child: Directionality(
                         textDirection: TextDirection.rtl,
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                           children: [
                             Flexible(
                               flex: 3,
                               child: Text(
                                 "الترتيب",
                                 style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.w600,
                                     color: Colors.white),
                               ),
                             ),
                             Flexible(
                               flex: 3,
                               child: Text("الفريق",
                                   style: TextStyle(
                                       fontSize: 17,
                                       fontWeight: FontWeight.w600,
                                       color: Colors.white)),
                             ),
                             /*       Flexible(
                                      flex: 1,
                                      child: Text("فوز",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                    ),*/
                             Flexible(
                               flex: 2,
                               child: Text("فوز",
                                   style: TextStyle(
                                       fontSize: 15,
                                       fontWeight: FontWeight.w600,
                                       color: Colors.white)),
                             ),
                             Flexible(
                               flex: 2,
                               child: Text("هزيمة",
                                   style: TextStyle(
                                       fontSize: 15,
                                       fontWeight: FontWeight.w600,
                                       color: Colors.white)),
                             ),
                             Flexible(
                               flex: 2,
                               child: Text("نقاط",
                                   style: TextStyle(
                                       fontSize: 15,
                                       fontWeight: FontWeight.w600,
                                       color: Colors.white)),
                             ),
                           ],
                         ),
                       ),
                     )
                         : Container(),
                     for(int x =0 ; x<getChildCompetitionInitiationEntities.data.orderedTable.length ;x++)
                competitionController.competitionIntial.value == CompetitionIntial.showTables
             ? Container(
               color: Colors.white,
               padding: EdgeInsets.all(10),
               child: Directionality(
                 textDirection: TextDirection.rtl,
                 child: Table(
                   children: [
                     TableRow(
                       children: [
                         Text(
                           "${x+1}",
                           style: TextStyle(
                               fontSize: 20,
                               fontWeight: FontWeight.w600,
                               color: Colors.black),
                         ),
                         Text("${getChildCompetitionInitiationEntities.data.orderedTable[x].name}",
                             maxLines: 1,
                             style: TextStyle(
                                 fontSize: 17,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.black)),
                         /*    Flexible(
                                            flex: 1,
                                            child: Text("لعب",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ),*/
                         Text("${getChildCompetitionInitiationEntities.data.orderedTable[x].w}",
                             textAlign: TextAlign.left,
                             style: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.black)),
                         Text("${getChildCompetitionInitiationEntities.data.orderedTable[x].l}",
                             textAlign: TextAlign.left,
                             style: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.black)),
                         Text("${getChildCompetitionInitiationEntities.data.orderedTable[x].gb}",
                             textAlign: TextAlign.left,
                             style: TextStyle(
                                 fontSize: 15,
                                 fontWeight: FontWeight.w600,
                                 color: Colors.black)),
                       ],
                     ),
                   ],
                 ),
               ),
             )
                 : Container(),
                  /*       .map((e) {
                       print("competitions table: ${e.toJson()}");
                       int number = 0;
                       for (int x = 0;
                       x < getChildCompetitionInitiationEntities.data.orderedTable.length;
                       x++) {
                         if (e.name == getChildCompetitionInitiationEntities.data.orderedTable[x].name) {
                           number = x + 1;
                         }}
                       return competitionController.competitionIntial.value == CompetitionIntial.showTables
                           ? Container(
                         color: Colors.white,
                         padding: EdgeInsets.all(10),
                         child: Directionality(
                           textDirection: TextDirection.rtl,
                           child: Table(
                             children: [
                               TableRow(
                                 children: [
                                   Text(
                                     "${++x}",
                                     style: TextStyle(
                                         fontSize: 20,
                                         fontWeight: FontWeight.w600,
                                         color: Colors.black),
                                   ),
                                   Text("${getChildCompetitionInitiationEntities.data.orderedTable[x].name}",
                                       maxLines: 1,
                                       style: TextStyle(
                                           fontSize: 17,
                                           fontWeight: FontWeight.w600,
                                           color: Colors.black)),
                                   *//*    Flexible(
                                            flex: 1,
                                            child: Text("لعب",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                          ),*//*
                                   Text("${getChildCompetitionInitiationEntities.data.orderedTable[x].w}",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.w600,
                                           color: Colors.black)),
                                   Text("${getChildCompetitionInitiationEntities.data.orderedTable[x].l}",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.w600,
                                           color: Colors.black)),
                                   Text("${getChildCompetitionInitiationEntities.data.orderedTable[x].gb}",
                                       textAlign: TextAlign.left,
                                       style: TextStyle(
                                           fontSize: 15,
                                           fontWeight: FontWeight.w600,
                                           color: Colors.black)),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       )
                           : Container();
                     }).toList(),*/
                     SizedBox(
                       height: 10,
                     ),
                     Directionality(
                       textDirection: TextDirection.rtl,
                       child: ListTile(
                         onTap: () {
                        competitionController.changeCompetition(CompetitionIntial.showMatches);
                         },
                         leading: Container(
                           width: 10,
                           height: 50,
                           color: Color(0xffE31E24),
                         ),
                         title: Text(
                           "المباريات",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ),
                     ),
                     /*  showMatches
                          ? Container(
                        color: Color(0xffE31E24),
                        padding: EdgeInsets.all(10),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Text("الفريق",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                                     Flexible(
                                      flex: 1,
                                      child: Text("1",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                    ),
                              Flexible(
                                flex: 2,
                                child: Text("2",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text("3",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text("4",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                              Flexible(
                                flex: 2,
                                child: Text("نقاط",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      )
                          : Container(),*/
                     ...getChildCompetitionInitiationEntities.data.matches
                         .map((e) {
                       //       print("id:${e.id}  title:${e.title}");
                       return competitionController.competitionIntial.value == CompetitionIntial.showMatches && e.teams.first.title.isNotEmpty
                           ? Container(
                         // color: Colors.white,
                         padding: EdgeInsets.all(10),
                         child: Directionality(
                           textDirection: TextDirection.rtl,
                           child: e.teams.length < 2
                               ? Container()
                               : MatchResultWidget(
                               time: e.time,
                               date: e.date,
                               fName: e.teams.first.title,
                               fLogo: e.teams.first.logo,
                               fPoints: e.teams.first.result.points,
                               sLogo: e.teams.last.logo,
                               sName: e.teams.last.title,
                               sPoints: e.teams.last.result.points),
                         ),
                       )
                           : Container();
                     }).toList(),
                     SizedBox(
                       height: 10,
                     ),
                     Directionality(
                       textDirection: TextDirection.rtl,
                       child: ListTile(
                         onTap: () {
                       competitionController.changeCompetition(CompetitionIntial.showNews);
                         },
                         leading: Container(
                           width: 10,
                           height: 50,
                           color: Color(0xffE31E24),
                         ),
                         title: Text(
                           "الأخبار",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ),
                     ),
                     ...getChildCompetitionInitiationEntities.data.news.map((e) {
                       return competitionController.competitionIntial.value == CompetitionIntial.showNews
                           ? Container(
                         padding: EdgeInsets.all(10),
                         child: Column(
                           children: [
                             Container(
                                 padding: EdgeInsets.all(10),
                                 height:
                                 MediaQuery.of(context).size.height /
                                     3,
                                 child: e.thumb != null
                                     ? Image.network(e.thumb)
                                     : Icon(Icons.photo)),
                             Container(
                               margin: EdgeInsets.all(10),
                               alignment: Alignment.center,
                               child: Text("${e.title}"),
                             ),
                             Container(
                               margin: EdgeInsets.all(10),
                               alignment: Alignment.center,
                               child: Directionality(
                                   textDirection: TextDirection.rtl,
                                   child: Html(data: "${e.contents}")),
                             ),
                           ],
                         ),
                       )
                           : Container();
                     }).toList(),
                     SizedBox(
                       height: 10,
                     ),
                     Directionality(
                       textDirection: TextDirection.rtl,
                       child: ListTile(
                         onTap: () {
                        competitionController.changeCompetition(CompetitionIntial.showScorers);
                         },
                         leading: Container(
                           width: 10,
                           height: 50,
                           color: Color(0xffE31E24),
                         ),
                         title: Text(
                           "الهدافون",
                           style: TextStyle(
                               color: Colors.black,
                               fontSize: 18,
                               fontWeight: FontWeight.w600),
                         ),
                       ),
                     ),
                     ...getChildCompetitionInitiationEntities.data.scorers
                         .map((e) {
                       print("showScores: ${e.toJson()}");
                       return competitionController.competitionIntial.value == CompetitionIntial.showScorers
                           ? Column(
                         children: [
                           Directionality(
                             textDirection: TextDirection.rtl,
                             child: ListTile(
                               leading: Container(
                                 width: 20,
                                 height: 50,
                                 color: Color(0xffE31E24),
                               ),
                               title: Text(
                                 "${e.name}",
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 18,
                                     fontWeight: FontWeight.w600),
                               ),
                             ),
                           ),
                           ...e.players.map((m) {
                             print("get data: ${m.toJson()}");
                             return competitionController.competitionIntial.value == CompetitionIntial.showScorers
                                 ? Directionality(
                               textDirection: TextDirection.rtl,
                               child: Container(
                                 padding: EdgeInsets.all(10),
                                 child: Row(
                                   mainAxisAlignment:
                                   MainAxisAlignment.spaceBetween,
                                   children: [
                                     Flexible(
                                       child: Container(
                                         height: MediaQuery.of(context)
                                             .size
                                             .height /
                                             5,
                                         alignment: Alignment.center,
                                         child: Image.network(m.thumb,fit: BoxFit.fill,),
                                       ),
                                     ),
                                     Expanded(
                                         flex: 2,
                                         child: Column(
                                           mainAxisAlignment:
                                           MainAxisAlignment
                                               .center,
                                           children: [
                                             Container(
                                                 padding:
                                                 EdgeInsets.only(
                                                     right: 10),
                                                 //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                 child: Text(
                                                   "${m.name}",
                                                   style: TextStyle(
                                                       color: Colors
                                                           .black,
                                                       fontSize: MediaQuery.of(
                                                           context)
                                                           .size
                                                           .width /
                                                           27,
                                                       fontWeight:
                                                       FontWeight
                                                           .bold),
                                                 )),
                                             /*  SizedBox(height: 20,),
                                      Text("${e.position}",style: TextStyle(color: Colors.grey[700],fontSize: MediaQuery.of(context).size.width / 30,),),
                                      SizedBox(height: 10,),
                                      Text("",style: TextStyle(color: Colors.grey),),*/
                                           ],
                                         )),
                                   ],
                                 ),
                               ),
                             )
                                 : Container();
                           })
                         ],
                       )
                           : Container();
                     }).toList(),
                   ],
                 ),
               ),
             );
           });
          } else if (snapshot.data is ResponseModelFailure) {
            // if (snapshot.data is ResponseModelFailure) {
            ResponseModelFailure failure = snapshot.data;
            var platform = Theme.of(context).platform;
            platform == TargetPlatform.iOS
                ? Get.snackbar("", "",
                    messageText: Text(
                      failure.message,
                      textAlign: TextAlign.center,
                    ))
                : showToast(context, failure.message);
            return IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 45,
                ),
                onPressed: () {
                  setState(() {
                    getMainCompetitionFuture = sl<Cases>()
                        .childrenCompetitionInitiation(
                            competitionID.toString());
                  });
                });
            // }
          } else if (snapshot.data == null) {
            return IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Color(0xffE31E24),
                  size: 45,
                ),
                onPressed: () {
                  setState(() {
                    getMainCompetitionFuture = sl<Cases>()
                        .childrenCompetitionListing(competitionID.toString());
                  });
                });
          }
        }
        return loading();
      },
    );
  }

bool scroll  = true;
  bool _getboolNotification(ScrollNotification notification) {
   if(competitionController.competitionIntial.value == CompetitionIntial.showNews&& scroll){
     getDataScroll();
   }
}
getDataScroll()async{
  print(scrollController.offset);
  if (!lastNewsData.contains(scrollController.offset)) {
    setState(() {
      scroll = false;
    });
    var response = await sl<Cases>().competitionNewsLoadMore(competitionID.toString(),scrollController.offset.toString());
    if (response is GetCompetitionNewsLoadMoreEntities) {
      setState(() {
        if (response.data.length == 0) {
          scroll = false;
        }else{
          scroll = true;
        }
        lastNewsData.add(scrollController.offset);
        if(response.data.length != 0){
            if (response.data.last.title !=
                getChildCompetitionInitiationEntities.data.news.last.title) {
              response.data.forEach((element) {
                getChildCompetitionInitiationEntities.data.news.add(
                    NewsCompetition(
                        title: element.title,
                        contents: element.contents,
                        thumb: element.thumb));
              });
            }
          }
        });
    }else if (response is ResponseModelFailure) {
      print(response.message);
    }else{
      print("connection error");
    }
  }

}

  void getgetListingCompetitionFutureData() {
    print("c_id: ${competitionID.toString()}");
    getCompetitionListing =  selected == 2 ? sl<Cases>().childrenCompetitionInitiationForChildren(competitionID.toString()):
    sl<Cases>().childrenCompetitionInitiation(competitionID.toString());
  }

  void getMainCompetitionData(select) {
    print("selected: ${selected.toString()}");
    getMainCompetitionFuture =
        sl<Cases>().childrenCompetitionListing(select.toString() == "0"?4.toString():select.toString());
  }
}
