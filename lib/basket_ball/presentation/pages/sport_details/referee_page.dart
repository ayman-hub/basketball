import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_listing_all_referees_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_referee_conditions_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/referee_reference_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../injection.dart';

class RefereePage extends StatefulWidget {
  RefereePage({Key key}) : super(key: key);

  @override
  _RefereePageState createState() {
    return _RefereePageState();
  }
}

class _RefereePageState extends State<RefereePage> {
  bool showReferee = false;

  bool showConditions = false;

  bool showRefereeReference = false;
/*
  GetListingAllRefereesEntities getListingAllRefereesEntities =
      GetListingAllRefereesEntities(data: List());*/
  GetRefereesConditionsEntities getRefereesConditionsEntities =
      GetRefereesConditionsEntities();
  RefereeReferenceEntities refereeReferenceEntities =
      RefereeReferenceEntities(data: RefreeReferenceData(text: "", url: ""));


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
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
          /*  Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                onTap: () async {
                  if (getListingAllRefereesEntities.data.length == 0) {
                    var response = await sl<Cases>().listingAllRefrees();
                    if (response is GetListingAllRefereesEntities) {
                      setState(() {
                        showReferee = !showReferee;
                        if (showConditions) {
                          showConditions = !showConditions;
                        }
                      });
                      setState(() {
                        getListingAllRefereesEntities = response;
                      });
                    } else if (response is ResponseModelFailure) {
                      print(response.message);
                    } else {
                      print("Connection Error");
                    }
                  } else {
                    setState(() {
                      showReferee = !showReferee;
                      if (showConditions) {
                        showConditions = !showConditions;
                      }
                    });
                  }
                },
                leading: Container(
                  width: 10,
                  height: 50,
                  color: Color(0xffE31E24),
                ),
                title: Text(
                  "الحكام",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                trailing: showReferee
                    ? Icon(Icons.keyboard_arrow_down)
                    : Icon(Icons.arrow_forward_ios),
              ),
            ),
            ...getListingAllRefereesEntities.data
                .map((e) => showReferee
                    ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  height: MediaQuery.of(context).size.height / 5,
                                  child: Image.network(
                                    e.newsThumb,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${e.title}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "كود المدرب",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${e.code}",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "الدرجة",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${e.degree}",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "الفرع",
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "${e.branch}",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      )
                    : Container())
                .toList(),
            SizedBox(
              height: 20,
            ),*/
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                onTap: () async{
                  if(getRefereesConditionsEntities.data == null){
                    var responseCondition = await sl<Cases>().refreesCondition();
                    if (responseCondition is GetRefereesConditionsEntities) {
                      setState(() {
                        showConditions = !showConditions;
                        if (showReferee) {
                          showReferee = !showReferee;
                        } else if (showRefereeReference) {
                          showRefereeReference = !showRefereeReference;
                        }
                      });
                      setState(() {
                        getRefereesConditionsEntities = responseCondition;
                      });
                    } else if (responseCondition is ResponseModelFailure) {
                      print(responseCondition.message);
                    } else {
                      print("Connection Error");
                    }
                  }else{
                    setState(() {
                      showConditions = !showConditions;
                      if (showReferee) {
                        showReferee = !showReferee;
                      } else if (showRefereeReference) {
                        showRefereeReference = !showRefereeReference;
                      }
                    });
                  }

                },
                leading: Container(
                  width: 10,
                  height: 50,
                  color: Color(0xffE31E24),
                ),
                title: Text(
                  "شروط قيد الحكام",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                trailing: showConditions
                    ? Icon(Icons.keyboard_arrow_down)
                    : Icon(Icons.arrow_forward_ios),
              ),
            ),
            showConditions
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: HtmlWidget(
                              getRefereesConditionsEntities?.data?.contents ?? "",
                        )),
                  )
                : Container(),
            SizedBox(height: 10,),
            AnimatedContainer(
              duration: Duration(milliseconds: 50),
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      onTap: ()async {
                        if(refereeReferenceEntities.data.text == ""){
                          var responseReference =
                              await sl<Cases>().refereeReference();
                          if (responseReference is RefereeReferenceEntities) {
                            setState(() {
                              print("here");
                              showRefereeReference = !showRefereeReference;
                              print("showReferences: $showRefereeReference");
                              if (showReferee) {
                                showReferee = !showReferee;
                              } else if (showConditions) {
                                showConditions = !showConditions;
                              }
                            });
                            setState(() {
                              refereeReferenceEntities.data.text = responseReference.data.text;
                              refereeReferenceEntities.data.url = responseReference.data.url;
                            });
                          } else if (responseReference is ResponseModelFailure) {
                            print(responseReference.message);
                          }
                        }else{
                          setState(() {
                            showRefereeReference = !showRefereeReference;
                            if (showReferee) {
                              showReferee = !showReferee;
                            } else if (showConditions) {
                              showConditions = !showConditions;
                            }
                          });
                        }
                      },
                      leading: Container(
                        width: 10,
                        height: 50,
                        color: Color(0xffE31E24),
                      ),
                      title: Text(
                        "مرجع الحكم",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.all(10),
                        color: Color(0xffE31E24),
                        child: InkWell(
                          child: Icon(
                            Icons.file_download,
                            color: Colors.white,
                          ),
                          onTap: () async {
                            if (refereeReferenceEntities.data.url != "") {
                              var tempDir = await getTemporaryDirectory();
                              String fullPath = tempDir.path +
                                  "${refereeReferenceEntities.data.url.split("/").last}";
                              print('full path $fullPath');
                              download2(
                                  Dio(),
                                  refereeReferenceEntities.data.url,
                                  "${refereeReferenceEntities.data.url.split("/").last}",
                                  context);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  showRefereeReference
                      ? Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            // height: MediaQuery.of(context).size.height / 1.5,
                            child: Container(
                              decoration: BoxDecoration(
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
                              width: MediaQuery.of(context).size.width,
                              child: HtmlWidget(
                               refereeReferenceEntities.data.text,
                              /*  padding: EdgeInsets.all(10),*/
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
