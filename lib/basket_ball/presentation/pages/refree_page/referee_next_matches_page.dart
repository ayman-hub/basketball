
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_judge_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';

class RefereeNextMatchesPage extends StatefulWidget {
  RefereeNextMatchesPage({Key key}) : super(key: key);

  @override
  _RefereeNextMatchesPageState createState() {
    return _RefereeNextMatchesPageState();
  }
}

class _RefereeNextMatchesPageState extends State<RefereeNextMatchesPage> {
  GetJudgeMatchesEntities getJudgeMatchesEntities = GetJudgeMatchesEntities(
      data: GetJudgeMatchesData(matches: List(), notifications: List()));
  //List<Matches> beforeMatches = List<Matches>();
   List<Matches> afterMatches = List<Matches>();



  getData() async {
    var response = await sl<Cases>().getJudgeMatchesEntities();
    if (response is GetJudgeMatchesEntities) {
      setState(() {
        afterMatches = List();
        getJudgeMatchesEntities = response;
        getJudgeMatchesEntities.data.matches.forEach((element) {
          if(element.matchDate != ""&&element.matchTime != ""&&element.match.results.length != 0 ){
            print("matchDate: ${refactorDate(element.matchDate)}");
            print(DateTime.now());
            if (!refactorDate(element.matchDate)
                .add(element.matchTime != ""
                    ? Duration(
                        hours: int.parse(element.matchTime.split(":").first),
                        minutes: int.parse(element.matchTime.split(":").last))
                    : Duration(minutes: 1))
                .isBefore(DateTime.now()/*.subtract(Duration(days: 1))*/)) {
              print("nextmatch: ${element.matchDate}");
              setState(() {
                afterMatches.add(element);
                // afterMatches.add(element);
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
    return Container(
      height: MediaQuery.of(context).size.height / 1.6,
      child: LiquidPullToRefresh(
        onRefresh: ()async{
          getData();
        },
        backgroundColor: Colors.white,
        color: staticColor,
        child: ListView.builder(itemCount: afterMatches.length,itemBuilder: (context,index){
          return afterMatches[index].status == "Accepted"&&!(sl<Cases>().getMatchIdSharedPreference().data.contains(afterMatches[index].match.id.toString()))? Container(
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
                  offset: Offset(2.0,
                      2.0), // shadow direction: bottom right
                )
              ],
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context)
                            .size
                            .width /
                            3,
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            3,
                        child: Image.network(
                            afterMatches[index]
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
                          "${afterMatches[index].match.results.first.title}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight:
                              FontWeight.w600,
                              fontSize:
                              MediaQuery.of(context)
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
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${afterMatches[index].matchDate}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight:
                              FontWeight.w600,
                              fontSize:
                              MediaQuery.of(context)
                                  .size
                                  .width /
                                  20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              "${afterMatches[index].matchTime}",
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
                            //    Text(" PM",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize:  MediaQuery.of(context).size.width / 45),),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${afterMatches[index].matchLeague}",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight:
                              FontWeight.w600,
                              fontSize:
                              MediaQuery.of(context)
                                  .size
                                  .width /
                                  40),
                          textAlign: TextAlign.center,
                          maxLines: 2,
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
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context)
                            .size
                            .width /
                            3,
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            3,
                        child: Image.network(
                            afterMatches[index]
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
                          "${afterMatches[index].match.results.last.title}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight:
                              FontWeight.w600,
                              fontSize:
                              MediaQuery.of(context)
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
          ):Container();
        }),
      ),
    );
  }
}
