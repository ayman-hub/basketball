/*
import 'package:basketball/basket_ball/presentation/widgets/arrangement_widget.dart';
import 'package:basketball/basket_ball/presentation/widgets/match_result_widget.dart';
import 'package:basketball/basket_ball/presentation/widgets/match_widget.dart';
import 'package:flutter/material.dart';

class ShowKidArabCompetitionProgressManPage extends StatefulWidget {
  ShowKidArabCompetitionProgressManPage({Key key}) : super(key: key);

  @override
  _ShowKidArabCompetitionProgressManPageState createState() {
    return _ShowKidArabCompetitionProgressManPageState();
  }
}

class _ShowKidArabCompetitionProgressManPageState extends State<ShowKidArabCompetitionProgressManPage> {
  bool showArabChampionshipForMen = false;

  bool showArabChampionshipForMenResult = false;

  bool showTableChampionship = false;

  bool showShouterMen = false;

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
    return Container(
      //padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 50),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        showArabChampionshipForMen = !showArabChampionshipForMen;
                        if (showArabChampionshipForMenResult) {
                          showArabChampionshipForMenResult =
                          !showArabChampionshipForMenResult;
                        }
                        if (showTableChampionship) {
                          showTableChampionship =
                          !showTableChampionship;
                        }
                        if (showShouterMen) {
                          showShouterMen =
                          !showShouterMen;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "???????? ?????????????? ?????????????? ????????????",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showArabChampionshipForMen
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showArabChampionshipForMen
                      ? Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          List data = List(10);
                          return Container(
                            padding: EdgeInsets.all(10),
                            height:
                            MediaQuery.of(context).size.height / 2,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ListTile(
                                      leading: Container(
                                        width: 20,
                                        height: 50,
                                        color: Colors.red,
                                      ),
                                      title: Text(
                                        "?????????? , 29 ????????",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      //  height:MediaQuery.of(context).size.height / 2,
                                      child: ListView(
                                        children: [
                                          ...data
                                              .map((e) => Directionality(
                                              textDirection:
                                              TextDirection.ltr,
                                              child: MatchWidget()))
                                              .toList()
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          );
                        }),
                  )
                      : Container(),
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
                        showArabChampionshipForMenResult = !showArabChampionshipForMenResult;
                        if (showArabChampionshipForMen) {
                          showArabChampionshipForMen =
                          !showArabChampionshipForMen;
                        }
                        if (showTableChampionship) {
                          showTableChampionship =
                          !showTableChampionship;
                        }
                        if (showShouterMen) {
                          showShouterMen =
                          !showShouterMen;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "?????????? ?????????????? ?????????????? ????????????",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showArabChampionshipForMenResult
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showArabChampionshipForMenResult
                      ? Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          List data = List(10);
                          return Container(
                            padding: EdgeInsets.all(10),
                            height:
                            MediaQuery.of(context).size.height / 2,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ListTile(
                                      leading: Container(
                                        width: 20,
                                        height: 50,
                                        color: Colors.red,
                                      ),
                                      title: Text(
                                        "?????????? , 29 ????????",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      //  height:MediaQuery.of(context).size.height / 2,
                                      child: ListView(
                                        children: [
                                          ...data
                                              .map((e) => Directionality(
                                              textDirection:
                                              TextDirection.ltr,
                                              child:
                                              MatchResultWidget()))
                                              .toList()
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          );
                        }),
                  )
                      : Container(),
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
                        showTableChampionship = !showTableChampionship;
                        if (showArabChampionshipForMenResult) {
                          showArabChampionshipForMenResult =
                          !showArabChampionshipForMenResult;
                        }
                        if (showArabChampionshipForMen) {
                          showArabChampionshipForMen =
                          !showArabChampionshipForMen;
                        }
                        if (showShouterMen) {
                          showShouterMen =
                          !showShouterMen;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "?????????? ??????????????",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showTableChampionship
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showTableChampionship
                      ? Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          List data = List(10);
                          return Container(
                            padding: EdgeInsets.all(10),
                            height:
                            MediaQuery.of(context).size.height / 2,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Container(
                                    color: Colors.red,
                                    padding: EdgeInsets.all(10),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: Text(
                                              "??????????????",
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                      context)
                                                      .size
                                                      .width /
                                                      21,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: Text("????????????",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Text("??????",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text("??????",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text("??????????",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text("????????",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Container(
                                      color: Colors.white,
                                      //  height:MediaQuery.of(context).size.height / 2,
                                      child: ListView(
                                        children: [
                                          ...data
                                              .map((e) => Directionality(
                                              textDirection:
                                              TextDirection.ltr,
                                              child:
                                              ArrangementWidget()))
                                              .toList()
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          );
                        }),
                  )
                      : Container(),
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
                        showShouterMen = !showShouterMen;
                        if (showArabChampionshipForMenResult) {
                          showArabChampionshipForMenResult =
                          !showArabChampionshipForMenResult;
                        }
                        if (showTableChampionship) {
                          showTableChampionship =
                          !showTableChampionship;
                        }
                        if (showArabChampionshipForMen) {
                          showArabChampionshipForMen =
                          !showArabChampionshipForMen;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "????????????????",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showShouterMen
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showShouterMen
                      ? Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child:  ListView.builder(itemCount: 10,itemBuilder: (context,index){
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(height: MediaQuery.of(context).size.height / 5,
                                child: Placeholder(),
                              ),
                            ),
                            Expanded(
                                flex: 2
                                ,child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("dddd",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                                SizedBox(height: 20,),
                                Text("dd",style: TextStyle(color: Colors.grey),),
                                SizedBox(height: 10,),
                                Text("d",style: TextStyle(color: Colors.grey),),
                              ],
                            )),
                          ],
                        ),
                      );
                    }),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
