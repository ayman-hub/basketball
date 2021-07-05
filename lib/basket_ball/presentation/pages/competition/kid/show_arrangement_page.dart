/*
import 'package:basketball/basket_ball/presentation/widgets/arrangement_widget.dart';
import 'package:flutter/material.dart';

class ShowKidArragnementPage extends StatefulWidget {
  ShowKidArragnementPage({Key key}) : super(key: key);

  @override
  _ShowKidArragnementPageState createState() {
    return _ShowKidArragnementPageState();
  }
}

class _ShowKidArragnementPageState extends State<ShowKidArragnementPage> {
  bool showChampionshipArrangement = false;

  bool showWorldCupArrangement = false;

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
                        showChampionshipArrangement =
                        !showChampionshipArrangement;
                        if (showWorldCupArrangement) {
                          showWorldCupArrangement = !showWorldCupArrangement;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "ترتيب الفرق فى بطوله الدورى",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showChampionshipArrangement
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showChampionshipArrangement
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
                                    padding: EdgeInsets.all(10),
                                    color: Colors.red,
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
                                              "الترتيب",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 3,
                                            child: Text("الفريق",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Text("لعب",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text("فوز",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text("هزيمة",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text("نقاط",
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
                                      width: MediaQuery.of(context)
                                          .size
                                          .width,
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
                        showWorldCupArrangement = !showWorldCupArrangement;
                        if (showChampionshipArrangement) {
                          showChampionshipArrangement =
                          !showChampionshipArrangement;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "ترتيب الفرق بطوله كأس مصر",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showWorldCupArrangement
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showWorldCupArrangement
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
                                              "الترتيب",
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
                                            child: Text("الفريق",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Text("لعب",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text("فوز",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text("هزيمة",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600)),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text("نقاط",
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
        ],
      ),
    );
  }
}*/
