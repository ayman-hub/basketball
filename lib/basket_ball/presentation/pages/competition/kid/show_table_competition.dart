/*
import 'package:basketball/basket_ball/presentation/widgets/match_widget.dart';
import 'package:flutter/material.dart';

class ShowTableCompetitionKid extends StatefulWidget {
  ShowTableCompetitionKid({Key key}) : super(key: key);

  @override
  _ShowTableCompetitionKidState createState() {
    return _ShowTableCompetitionKidState();
  }
}

class _ShowTableCompetitionKidState extends State<ShowTableCompetitionKid> {
  bool showChampionshipTable = false;

  bool showWorldCup = false;

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
                        showChampionshipTable = !showChampionshipTable;
                        if (showWorldCup) {
                          showWorldCup = !showWorldCup;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "جدول بطوله الدورى",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showChampionshipTable
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showChampionshipTable
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
                        showWorldCup = !showWorldCup;
                        if (showChampionshipTable) {
                          showChampionshipTable = !showChampionshipTable;
                        }
                      });
                    },
                    leading: Container(
                      width: 20,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: Text(
                      "جدول بطوله كأس مصر",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    trailing: showWorldCup
                        ? Icon(Icons.keyboard_arrow_down)
                        : Icon(Icons.arrow_forward_ios),
                  ),
                  showWorldCup
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
        ],
      ),
    );
  }
}*/
