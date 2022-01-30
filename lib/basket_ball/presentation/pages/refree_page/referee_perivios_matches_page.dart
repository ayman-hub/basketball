

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_judge_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/match_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';

class RefereePreviosMatchesPage extends StatefulWidget {
  RefereePreviosMatchesPage({Key key}) : super(key: key);

  @override
  _RefereePreviosMatchesPageState createState() {
    return _RefereePreviosMatchesPageState();
  }
}

class _RefereePreviosMatchesPageState extends State<RefereePreviosMatchesPage> {
  GetJudgeMatchesEntities getJudgeMatchesEntities = GetJudgeMatchesEntities(
      data: GetJudgeMatchesData(matches: List(), notifications: List()));
  List<Matches> beforeMatches = List<Matches>();

  bool showloading = false;
 // List<Matches> afterMatches = List<Matches>();

/*  refactorDate(String date) {
    List formateDate = date.split("/").toList();
    return "${formateDate[2]}-${formateDate[1]}-${formateDate[0]}";
  }*/

  getData() async {
    setState(() {
      showloading = true;
    });
    var response = await sl<Cases>().getJudgeMatchesEntities();
    setState(() {
      showloading = false;
    });
    if (response is GetJudgeMatchesEntities) {
      setState(() {
        beforeMatches = List();
      });
        getJudgeMatchesEntities = response;
        getJudgeMatchesEntities.data.matches.forEach((element) {
          if(element.matchDate != ""&&element.matchTime != ""&&element.match.results.length != 0 ){
          print("matchDate: ${refactorDate(element.matchDate)}");
          print(DateTime.now());
          print(refactorDate(element.matchDate));
          if (refactorDate(element.matchDate)
              .add(element.matchTime != "" && element.matchTime != null
                  ? Duration(
                      hours: int.parse(element.matchTime.split(":").first),
                      minutes: int.parse(element.matchTime.split(":").last))
                  : Duration(minutes: 1))
              .isBefore(DateTime.now()/*.subtract(Duration(days: 1))*/)) {
            setState(() {
              beforeMatches.add(element);
              // afterMatches.add(element);
            });
          }
        }
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
      errorDialog(context);
    }
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height / 1.9,
      //margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 4),
      child: LiquidPullToRefresh(
        onRefresh: ()async{
          getData();
        },
        backgroundColor: Colors.white,
        color: staticColor,
        child: beforeMatches.length == 0?Container(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: showloading ?loading():Text('لا يوجد مباريات',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),),
        ): ListView.builder(itemCount: beforeMatches.length,itemBuilder: (context,index){
          Color  firstTeam = staticColor;
          Color secondTeam  = staticColor ;
          try{
           firstTeam = (int.parse(beforeMatches[index].match.results.first.result?.points??"0") > int.parse(beforeMatches[index].match.results.last.result?.points??"0")  )?Colors.green:staticColor;
           secondTeam = (int.parse(beforeMatches[index].match.results.last.result?.points??"0") > int.parse(beforeMatches[index].match.results.first.result?.points??"0")  )?Colors.green:staticColor;
          }catch(e){
            print('e');
          }
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
             // border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            // padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context)
                                .size
                                .width /
                                4,
                            width: MediaQuery.of(context)
                                .size
                                .width /
                                3,
                            child: Image.network(
                                beforeMatches[index]
                                    .match
                                    .results
                                    .first
                                    .logo),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${beforeMatches[index].match.results.first.title}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight:
                                  FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Container(
                            //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                            //  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 20),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                  MediaQuery.of(context)
                                      .size
                                      .height /
                                      60,
                                ),
                                Text(
                                  "${beforeMatches[index].matchDate}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.w600,
                                      fontSize: MediaQuery.of(
                                          context)
                                          .size
                                          .width /
                                          20),
                                ),
                                // SizedBox(height:20,),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      "${beforeMatches[index].match.results.first.result.points}",
                                      style: TextStyle(
                                          color: firstTeam,
                                          fontSize: 20),
                                    ),
                                    /*  Column(
                                                              children: [
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: Color(0xffE31E24)
                                                                    ),
                                                                    padding: EdgeInsets.all(5),
                                                                    child: Text("40",style: TextStyle(color: Colors.white,fontSize: 10),)),
                                                              ],
                                                            ),*/
                                    Text(
                                      "${beforeMatches[index].match.results.last.result.points}",
                                      style: TextStyle(
                                          color: secondTeam,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
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
                      flex: 2,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context)
                                .size
                                .width /
                                4,
                            width: MediaQuery.of(context)
                                .size
                                .width /
                                3,
                            child: Image.network(
                                beforeMatches[index]
                                    .match
                                    .results
                                    .last
                                    .logo),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${beforeMatches[index].match.results.last.title}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight:
                                  FontWeight.w600,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "${beforeMatches[index].matchLeague}",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(
                          context)
                          .size
                          .height /
                          40),
                  textAlign:
                  TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 10,)
              ],
            ),
          );
        },),
      ),
    );
  }
}