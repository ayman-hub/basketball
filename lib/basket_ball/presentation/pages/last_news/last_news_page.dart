import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_news_initialize_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_viewed_more_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/main.dart';
import 'package:http/http.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../main_page.dart';

class LastNewsPage extends StatefulWidget {
  LastNewsPage({Key key}) : super(key: key);

  @override
  _LastNewsPageState createState() {
    return _LastNewsPageState();
  }
}

class _LastNewsPageState extends State<LastNewsPage> {
  bool showLastNews = false;

  bool showShow = false;
  bool showSuggested= false;

  bool showFavorite = false;

  List lastNewsData = List();
  List mostNewsData = List();

  GetLastNewsScreenInitializeEntities getLastNewsScreenInitializeEntities =
      GetLastNewsScreenInitializeEntities(data: List());
  GetLoadMostViewedMoreNewsEntities getLoadMostViewedMoreNewsEntities =
      GetLoadMostViewedMoreNewsEntities(data: List());
  GetLoadMostViewedMoreNewsEntities getSuggestedNewsEntities =
      GetLoadMostViewedMoreNewsEntities(data: List());

  ScrollController scrollController = ScrollController();

  bool getMoreNews = true;
  bool getLastNews = true;
  bool getSuggestedNews = true;

  bool openScroll = true;

  getAddMostViewData() async {
    print(mostNewsData.toList());
    if (!mostNewsData.contains(scrollController.offset)) {
      setState(() {
        getMoreNews = false;
      });
      var response = await sl<Cases>()
          .loadMoreMostViewedNews(scrollController.offset.toString());
      setState(() {
        getMoreNews = true;
      });
      if (response is GetLoadMostViewedMoreNewsEntities) {
        if (response.data.last.id !=
            getLoadMostViewedMoreNewsEntities.data.last.id) {
          setState(() {
            mostNewsData.add(scrollController.offset);
            getLoadMostViewedMoreNewsEntities.data.addAll(response.data);
          });
        }
      } else if (response is ResponseModelFailure) {
        setState(() {
          getMoreNews = false;
        });
        print(response.message);
      } else {
        setState(() {
          getMoreNews = false;
        });
        print("connection error");
      }
    }
  }

  getAddData() async {
    if (!lastNewsData.contains(scrollController.offset)&& openScroll) {
      setState(() {
        getLastNews = false;
      });
      var response = await sl<Cases>()
          .latestNewsLoadMore(scrollController.offset.toString());
      setState(() {
        getLastNews = true;
      });
      if (response is GetLastNewsScreenInitializeEntities) {
        setState(() {
          if(response.data.length != 0){
            if (response.data.last.id != getLastNewsScreenInitializeEntities.data.last.id) {
              lastNewsData.add(scrollController.offset);
              getLastNewsScreenInitializeEntities.data.addAll(response.data);
            }else{
              openScroll = false;
            }
          }else{
            openScroll = false;
          }
        });
      } else if (response is ResponseModelFailure) {
        print(response.message);
        setState(() {
          getLastNews = false;
        });
      } else {
        setState(() {
          getLastNews = false;
        });
        print("connection error");
      }
    }
  }
  getAddSuggestedNews() async {
    setState(() {
      getLastNews = false;
    });
      var response = await sl<Cases>()
          .loadMoreSuggestedNewsSuccess(scrollController.offset.toString());
    setState(() {
      getLastNews = true;
    });
      if (response is GetLastNewsScreenInitializeEntities) {
        setState(() {
          lastNewsData.add(scrollController.offset);
          getLastNewsScreenInitializeEntities.data.addAll(response.data);
        });
      } else if (response is ResponseModelFailure) {
        print(response.message);
        setState(() {
          getLastNews = false;
        });
      } else {
        setState(() {
          getLastNews = false;
        });
        print("connection error");
      }
  }

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
            child: Container(
               child: NotificationListener<ScrollNotification>(
                  onNotification: _getLastNewsboolNotification,
                  child:ListView(
                    controller: scrollController,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).size.height / 15,
                    padding: EdgeInsets.only(bottom: 10),
                    child: IconButton(
                        icon: Image.asset(
                          Res.backimage,
                          color: Color(0xffE31E24),
                        ),
                        onPressed: () =>
                            Move.to(context: context, page: MyHomePage())),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      "اخر الاخبار",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      child: ListTile(
                        onTap: () async{
                              if(getLastNewsScreenInitializeEntities.data.length == 0 ){
                              var response = await sl<Cases>()
                                  .latestNewsScreenInitalization();
                              if (response
                                  is GetLastNewsScreenInitializeEntities) {
                                setState(() {
                                  showLastNews = !showLastNews;
                                  if (showShow) {
                                    showShow = !showShow;
                                  }
                                  if (showFavorite) {
                                    showFavorite = !showFavorite;
                                  }
                                });
                                setState(() {
                                  getLastNewsScreenInitializeEntities =
                                      response;
                                });
                              } else if (response is ResponseModelFailure) {
                                print(response.message);
                              } else {
                                print("connection error");
                              }
                            }else{
                                setState(() {
                                  showLastNews = !showLastNews;
                                  if (showShow) {
                                    showShow = !showShow;
                                  }
                                  if (showFavorite) {
                                    showFavorite = !showFavorite;
                                  }
                                });
                              }
                          },
                        leading: Container(
                          width: 20,
                          height: 50,
                          color: Color(0xffE31E24),
                        ),
                        title: Text(
                          "اخر الأخبار",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: showLastNews
                            ? Icon(Icons.keyboard_arrow_down)
                            : Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ...getLastNewsScreenInitializeEntities.data.map((e) =>   showLastNews
                      ? Directionality(
                    textDirection: TextDirection.rtl,
                        child: InkWell(
                    onTap: () {
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder:
                                (BuildContext context) {
                              return SolidBottomSheet(
                                  minHeight:
                                  MediaQuery.of(context)
                                      .size
                                      .height /
                                      1.5,
                                  maxHeight:
                                  MediaQuery.of(context)
                                      .size
                                      .height /
                                      1.2,
                                  headerBar: Container(),
                                  body: Container(
                                    color: Colors.white,
                                    padding:
                                    EdgeInsets.all(10),
                                    child: ListView(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                    icon: Image
                                                        .asset(
                                                      Res.backimage,
                                                      color:
                                                      Color(0xffE31E24),
                                                    ),
                                                    onPressed:
                                                        () =>
                                                        Navigator.pop(context)),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .height /
                                                  3,
                                              child: e
                                                  .thumb !=
                                                  null
                                                  ? Image
                                                  .network(
                                                e
                                                    .thumb,
                                                fit: BoxFit
                                                    .fill,
                                              )
                                                  : Icon(
                                                Icons
                                                    .photo,
                                                size:
                                                150,
                                                color:
                                                Colors.grey,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection:
                                              Axis.horizontal,
                                              child:
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    1.15,
                                                //  decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        flex:2,
                                                        child:
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Icon(
                                                                Icons.access_time,
                                                                size: 13,
                                                              ),
                                                              SizedBox(width: 5,),
                                                              Text(
                                                                "${e.date}",
                                                                style: TextStyle(fontSize: 10),
                                                              ),
                                                              SizedBox(width: 5,),
                                                              Text(
                                                                "التاريخ",
                                                                style: TextStyle(fontSize: 10),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                    Flexible(
                                                        child: Container(
                                                          //decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Icon(Icons
                                                                  .person_outline,
                                                                size: 13,),
                                                              Text(
                                                                "${e.author}",
                                                                style: TextStyle(
                                                                    fontSize: 10),),
                                                              SizedBox(
                                                                width: 5,),
                                                              Text(
                                                                "الأدمن",
                                                                style: TextStyle(
                                                                    fontSize: 10),),
                                                            ],),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Html(
                                              data:
                                              "${e.contents}",
                                             /* padding:
                                              EdgeInsets
                                                  .all(
                                                  8.0),*/
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                            });
                    },
                    child: Container(
                        // height: MediaQuery.of(context).size.height / 5,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                  height:
                                  MediaQuery.of(context)
                                      .size
                                      .height /
                                      4,
                                  width:
                                  MediaQuery.of(context)
                                      .size
                                      .height /
                                      4,
                                  child: e
                                      .thumb !=
                                      null
                                      ? Image.network(
                                    e
                                        .thumb,
                                  )
                                      : Icon(Icons.photo)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    // decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                            flex:2,
                                            child: Container(
                                              //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.access_time,size: 13,),
                                                    SizedBox(width: 2,),
                                                    Text(
                                                      "${e.date}",
                                                      style:
                                                      TextStyle(fontSize: 10),
                                                    ) /*,SizedBox(width: 5,),Text("التاريخ",style:TextStyle(fontSize: 10),),*/
                                                  ],
                                                ))),

                                        Flexible(child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [Icon(Icons.person_outline,size: 13,),Text("${e.author}",style:TextStyle(fontSize: 10),),],)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      height: MediaQuery.of(context).size.height / 5,
                                      child: Html(data: "${e.contents}",)),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ),
                  ),
                      ):Container()).toList(),
                  SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      child: ListTile(
                        onTap: ()async {
                          if(getLoadMostViewedMoreNewsEntities.data.length == 0){
                              var responseMost = await sl<Cases>()
                                  .mostViewedNewsScreenInitialization();
                              if (responseMost
                                  is GetLoadMostViewedMoreNewsEntities) {
                                setState(() {
                                  showShow = !showShow;
                                  if (showLastNews) {
                                    showLastNews = !showLastNews;
                                  }
                                  if (showFavorite) {
                                    showFavorite = !showFavorite;
                                  }
                                });
                                setState(() {
                                  getLoadMostViewedMoreNewsEntities =
                                      responseMost;
                                });
                              } else if (responseMost is ResponseModelFailure) {
                                print(responseMost.message);
                              }
                            }else{
                            setState(() {
                              showShow = !showShow;
                              if (showLastNews) {
                                showLastNews = !showLastNews;
                              }
                              if (showFavorite) {
                                showFavorite = !showFavorite;
                              }
                            });
                          }
                          },
                        leading: Container(
                          width: 20,
                          height: 50,
                          color: Color(0xffE31E24),
                        ),
                        title: Text(
                          "الأكثر مشاهدة",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: showShow
                            ? Icon(Icons.keyboard_arrow_down)
                            : Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  ...getLoadMostViewedMoreNewsEntities.data.map((e) {
                    print("most view: ${e.toJson()}");
                    return showShow
                      ?Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context)
                                .size
                                .height /
                                3,
                            child: e
                                .thumb !=
                                null
                                ? Image.network(
                                e
                                    .thumb)
                                : Icon(Icons.photo)),
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                              "${e.title}"),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            "${e.contents}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ):Container();
                  }).toList(),
                  SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      child: ListTile(
                        onTap: () async{
                          if(getSuggestedNewsEntities.data.length == 0){
                              var responseSuggested = await sl<Cases>()
                                  .suggestedNewsScreenInitalization();
                              if (responseSuggested
                                  is GetLoadMostViewedMoreNewsEntities) {
                                setState(() {
                                  showFavorite = !showFavorite;
                                  if (showLastNews) {
                                    showLastNews = !showLastNews;
                                  }
                                  if (showShow) {
                                    showShow = !showShow;
                                  }
                                });
                                setState(() {
                                  getSuggestedNewsEntities = responseSuggested;
                                });
                              } else if (responseSuggested
                                  is ResponseModelFailure) {
                                print(responseSuggested.message);
                              }
                            }else{
                            setState(() {
                              showFavorite = !showFavorite;
                              if (showLastNews) {
                                showLastNews = !showLastNews;
                              }
                              if (showShow) {
                                showShow = !showShow;
                              }
                            });
                          }
                          },
                        leading: Container(
                          width: 20,
                          height: 50,
                          color: Color(0xffE31E24),
                        ),
                        title: Text(
                          "قد تنال إعجابك",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: showFavorite
                            ? Icon(Icons.keyboard_arrow_down)
                            : Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
SizedBox(height: 10,),   ...getSuggestedNewsEntities.data.map((e) =>  showFavorite
                      ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            height: MediaQuery.of(context)
                                .size
                                .height /
                                3,
                            child: e
                                .thumb !=
                                null
                                ? Image.network(
                                e
                                    .thumb)
                                : Icon(Icons.photo)),
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                              "${e .title}",textAlign: TextAlign.center,),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Html(
                            data:"${e.contents}",
                          ),
                        ),
                      ],
                    ),
                  ):Container()).toList(),
                ],
              ),
            ),
          ),
          )],
      ),
      bottomNavigationBar: getNavigationBar(context),
    );
  }

  bool _getLastNewsboolNotification(ScrollNotification notification) {
 if(showLastNews){
   if(getLastNews){
     getAddData();
   }
 }else if(showShow){
   if(getMoreNews){
     getAddMostViewData();
   }
 }else if(showFavorite){
   if(getSuggestedNews){
     getAddSuggestedNews();
   }
 }
  }
}
