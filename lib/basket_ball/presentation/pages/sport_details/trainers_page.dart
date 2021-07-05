
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hi_market/basket_ball/domain/entities/get_code_rules_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_listing_all_referees_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_referee_conditions_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../../injection.dart';
import '../../../../res.dart';

class TrainersPage extends StatefulWidget {
  TrainersPage({Key key}) : super(key: key);

  @override
  _TrainersPageState createState() {
    return _TrainersPageState();
  }
}

class _TrainersPageState extends State<TrainersPage> {
  bool showTrainer = false;


  bool showRules = false;


  GetCoachesRulesEntities getCoachesRulesEntities = GetCoachesRulesEntities(data: List());
  GetRefereesConditionsEntities getRefereesConditionsEntities = GetRefereesConditionsEntities();
/*  GetListingAllRefereesEntities getListingAllRefereesEntities = GetListingAllRefereesEntities(data: List());*/
  getData()async{
  /*  var response = await sl<Cases>().listingCoaches();
    if (response is GetListingAllRefereesEntities) {
      setState(() {
        getListingAllRefereesEntities = response;
      });
    } else if (response is ResponseModelFailure) {
      print(response.message);
    }   else {
      print("Connection Error");
    }*/
    var responseCondition = await sl<Cases>().coachesTermsConditions();
    if (responseCondition is GetRefereesConditionsEntities) {
      setState(() {
        getRefereesConditionsEntities = responseCondition;
      });
    } else if (responseCondition is ResponseModelFailure) {
      print(responseCondition.message);
    }   else {
      print("Connection Error");
    }
    var responseRules = await sl<Cases>().coachesRules();
    if (responseRules is GetCoachesRulesEntities) {
      setState(() {
        getCoachesRulesEntities = responseRules;
      });
    } else if (responseRules is ResponseModelFailure) {
      print(responseRules.message);
    }   else {
      print("Connection Error");
    }
  }

  @override
  void initState() {
    super.initState();
    //getRefereesConditionsEntities.data.contents = "";
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
          /*  Directionality(
              textDirection: TextDirection.rtl,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 50),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        setState(() {
                          showTrainer = !showTrainer;
                          if (showRules) {
                            showRules = !showRules;
                          }
                        });
                      },
                      leading: Container(
                        width: 10,
                        height: 50,
                        color: Color(0xffE31E24),
                      ),
                      title: Text(
                        "المدربين",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: showTrainer?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
                    ),
                    ...getListingAllRefereesEntities.data.map((e) => showTrainer ?Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(height: MediaQuery.of(context).size.height / 5,
                                child: Image.network(e.newsThumb),
                              ),
                            ),
                            Expanded(
                                flex: 2
                                ,child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${e.title}",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Text("كود المدرب",style: TextStyle(color: Colors.grey),),
                                    SizedBox(width: 20,),
                                    Text("${e.code}",style: TextStyle(color: Colors.black),),

                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Text("الدرجة",style: TextStyle(color: Colors.grey),),
                                    SizedBox(width: 20,),
                                    Text("${e.degree}",style: TextStyle(color: Colors.black),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    Text("الفرع",style: TextStyle(color: Colors.grey),),
                                    SizedBox(width: 20,),
                                    Text("${e.branch}",style: TextStyle(color: Colors.black),),
                                  ],
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ):Container()).toList(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),*/
            Directionality(
              textDirection: TextDirection.rtl,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 50),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SolidBottomSheet(
                                  maxHeight: MediaQuery.of(context).size.height / 1.2,
                                  minHeight: MediaQuery.of(context).size.height / 1.5,
                                  headerBar: Container(
                                    height: 50,
                                    padding: EdgeInsets.only(right: 10,left: 10),
                                    alignment: Alignment.centerRight,
                                    child: Text("شروط قيد المدربين",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                    color: Colors.white,
                                  ), body: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: ListView(
                                    children: [
                                      Directionality(
                                        textDirection:TextDirection.rtl,
                                        child: Html(
                                          data:'${getRefereesConditionsEntities?.data?.contents??""}',
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ));
                            });
                      },
                      leading: Container(
                        width: 10,
                        height: 50,
                        color: Color(0xffE31E24),
                      ),
                      title: Text(
                        "شروط قيد المدربين",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 50),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        setState(() {
                          showRules = !showRules;
                          if (showTrainer) {
                            showTrainer = !showTrainer;
                          }
                        });
                      },
                      leading: Container(
                        width: 10,
                        height: 50,
                        color: Color(0xffE31E24),
                      ),
                      title: Text(
                        "قواعد تصنيف المدرب",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: showRules?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
                    ),
                    ...getCoachesRulesEntities.data.map((e) =>  showRules ?InkWell(
                      onTap: (){
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SolidBottomSheet(
                                  maxHeight: MediaQuery.of(context).size.height / 1.2,
                                  minHeight: MediaQuery.of(context).size.height / 1.5,
                                  headerBar: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text("${e.title}",textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                    color: Colors.white,
                                  ), body: Container(
                                color: Colors.white,
                                height: MediaQuery.of(context).size.height / 2,
                                child:  Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: ListView(
                                      children: [
                                        Html(data:"${e.contents}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: 20),
                        alignment: Alignment.centerRight,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            leading:Container(width: 10,height: 50,color: Color(0xffE31E24),),
                            title: Text("${e.title}",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ),
                    ):Container()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}