import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_branches.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_department_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_year_enities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_head_Entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/TileWidget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../../../injection.dart';

enum UnionBoard {
  showManagement,
  showManagements,
  showBranches,
  showHeaders,
  none
}

class UnionBoardPage extends StatefulWidget {
  UnionBoardPage({Key key}) : super(key: key);

  @override
  _UnionBoardPageState createState() {
    return _UnionBoardPageState();
  }
}

class _UnionBoardPageState extends State<UnionBoardPage> {
  bool showProgress = false;

  getData() async {
    /*  var response = await sl<Cases>().getManagersHead();
    if (response is GetManagerHeadEntities) {
      setState(() {
        getManagerHeadEntities = response;
      });
    }  else if (response is ResponseModelFailure) {
      print(response.message);
    }  else{
      errorDialog(context);
    }*/
    var responseHead = await sl<Cases>().getManagersAccordingToDepartments();
    if (responseHead is GetManagerAccordingToDepartmentEntities) {
      setState(() {
        getManagerAccordingToDepartmentEntities = responseHead;
      });
    } else if (responseHead is ResponseModelFailure) {
      print(responseHead.message);
    } else {
      errorDialog(context);
    }
    var responseBranches = await sl<Cases>().getManagerAccordingToBranches();
    if (responseBranches is GetManagerAccordingtoBranchesEntities) {
      setState(() {
        getManagerAccordingtoBranchesEntities = responseBranches;
      });
    } else if (responseBranches is ResponseModelFailure) {
      print(responseBranches.message);
    } else {
      errorDialog(context);
    }
    var responseYear = await sl<Cases>().getManagerAccordingToYear();
    if (responseYear is GetManagerAccordingtoYearEntities) {
      setState(() {
        getManagerAccordingtoYearEntities = responseYear;
      });
    } else if (responseYear is ResponseModelFailure) {
      print(responseYear.message);
    } else {
      errorDialog(context);
    }
  }

  @override
  void initState() {
    super.initState();
    //  getData();
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
      child: Stack(
        children: [
          LiquidPullToRefresh(
            onRefresh: () async {
              setState(() {
                getManagerHeadEntities = GetManagerHeadEntities(data: List());
                getManagerAccordingToDepartmentEntities =
                    GetManagerAccordingToDepartmentEntities(data: List());
                getManagerAccordingtoBranchesEntities =
                    GetManagerAccordingtoBranchesEntities(data: List());
                getManagerAccordingtoYearEntities =
                    GetManagerAccordingtoYearEntities(data: List());
              });
            },
            backgroundColor: Colors.white,
            color: staticColor,
            child: ListView(
              children: [
                unionBoard == UnionBoard.none ||
                        unionBoard == UnionBoard.showHeaders
                    ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 50),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (unionBoard == UnionBoard.showHeaders) {
                                    setState(() {
                                      unionBoard = UnionBoard.none;
                                    });
                                  } else if (getManagerHeadEntities.status ==
                                      null) {
                                    setState(() {
                                      showProgress = true;
                                    });
                                    var response =
                                        await sl<Cases>().getManagersHead();
                                    setState(() {
                                      showProgress = false;
                                    });
                                    if (response is GetManagerHeadEntities) {
                                      setState(() {
                                        getManagerHeadEntities = response;
                                        unionBoard = UnionBoard.showHeaders;
                                        /* showHeaders = !showHeaders;
                                  if (showManagements) {
                                    showManagements = !showManagements;
                                  }
                                  if (showManagement) {
                                    showManagement = !showManagement;
                                  }
                                  if (showBranches) {
                                    showBranches = !showBranches;
                                  }*/
                                      });
                                    } else if (response
                                        is ResponseModelFailure) {
                                      print(response.message);
                                    } else {
                                      errorDialog(context);
                                    }
                                  } else {
                                    setState(() {
                                      unionBoard = UnionBoard.showHeaders;
                                      /*    showHeaders = !showHeaders;
                                if (showManagements) {
                                  showManagements = !showManagements;
                                }
                                if (showManagement) {
                                  showManagement = !showManagement;
                                }
                                if (showBranches) {
                                  showBranches = !showBranches;
                                }*/
                                    });
                                  }
                                },
                                child: TileWidget(
                                  "مجلس ادارة الإتحاد",
                                ),
                              ),
                              ...getManagerHeadEntities.data
                                  .map((e) => unionBoard ==
                                          UnionBoard.showHeaders
                                      ? Container(
                                height: 100,
                                          padding: EdgeInsets.only(left: 5),
                                          margin: EdgeInsets.all(5),
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                            Container(
                                              width: 10,
                                              color: staticColor,
                                            ),
                                              Flexible(
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5,
                                                  child: Image.network(e.thumb,fit: BoxFit.fill,),
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
                                                            "${e.title}",
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
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "${e.position}",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              30,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )
                                      : Container())
                                  .toList(),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: unionBoard == UnionBoard.none
                      ? 20
                      : 0,
                ),
                unionBoard == UnionBoard.none ||
                        unionBoard == UnionBoard.showManagement
                    ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 50),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (unionBoard == UnionBoard.showManagement) {
                                    setState(() {
                                      unionBoard = UnionBoard.none;
                                    });
                                  } else if (getManagerAccordingToDepartmentEntities
                                          .status ==
                                      null) {
                                    setState(() {
                                      showProgress = true;
                                    });
                                    var response = await sl<Cases>()
                                        .getManagersAccordingToDepartments();
                                    setState(() {
                                      showProgress = false;
                                    });
                                    if (response
                                        is GetManagerAccordingToDepartmentEntities) {
                                      setState(() {
                                        getManagerAccordingToDepartmentEntities =
                                            response;
                                        unionBoard = UnionBoard.showManagement;
                                        /*    showManagement = !showManagement;
                                  if (showManagements) {
                                    showManagements = !showManagements;
                                  }
                                  if (showHeaders) {
                                    showHeaders = !showHeaders;
                                  }
                                  if (showBranches) {
                                    showBranches = !showBranches;
                                  }*/
                                      });
                                    } else if (response
                                        is ResponseModelFailure) {
                                      print(response.message);
                                    } else {
                                      errorDialog(context);
                                    }
                                  } else {
                                    setState(() {
                                      unionBoard = UnionBoard.showManagement;
                                      /*     showManagement = !showManagement;
                                if (showManagements) {
                                  showManagements = !showManagements;
                                }
                                if (showHeaders) {
                                  showHeaders = !showHeaders;
                                }
                                if (showBranches) {
                                  showBranches = !showBranches;
                                }*/
                                    });
                                  }
                                },
                                child: TileWidget(
                                  "إدارات الإتحاد",
                                ),
                              ),
                              ...getManagerAccordingToDepartmentEntities.data
                                  .map((e) => unionBoard ==
                                          UnionBoard.showManagement
                                      ? Container(
                                         // padding: EdgeInsets.all(10),
                                color: Colors.white,
                                          height: 100,
                                          margin: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 10,
                                                color: staticColor,
                                              ),
                                              Container(
                                               // decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                                width: 100,
                                                child: Image.network(e.thumb,fit: BoxFit.fitHeight,),
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${e.title}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                27,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        "${e.position}",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              30,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )
                                      : Container())
                                  .toList(),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: unionBoard == UnionBoard.none
                      ? 20
                      : 0,
                ),
                unionBoard == UnionBoard.none ||
                        unionBoard == UnionBoard.showBranches
                    ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 50),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (unionBoard == UnionBoard.showBranches) {
                                    setState(() {
                                      unionBoard = UnionBoard.none;
                                    });
                                  } else if (getManagerAccordingtoBranchesEntities
                                          .status ==
                                      null) {
                                    setState(() {
                                      showProgress = true;
                                    });
                                    var response = await sl<Cases>()
                                        .getManagerAccordingToBranches();
                                    setState(() {
                                      showProgress = false;
                                    });
                                    if (response
                                        is GetManagerAccordingtoBranchesEntities) {
                                      setState(() {
                                        getManagerAccordingtoBranchesEntities =
                                            response;
                                        unionBoard = UnionBoard.showBranches;
                                        /*      showBranches = !showBranches;
                                  if (showManagements) {
                                    showManagements = !showManagements;
                                  }
                                  if (showHeaders) {
                                    showHeaders = !showHeaders;
                                  }
                                  if (showManagement) {
                                    showManagement = !showManagement;
                                  }*/
                                      });
                                    } else if (response
                                        is ResponseModelFailure) {
                                      print(response.message);
                                    } else {
                                      errorDialog(context);
                                    }
                                  } else {
                                    setState(() {
                                      unionBoard = UnionBoard.showBranches;
                                      /*  showBranches = !showBranches;
                                if (showManagements) {
                                  showManagements = !showManagements;
                                }
                                if (showHeaders) {
                                  showHeaders = !showHeaders;
                                }
                                if (showManagement) {
                                  showManagement = !showManagement;
                                }*/
                                    });
                                  }
                                },
                                child: TileWidget(
                                  "الفروع",
                                ),
                              ),
                              unionBoard == UnionBoard.showBranches
                                  ? Column(children: [
                                      ...getManagerAccordingtoBranchesEntities
                                          .data
                                          .map((e) => InkWell(
                                                onTap: () {
                                                  showModalBottomSheet<void>(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return SolidBottomSheet(
                                                            maxHeight: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                1.2,
                                                            minHeight: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2,
                                                            headerBar:
                                                                Container(
                                                              height: 50,
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 10,
                                                                      left: 10),
                                                              child: Text(
                                                                "${e.title}",
                                                                style: GoogleFonts.cairo(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            body: Container(
                                                              color:
                                                                  Colors.white,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            32.0),
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount: e
                                                                      .managers
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Container(
                                                                              height: MediaQuery.of(context).size.height / 5,
                                                                              child: Image.network(e.managers[index].thumb),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                              flex: 2,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                      padding: EdgeInsets.only(right: 10),
                                                                                      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                                                      child: Text(
                                                                                        "${e.managers[index].title}",
                                                                                        style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width / 27, fontWeight: FontWeight.bold),
                                                                                      )),
                                                                                  SizedBox(
                                                                                    height: 20,
                                                                                  ),
                                                                                  Text(
                                                                                    "${e.managers[index].position}",
                                                                                    style: TextStyle(
                                                                                      color: Colors.grey[700],
                                                                                      fontSize: MediaQuery.of(context).size.width / 30,
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                  ),
                                                                                  Text(
                                                                                    "",
                                                                                    style: TextStyle(color: Colors.grey),
                                                                                  ),
                                                                                ],
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ));
                                                      });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  // margin: EdgeInsets.only(right: 20),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "${e.title}",
                                                    style: GoogleFonts.cairo(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ))
                                    ])
                                  : Container(),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: unionBoard == UnionBoard.none
                      ? 20
                      : 0,
                ),
                unionBoard == UnionBoard.none ||
                        unionBoard == UnionBoard.showManagements
                    ? Directionality(
                        textDirection: TextDirection.rtl,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 50),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  if (unionBoard ==
                                      UnionBoard.showManagements) {
                                    setState(() {
                                      unionBoard = UnionBoard.none;
                                    });
                                  } else if (getManagerAccordingtoYearEntities
                                          .status ==
                                      null) {
                                    setState(() {
                                      showProgress = true;
                                    });
                                    var response = await sl<Cases>()
                                        .getManagerAccordingToYear();
                                    setState(() {
                                      showProgress = false;
                                    });
                                    if (response
                                        is GetManagerAccordingtoYearEntities) {
                                      setState(() {
                                        getManagerAccordingtoYearEntities =
                                            response;
                                        unionBoard = UnionBoard.showManagements;
                                        /*     showManagements = !showManagements;
                                  if (showManagement) {
                                    showManagement = !showManagement;
                                  }
                                  if (showHeaders) {
                                    showHeaders = !showHeaders;
                                  }
                                  if (showBranches) {
                                    showBranches = !showBranches;
                                  }*/
                                      });
                                    } else if (response
                                        is ResponseModelFailure) {
                                      print(response.message);
                                    } else {
                                      errorDialog(context);
                                    }
                                  } else {
                                    setState(() {
                                      unionBoard = UnionBoard.showManagements;
                                      /*   showManagements = !showManagements;
                                if (showManagement) {
                                  showManagement = !showManagement;
                                }
                                if (showHeaders) {
                                  showHeaders = !showHeaders;
                                }
                                if (showBranches) {
                                  showBranches = !showBranches;
                                }*/
                                    });
                                  }
                                },
                                child: TileWidget(
                                  "رؤساء الاتحاد السابقين",
                                ),
                              ),
                              unionBoard == UnionBoard.showManagements
                                  ? Column(
                                      children: [
                                        ...getManagerAccordingtoYearEntities
                                            .data
                                            .map((e) {
                                              print('eeeee:::${e.toJson()}');
                                              String thumb = "";
                                              String ttitle = "";
                                              try{
                                                thumb = e.managers?.first?.thumb ?? "";
                                                ttitle = e.managers?.first?.title??"";
                                          }catch(e){
                                                print("$e");
                                              }

                                          return Container(
                                            height: 120,
                                            child: CardWidget(
                                        imageLink: thumb,
                                            position: ttitle,
                                            dateTime: e.title,
                                        ),
                                          );
                                            }/*Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: ListTile(
                                                    onTap: () {
                                                      print(e.toJson());
                                                      showModalBottomSheet<
                                                              void>(
                                                          isScrollControlled:
                                                              true,
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return SolidBottomSheet(
                                                                maxHeight: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    1.2,
                                                                minHeight: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    2,
                                                                headerBar:
                                                                    Container(
                                                                  height: 50,
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10,
                                                                          left:
                                                                              10),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                    "${e.title}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                body: Container(
                                                                  color: Colors
                                                                      .white,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            32.0),
                                                                    child: ListView
                                                                        .builder(
                                                                      itemCount: e
                                                                          .managers
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return Container(
                                                                          padding:
                                                                              EdgeInsets.all(10),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Expanded(
                                                                                  flex: 2,
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Container(
                                                                                          padding: EdgeInsets.only(right: 10),
                                                                                          //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                                                          child: Text(
                                                                                            "${e.managers[index].title}",
                                                                                            style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width / 25, fontWeight: FontWeight.bold),
                                                                                          )),
                                                                                      SizedBox(
                                                                                        height: 20,
                                                                                      ),
                                                                                      Text(
                                                                                        "",
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey[700],
                                                                                          fontSize: MediaQuery.of(context).size.width / 30,
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Text(
                                                                                        "",
                                                                                        style: TextStyle(color: Colors.grey),
                                                                                      ),
                                                                                    ],
                                                                                  )),
                                                                              Flexible(
                                                                                flex: 2,
                                                                                child: Container(
                                                                                  height: MediaQuery.of(context).size.height / 5,
                                                                                  width: MediaQuery.of(context).size.width / 3,
                                                                                  child: Image.network(
                                                                                    e.managers[index].thumb,
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ));
                                                          });
                                                    },
                                                    leading: Container(
                                                      width: 20,
                                                      height: 50,
                                                      color: Color(0xffE31E24),
                                                    ),
                                                    title: Text(
                                                      "${e.title}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                )*/)
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          showProgress ? getLoadingContainer(context) : Container()
        ],
      ),
    );
  }
}



