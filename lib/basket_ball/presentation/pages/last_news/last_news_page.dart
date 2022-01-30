import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_news_initialize_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_viewed_more_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/TileWidget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/list_news_most_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/list_news_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/list_news_suggest_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
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
  bool showSuggested = false;

  bool showFavorite = false;

  List lastNewsData = List();
  List mostNewsData = List();

  ScrollController scrollController = ScrollController();

  bool getMoreNews = true;
  bool getLastNews = true;
  bool getSuggestedNews = true;

  bool openScroll = true;

  bool showProgress = false;
  bool showError = false;

  int pageNews = 0;

  getAddMostViewData() async {
    print(mostNewsData.toList());
    if (!mostNewsData.contains(scrollController.offset) &&
        openScroll &&
        !showProgress) {
      setState(() {
        getMoreNews = false;
      });
      openScroll = false;
      var response = await sl<Cases>()
          .loadMoreMostViewedNews(scrollController.offset.toString());
      setState(() {
        getMoreNews = true;
      });
      if (response is GetLoadMostViewedMoreNewsEntities) {
        response.data.forEach((element) {
          bool add = true;
          getLoadMostViewedMoreNewsEntities.data.forEach((e) {
            if (element.id == e.id) {
              add = false;
            }
          });
          if (add) {
            getLoadMostViewedMoreNewsEntities.data.add(element);
          }
        });
        openScroll = true;
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
    if (!lastNewsData.contains(scrollController.offset) &&
        openScroll &&
        !showProgress) {
      setState(() {
        getLastNews = false;
      });
      var response = await sl<Cases>()
          .latestNewsLoadMore((scrollController.offset).toString());
      setState(() {
        getLastNews = true;
      });
      if (response is GetLastNewsScreenInitializeEntities) {
        setState(() {
          if (response.data.length != 0) {
            bool add = true;
            response.data.forEach((e) {
              getLastNewsScreenInitializeEntities.data.forEach((element) {
                if (e.id == element.id) {
                  add = false;
                }
              });
              if (add) {
                getLastNewsScreenInitializeEntities.data.add(e);
              }
            });
            lastNewsData.add(scrollController.offset);
            openScroll = true;
          } else {
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
    if (!lastNewsData.contains(scrollController.offset) &&
        openScroll &&
        !showProgress) {
      setState(() {
        getLastNews = false;
      });
      openScroll = false;
      var response = await sl<Cases>()
          .loadMoreSuggestedNewsSuccess(scrollController.offset.toString());
      setState(() {
        getLastNews = true;
      });
      if (response is GetLoadMostViewedMoreNewsEntities) {
        if (response.data.length != 0) {
          bool add = true;
          response.data.forEach((e) {
            getLastNewsScreenInitializeEntities.data.forEach((element) {
              if (e.id == element.id) {
                add = false;
              }
            });
            if (add) {
              getSuggestedNewsEntities.data.add(e);
            }
          });
          lastNewsData.add(scrollController.offset);
          openScroll = true;
        } else {
          openScroll = false;
        }
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
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            Res.wightbasketimage,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: Container(),
            title: Text(
              "اخر الاخبار",
              style: GoogleFonts.cairo(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
            ),
            actions: [
              backIconAction(() {
                Get.back();
              })
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.only(right: 16),
            child: Container(
              child: NotificationListener<ScrollNotification>(
                onNotification: _getLastNewsboolNotification,
                child: ListView(
                  controller: scrollController,
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        child: InkWell(
                          onTap: () async {
                            Get.to(() => ListNewsPage(),
                                transition: Transition.fadeIn);
                          },
                          child: TileWidget(
                            "اخر الأخبار",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        child: InkWell(
                          onTap: () async {
                            Get.to(() => ListNewsMostPage(),
                                transition: Transition.fadeIn);
                          },
                          child: TileWidget(
                            "الأكثر مشاهدة",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        child: InkWell(
                          onTap: () async {
                            Get.to(() => ListNewsSuggestedPage(),
                                transition: Transition.fadeIn);
                            /*    if(getSuggestedNewsEntities.data.length == 0){
                            setState(() {
                              showProgress = true;
                            });
                              var responseSuggested = await sl<Cases>()
                                  .suggestedNewsScreenInitalization();
                            setState(() {
                              showProgress = false;
                            });
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
                          }*/
                          },
                          child: TileWidget(
                            "قد تنال إعجابك",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: getNavigationBar(context),
        ),
        showProgress
            ? Container(
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.2),
                child: loading(),
              )
            : Container()
      ],
    );
  }

  bool _getLastNewsboolNotification(ScrollNotification notification) {
    if (showLastNews) {
      //if(getLastNews){
      getAddData();
      // }
    } else if (showShow) {
      // if(getMoreNews){
      getAddMostViewData();
      //  }
    } else if (showFavorite) {
      //if(getSuggestedNews){
      getAddSuggestedNews();
      // }
    }
  }
}
