import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_albums_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_albums_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_option_enities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_table.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_news_initialize_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_search_page_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_videos_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/liberary.dart';
import 'package:hi_market/basket_ball/presentation/pages/referee_sign/referee_sing_in_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/notification_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/show_home_page_video.dart';
import 'package:hi_market/basket_ball/presentation/pages/sing_up/sign_in_password_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/sing_up/sign_up.dart';
import 'package:hi_market/basket_ball/presentation/pages/sing_up/sing_in.dart';
import 'package:hi_market/basket_ball/presentation/pages/union/about_union.dart';
import 'package:hi_market/basket_ball/presentation/widgets/get_watch_web_two_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/get_watch_web_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/list_news_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/list_team_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/main_page/get_youtube_list_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/match_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/notifications/push_notificaion.dart';
import 'package:hi_market/basket_ball/presentation/widgets/show_image_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/specific_news_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/video_app.dart';
import 'package:hi_market/basket_ball/presentation/widgets/youtube_watch_widget.dart';
import 'package:hi_market/main.dart';
import 'package:hi_market/sign_with_google.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../injection.dart';
import '../../../res.dart';
import '../../../toast_utils.dart';
import 'competition/competitions.dart';
import 'complain_page.dart';
import 'last_news/last_news_page.dart';
import 'main_page_matches_page.dart';

enum MainPageShow {
  none,
  direct,
  table,
  news,
  videos,
  albums,
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  int selected = 1;
  int number = 0;
  bool showMatchProgress = false;

  MainPageShow show = MainPageShow.none;

  GetSearchPageEntities getSearchData = GetSearchPageEntities(data: []);

  TextEditingController controller = TextEditingController();

  bool showLoading = false;

  String searchData = "";
  String searchDataSuccess = "";

  bool showSearchLoading = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  getData(DateTime dateTime) async {
    if (this.mounted) {
      setState(() {
        number = 0;
        getHomePageMatchesEntities = GetHomePageMatchesEntities(data: List());
        showMatchProgress = true;
      });
    }
    var responseMatches =
        await sl<Cases>().homePageMatches(dateTime ?? DateTime.now());
    setState(() {
      showMatchProgress = false;
    });
    if (responseMatches is GetHomePageMatchesEntities) {
      setState(() {
        getHomePageMatchesEntities = responseMatches;
      });
    } else if (responseMatches is ResponseModelFailure) {
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
              messageText: Text(
                responseMatches.message,
                textAlign: TextAlign.center,
              ))
          : showToast(context, responseMatches.message);
    } else {
      errorDialog(context);
    }
    if (getHomePageOptionsEntities.data.length == 0) {
      var responseNews = await sl<Cases>().homePageOptions();
      if (responseNews is GetHomePageOptionsEntities) {
        setState(() {
          getHomePageOptionsEntities = responseNews;
        });
      } else if (responseMatches is ResponseModelFailure) {
        var platform = Theme.of(context).platform;
        platform == TargetPlatform.iOS
            ? Get.snackbar("", "",
                messageText: Text(
                  responseNews.message,
                  textAlign: TextAlign.center,
                ))
            : showToast(context, responseNews.message);
      } else {
        errorDialog(context);
      }
    }
    if (getHomePageTableEntities.data.length == 0) {
      var responseAlbums = await sl<Cases>().homePageTable();
      if (responseAlbums is GetHomePageTableEntities) {
        setState(() {
          getHomePageTableEntities = responseAlbums;
        });
      } else if (responseAlbums is ResponseModelFailure) {
        var platform = Theme.of(context).platform;
        platform == TargetPlatform.iOS
            ? Get.snackbar("", "",
                messageText: Text(
                  responseAlbums.message,
                  textAlign: TextAlign.center,
                ))
            : showToast(context, responseAlbums.message);
      } else {
        errorDialog(context);
      }
    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    getData(DateTime.now());
    // getSearchData = GetSearchPageEntities(data: []);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (sl<Cases>().getLoginData() == null) {
      sl<Cases>().setLoginData(LoginDataEntities());
    }
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  bool showSearch = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        if (showSearch) {
          setState(() {
            controller.text = "";
            getSearchData = GetSearchPageEntities(data: []);
            showSearch = !showSearch;
          });
        } else {
          MoveToBackground.moveTaskToBack();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: showSearch
            ? PreferredSize(
                preferredSize: Size.fromHeight(125.0),
                child: AppBar(
                  leading: Container(),
                  title: Text(
                    'بحث',
                  ),
                  actions: [
                    backIconAction(() {
                      setState(() {
                        showSearch = false;
                      });
                    }, color: Colors.white)
                  ],
                  flexibleSpace: Container(
                    child: Container(
                      margin: EdgeInsets.only(top: 75),
                      padding: EdgeInsets.only(right: 30, left: 30),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextField(
                          controller: controller,
                          maxLines: 1,
                          onChanged: (value) async {
                            searchData = value;
                          },
                          onSubmitted: (value) {
                            searchData = value;
                            getSearchMethod();
                          },
                          style: GoogleFonts.cairo(fontSize: 15.0),
                          decoration: getTextFieldDecoration("بحث",
                              radius: 10,
                              icon: IconButton(
                                  onPressed: () {
                                    getSearchMethod();
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ))),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : AppBar(
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
                leading: Container(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: showSearch ? 3 : 1,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
                        decoration: BoxDecoration(
                            color:
                                showSearch ? Colors.white : Color(0xffE31E24),
                            border: Border.all(color: Color(0xffE31E24)),
                            borderRadius: BorderRadius.circular(32.0)),
                        width: showSearch
                            ? MediaQuery.of(context).size.width / 1.6
                            : 0,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            controller: controller,
                            maxLines: 1,
                            onChanged: (value) async {
                              searchData = value;
                            },
                            onSubmitted: (value) {
                              searchData = value;
                              getSearchMethod();
                            },
                            style: GoogleFonts.cairo(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "البحث",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                labelStyle: GoogleFonts.cairo(
                                    fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                    ),
                    showSearch
                        ? Container()
                        : Row(
                            children: [
                              Text(
                                "الصفحة الرئيسيه",
                                style: GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 30,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                Res.mainpage,
                              )
                            ],
                          ),
                  ],
                ),
                centerTitle: true,
                actions: [
                  Flexible(
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        if (searchData == "" ||
                            searchDataSuccess == searchData) {
                          setState(() {
                            controller.text = "";
                            getSearchData = GetSearchPageEntities(data: []);
                            showSearch = !showSearch;
                          });
                        } else {
                          getSearchMethod();
                        }
                      },
                    ),
                  ),
                ],
              ),
        body: Stack(
          children: [
            !showSearch
                ? LiquidPullToRefresh(
                    onRefresh: () async {
                      getHomePageMatchesEntities =
                          GetHomePageMatchesEntities(data: List());
                      getHomePageVideosEntities =
                          GetHomePageVideosEntities(data: List());
                      getHomePageOptionsEntities =
                          GetHomePageOptionsEntities(data: List());
                      getAlbumScreenEntities =
                          GetAlbumScreenEntities(data: List());
                      getHomePageTableEntities =
                          GetHomePageTableEntities(data: List());
                      getLastNewsScreenInitializeEntities =
                          GetLastNewsScreenInitializeEntities(data: List());

                      Get.off(MyHomePage(), transition: Transition.fadeIn);
                    },
                    backgroundColor: Colors.white,
                    color: staticColor,
                    child: ListView(
                      padding: EdgeInsets.all(10),
                      children: [
                        getHomePageOptionsEntities.status == null?Container(
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: Image.asset('images/launch_icon.png').image,fit: BoxFit.contain)
                          ),
                        ):
                        getHomePageOptionsEntities.data.length == 0 &&
                                getHomePageOptionsEntities.status != null
                            ? Container(
                                height: 300,
                                alignment: Alignment.center,
                                child: Text(
                                  'لا يوجد بث مباشر',
                                  style: GoogleFonts.cairo(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Column(
                                children: [
                                  ...getHomePageOptionsEntities.data
                                      .map(
                                        (e) => e.streamLink !=
                                                    "this is the streaming link" &&
                                                e.streamLink != ""
                                            ? YoutubeListWidget(
                                                e.streamLink,
                                                showTitle: true,
                                                title: "بث مباشر",
                                                videoType: VideoType.youtube,
                                              )
                                            : Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(image: Image.asset('images/launch_icon.png').image,fit: BoxFit.contain)
                                            ),
                                        ),
                                      )
                                      .toList()
                                ],
                              ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              border: Border(
                            // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                            bottom: BorderSide(color: Colors.grey[200]),
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selected = 2;
                                      getData(DateTime.now()
                                          .add(Duration(days: 1)));
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                      bottom: BorderSide(
                                          color: selected == 2
                                              ? Colors.grey
                                              : Colors.transparent),
                                    )),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "مباريات الغد",
                                      style: GoogleFonts.cairo(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    print("selected : 1");
                                    setState(() {
                                      selected = 1;
                                      getData(DateTime.now());
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                      bottom: BorderSide(
                                          color: selected == 1
                                              ? Colors.grey
                                              : Colors.transparent),
                                    )),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "مباريات اليوم",
                                      style: GoogleFonts.cairo(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selected = 0;
                                    });
                                    getData(DateTime.now()
                                        .subtract(Duration(days: 1)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                                      bottom: BorderSide(
                                          color: selected == 0
                                              ? Colors.grey
                                              : Colors.transparent),
                                    )),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "مباريات الأمس",
                                      style: GoogleFonts.cairo(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        showMatchProgress
                            ? Container(
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: loading(),
                              )
                            : getHomePageMatchesEntities.data.length == 0
                                ? Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'لا يوجد مباريات',
                                      style: GoogleFonts.cairo(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  )
                                : Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(
                                        left: getHomePageMatchesEntities
                                                    .data.length ==
                                                1
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9
                                            : 1),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: getHomePageMatchesEntities
                                          .data.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            width: 200,
                                            height: 113,
                                            child: MatchWidget(
                                                getHomePageMatchesData:
                                                    getHomePageMatchesEntities
                                                        .data[index],
                                                text: selected == 0
                                                    ? "أمس"
                                                    : (selected == 1
                                                        ? "اليوم"
                                                        : "الغد")));
                                      },
                                    ),
                                  ),
                        SizedBox(
                          height: 10,
                        ),
                        getTileWidget(
                            showMore: getHomePageTableEntities.status != null,
                            title: "ترتيب الفرق في الدوري المصري",
                            onTap: () async {
                              if (getHomePageTableEntities.status == null) {
                                setState(() {
                                  showLoading = true;
                                });
                                var responseTable =
                                    await sl<Cases>().homePageTable();
                                setState(() {
                                  showLoading = false;
                                });
                                if (responseTable is GetHomePageTableEntities) {
                                  setState(() {
                                    getHomePageTableEntities = responseTable;
                                    show = MainPageShow.table;
                                  });
                                } else if (responseTable
                                    is ResponseModelFailure) {
                                  showToast(context, responseTable.message);
                                } else {
                                  errorDialog(context);
                                }
                              } else {
                                Move.to(
                                    context: context,
                                    page: ListTeamWidget(
                                        getHomePageTableEntities:
                                            getHomePageTableEntities));
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        getHomePageTableEntities.data.length == 0
                            ? Container()
                            : Container(
                                color: Colors.black.withOpacity(0.6),
                                padding: EdgeInsets.all(10),
                                /*  margin: EdgeInsets.only(
                                    right:
                                        MediaQuery.of(context).size.width / 20,
                                    left:
                                        MediaQuery.of(context).size.width / 20),*/
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                          "الترتيب",
                                          style: GoogleFonts.cairo(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Text("الفريق",
                                            style: GoogleFonts.cairo(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white)),
                                      ),
                                      SizedBox(),
                                      Flexible(
                                        flex: 2,
                                        child: Text("فوز",
                                            style: GoogleFonts.cairo(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white)),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Text("هزيمة",
                                            style: GoogleFonts.cairo(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white)),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Text("نقاط",
                                            style: GoogleFonts.cairo(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        /*getHomePageTableEntities.data.length == 0
                            ? Container()
                            :*/
                        Column(
                          children: [
                            ...getHomePageTableEntities.data.map(
                              (e) {
                                int i = 0;
                                for (int x = 0;
                                    x < getHomePageTableEntities.data.length;
                                    x++) {
                                  if (e.name ==
                                      getHomePageTableEntities.data[x].name) {
                                    i = x + 1;
                                  }
                                }
                                return i < 9
                                    ? Container(
                                        color: i == 1
                                            ? Color(0xffE31E24)
                                            : i % 2 == 0
                                                ? Colors.white
                                                : Colors.grey[100],
                                        padding: EdgeInsets.all(10),
                                        child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Text(
                                                    "${i}",
                                                    style: GoogleFonts.cairo(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: i == 1
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                  Text("${e.name}",
                                                      style: GoogleFonts.cairo(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: i == 1
                                                              ? Colors.white
                                                              : Colors.black)),
                                                  Text(
                                                    "${e.w}",
                                                    style: GoogleFonts.cairo(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: i == 1
                                                            ? Colors.white
                                                            : Colors.black),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    "${e.l}",
                                                    style: GoogleFonts.cairo(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: i == 1
                                                            ? Colors.white
                                                            : Colors.black),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    "${e.gp}",
                                                    style: GoogleFonts.cairo(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: i == 1
                                                            ? Colors.white
                                                            : Colors.black),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                            ).toList()
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        getTileWidget(
                            title: "أخر الأخبار",
                            showMore:
                                getLastNewsScreenInitializeEntities.status !=
                                    null,
                            onTap: () async {
                              if (getLastNewsScreenInitializeEntities.status ==
                                  null) {
                                setState(() {
                                  showLoading = true;
                                });
                                var responseTable = await sl<Cases>()
                                    .latestNewsScreenInitalization();
                                setState(() {
                                  showLoading = false;
                                });
                                if (responseTable
                                    is GetLastNewsScreenInitializeEntities) {
                                  setState(() {
                                    getLastNewsScreenInitializeEntities =
                                        responseTable;
                                    show = MainPageShow.news;
                                  });
                                } else if (responseTable
                                    is ResponseModelFailure) {
                                  showToast(context, responseTable.message);
                                } else {
                                  errorDialog(context);
                                }
                              } else {
                                Move.to(context: context, page: ListNewsPage());
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        ...getLastNewsScreenInitializeEntities.data
                            .asMap()
                            .entries
                            .map((e) => e.key > 5
                                ? Container()
                                : NewsWidget(
                                    title: e.value.title,
                                    thumb: e.value.thumb,
                                    content: e.value.contents,
                                    context: context,
                                    date: e.value.date,
                                  ))
                            .toList(),
                        SizedBox(
                          height: 10,
                        ),
                        getTileWidget(
                            title: "الفيديوهات",
                            showMore: getHomePageVideosEntities.status != null,
                            onTap: () async {
                              if (getHomePageVideosEntities.status == null) {
                                setState(() {
                                  showLoading = true;
                                });
                                var responseTable =
                                    await sl<Cases>().homePageVideos();
                                setState(() {
                                  showLoading = false;
                                });
                                if (responseTable
                                    is GetHomePageVideosEntities) {
                                  setState(() {
                                    getHomePageVideosEntities = responseTable;
                                    show = MainPageShow.news;
                                  });
                                } else if (responseTable
                                    is ResponseModelFailure) {
                                  showToast(context, responseTable.message);
                                } else {
                                  errorDialog(context);
                                }
                              } else {
                                Move.to(
                                    context: context,
                                    page: MyHomePage(
                                        getPosition: 2, chosenSelected: 1));
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        ...getHomePageVideosEntities.data.asMap().entries.map(
                          (e) {
                            print(e.value.videoType);
                            return e.key > 5
                                ? Container()
                                : Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          child: e.value.link == ""
                                              ? getNoDataWidget()
                                              : YoutubeListWidget(
                                                  e.value.link,
                                                  title: e.value.title,
                                                  videoType: e.value.videoType,
                                                  videos:
                                                      getHomePageVideosEntities
                                                          .data
                                                          .map((e) => Videos(
                                                              title: e.title,
                                                              attachmentUrl:
                                                                  e.link,
                                                              videoType:
                                                                  e.videoType))
                                                          .toList(),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10)),
                                                )),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10))),
                                        margin: EdgeInsets.only(
                                            left: 10, right: 10),
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        alignment: Alignment.center,
                                        child: getTitle("${e.value.title}",
                                            fontSize: 12),
                                      )
                                    ],
                                  );
                          },
                        ).toList(),
                        SizedBox(
                          height: 10,
                        ),
                        getTileWidget(
                            title: "ألبوم الصور",
                            showMore: getAlbumScreenEntities.status != null,
                            onTap: () => getAlbumMethod()),
                        SizedBox(
                          height: 10,
                        ),
                        ...getAlbumScreenEntities.data
                            .asMap()
                            .entries
                            .map(
                              (e) => e.key > 5
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        Move.to(
                                            context: context,
                                            page: ShowImagePage(
                                                getAlbumScreenEntities:
                                                    e.value));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 10, right: 10, left: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10)),
                                                image: DecorationImage(
                                                    image: Image.network(
                                                      e.value.albumThumb,
                                                    ).image,
                                                    fit: BoxFit.fill)),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            alignment: Alignment.topRight,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: SvgPicture.asset(
                                                      "images/images.svg",
                                                      color: Colors.white,
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${e.value.thubmsUrls.length}',
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            child: getTitle("${e.value.title}"),
                                          )
                                        ],
                                      ),
                                    ),
                            )
                            .toList(),
                      ],
                    ),
                  )
                : showSearchLoading
                    ? getLoadingContainer(context)
                    : getSearchData.data.length == 0
                        ? getNoDataWidget()
                        : ListView.builder(
                            itemCount: getSearchData?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${getSearchData.data[index].title}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () => _launchURL(
                                          getSearchData.data[index].link),
                                      child: Container(
                                        height: 40,
                                        width: 133,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: staticColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "التفاصيل",
                                          style: GoogleFonts.cairo(
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
            showLoading
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    alignment: Alignment.center,
                    child: loading(),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  void getSearchMethod() async {
    setState(() {
      showSearchLoading = true;
    });
    var response = await sl<Cases>().homePageSearch(searchData);
    setState(() {
      showSearchLoading = false;
    });
    if (response is GetSearchPageEntities) {
      setState(() {
        // getSearchData = GetSearchPageEntities();
        searchDataSuccess = searchData;
        getSearchData = response;
      });
    } else if (response is ResponseModelFailure) {
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
              messageText: Text(
                response.message,
                textAlign: TextAlign.center,
              ))
          : showToast(context, response.message);
    } else {
      errorDialog(context);
    }
  }

  getTileWidget(
      {String title, Future<Null> Function() onTap, bool showMore = false}) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: new LinearGradient(
                colors: [
                  Colors.white,
                  staticColor,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Container(
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.grey[600], width: 2)),
                      ),
                      padding: EdgeInsets.only(right: 10, left: 10),
                      margin:
                          EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                      alignment: Alignment.center,
                      child: Text(
                        showMore
                            ?'المزيد':'عرض',
                        style: GoogleFonts.cairo(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      )),
              Row(
                children: [
                  Text(
                    "$title",
                    style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 30),
                  Image.asset(
                    "images/basketiconlistimage.png",
                    scale: 2.5,
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              )
            ],
          ),
        ));
  }

  Future<dynamic> getAlbumMethod() async {
    if (getAlbumScreenEntities.status == null) {
      setState(() {
        showLoading = true;
      });
      var responseTable = await sl<Cases>().albumsScreenInitiation();
      setState(() {
        showLoading = false;
      });
      if (responseTable is GetAlbumScreenEntities) {
        setState(() {
          getAlbumScreenEntities = responseTable;
          show = MainPageShow.albums;
        });
      } else if (responseTable is ResponseModelFailure) {
        showToast(context, responseTable.message);
      } else {
        errorDialog(context);
      }
    } else {
      Move.to(
          context: context,
          page: MyHomePage(getPosition: 2, chosenSelected: 0));
    }
  }
}
