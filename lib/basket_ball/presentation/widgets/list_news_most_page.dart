import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_news_initialize_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_viewed_more_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/main_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/main.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../injection.dart';
import '../../../res.dart';
import 'go_to.dart';

class ListNewsMostPage extends StatefulWidget {
  ListNewsMostPage({Key key}) : super(key: key);
//GetLastNewsScreenInitializeEntities getHomePageNewsEntities;
  @override
  _ListNewsMostPageState createState() {
    return _ListNewsMostPageState();
  }
}

class _ListNewsMostPageState extends State<ListNewsMostPage> {
  bool openScroll = true;



  @override
  void initState() {
    super.initState();
    if(getLoadMostViewedMoreNewsEntities.data.length == 0){
      showShowProgress = true;
      getAddData();
    }
    else{
      page = (getLoadMostViewedMoreNewsEntities.data.length ~/ 4);
    }
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            Res.wightbasketimage,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            centerTitle: true,
            leading: Container(),
            title: Text(
              "الأكثر مشاهدة",
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
            padding: EdgeInsets.all(10),
            child: NotificationListener<ScrollNotification>(
              onNotification: _getAlbumsMore,
              child: ListView(
                controller: scrollController,
                children: [
                  ...getLoadMostViewedMoreNewsEntities.data
                      .map((e) => NewsWidget(title:e.title,thumb:e.thumb,content:e.contents,id:e.id,context: context))
                      .toList(),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: getNavigationBar(context),
        ),
        showShowProgress
            ? getLoadingContainer(context)
            : Container()
      ],
    );
  }
  List lastNewsData = List();
  bool getMoreNews = true;
int  page = 0;
bool showShowProgress = false;
  bool _getAlbumsMore(ScrollNotification notification) {
    if(scrollController.position.extentAfter == 0){
      setState(() {
        showShowProgress = true;
      });
      getAddData();
    }else if(notification is ScrollNotification /*&&
    scrollController.position.extentAfter == 0*/){
      getAddData();
    }
  }
  ScrollController scrollController = ScrollController();
  getAddData() async {
    if (openScroll) {
      setState(() {
        if(showShowProgress){
          showShowProgress = true;
        }
        openScroll = false;
        page = page + 4;
      });
      var response = await sl<Cases>()
          .loadMoreMostViewedNews((page).toString());
      if(showShowProgress){
        setState(() {
          showShowProgress = false;
        });
      }
      if (response is GetLoadMostViewedMoreNewsEntities) {
        print('all data:::: ${getLoadMostViewedMoreNewsEntities.data.length}');
        print("respose :${page} : ${response.data.length}  ${response.data.map((e) => "${e.id}")}");
        setState(() {
          if(response.data.length != 0){
            bool add = true;
            response.data.forEach((e) {
              getLoadMostViewedMoreNewsEntities.data.forEach((element) {
                if (e.id == element.id) {
                  add = false;
                }
              });
              if(add){
                print('heerreerre :$page: ${response.data.length}');
                getLoadMostViewedMoreNewsEntities.data.add(e);
              }
            });
            lastNewsData.add(scrollController.offset);
            openScroll = true;
          }else{
            setState(() {
              openScroll = false;
            });
          }
        });
      } else if (response is ResponseModelFailure) {
        print(response.message);
        page = page - 4;
      } else {
        print("connection error");
      }
    }
  }
}