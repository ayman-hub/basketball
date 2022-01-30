import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_news_initialize_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/main_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/specific_news_widget.dart';
import 'package:hi_market/main.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../injection.dart';
import '../../../res.dart';
import 'go_to.dart';

class ListNewsPage extends StatefulWidget {
  ListNewsPage({Key key}) : super(key: key);

//GetLastNewsScreenInitializeEntities getHomePageNewsEntities;
  @override
  _ListNewsPageState createState() {
    return _ListNewsPageState();
  }
}

class _ListNewsPageState extends State<ListNewsPage> {
  bool openScroll = true;

  bool showprogress = false;



  @override
  void initState() {
    super.initState();
    /*getLastNewsScreenInitializeEntities.data = [];
    getAddData();*/
    if (getLastNewsScreenInitializeEntities.data.length == 0) {
      showShowProgress = true;
      getAddData();
    } else {
      page = (getLastNewsScreenInitializeEntities.data.length);
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
            centerTitle: true,
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
            padding: EdgeInsets.all(10),
            child: NotificationListener<ScrollNotification>(
              onNotification: _getAlbumsMore,
              child: ListView(
                controller: scrollController,
                children: [
                  ...getLastNewsScreenInitializeEntities.data
                      .map((e) => NewsWidget(title:e.title,thumb:e.thumb,date:e.date,content:e.contents,id:e.id,context: context))
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
  int page = 0;
  bool showShowProgress = false;

  bool _getAlbumsMore(ScrollNotification notification) {
    if (scrollController.position.extentAfter == 0) {
      setState(() {
        showShowProgress = true;
      });
      getAddData();
    } else if (notification
            is ScrollNotification /*&&
    scrollController.position.extentAfter == 0*/
        ) {
      getAddData();
    }
  }

  ScrollController scrollController = ScrollController();

  getAddData() async {
    if (openScroll) {
      setState(() {
        if (showShowProgress) {
          showprogress = true;
        }
        openScroll = false;
        page = page + 7;
      });
      var response = await sl<Cases>().latestNewsLoadMore((page).toString());
      if (showShowProgress) {
        setState(() {
          showShowProgress = false;
          showprogress = false;
        });
      }
      if (response is GetLastNewsScreenInitializeEntities) {
        print(
            'all data:::: ${getLastNewsScreenInitializeEntities.data.length}');
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
                print('heerreerre :$page: ${response.data.length}');
                getLastNewsScreenInitializeEntities.data.add(e);
              }
            });
            lastNewsData.add(scrollController.offset);
            openScroll = true;
          } else {
            setState(() {
              openScroll = false;
            });
          }
        });
      } else if (response is ResponseModelFailure) {
        page = page - 7;
        print(response.message);
      } else {
        print("connection error");
      }
    }
  }


}
