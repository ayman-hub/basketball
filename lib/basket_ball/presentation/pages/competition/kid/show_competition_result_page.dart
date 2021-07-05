/*
import 'package:basketball/basket_ball/presentation/widgets/match_result_widget.dart';
import 'package:flutter/material.dart';

class ShowCompetitionResultKid extends StatefulWidget {
  ShowCompetitionResultKid({Key key}) : super(key: key);

  @override
  _ShowCompetitionResultKidState createState() {
    return _ShowCompetitionResultKidState();
  }
}

class _ShowCompetitionResultKidState extends State<ShowCompetitionResultKid> {
  bool showChampionshipResult = false;

  bool showWorldCupResult = false;

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
      padding: EdgeInsets.all(10),
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
                        showChampionshipResult = !showChampionshipResult;
                        if (showWorldCupResult) {
                          showWorldCupResult = !showWorldCupResult;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "نتائج بطوله الدورى",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showChampionshipResult
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showChampionshipResult
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
                                        "الاحد , 29 مارس",
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
                        showWorldCupResult = !showWorldCupResult;
                        if (showChampionshipResult) {
                          showChampionshipResult = !showChampionshipResult;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "نتائج بطوله كأس مصر",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showWorldCupResult
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showWorldCupResult
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
                                        "الاحد , 29 مارس",
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
        ],
      ),
    );
  }
}*/
