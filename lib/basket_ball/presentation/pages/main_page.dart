import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_albums_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_option_enities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_table.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_search_page_entities.dart';
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
import 'package:hi_market/basket_ball/presentation/widgets/match_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/notifications/push_notificaion.dart';
import 'package:hi_market/basket_ball/presentation/widgets/video_app.dart';
import 'package:hi_market/basket_ball/presentation/widgets/youtube_watch_widget.dart';
import 'package:hi_market/main.dart';
import 'package:hi_market/sign_with_google.dart';
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

  GetHomePageMatchesEntities getHomePageMatchesEntities =
      GetHomePageMatchesEntities(data: List());
  GetHomePageVideosEntities getHomePageVideosEntities =
      GetHomePageVideosEntities(data: List());
  GetHomePageOptionsEntities getHomePageOptionsEntities =
      GetHomePageOptionsEntities(data: List());
  GetHomePageAlbumsEntities getHomePageAlbumsEntities =
      GetHomePageAlbumsEntities(data: List());
  GetHomePageNewsEntities getHomePageNewsEntities =
      GetHomePageNewsEntities(data: List());
  GetHomePageTableEntities getHomePageTableEntities =
      GetHomePageTableEntities(data: List());

  GetSearchPageEntities getSearchData;

  TextEditingController controller = TextEditingController();

  bool showLoading = false;

  getData(DateTime dateTime) async {
    setState(() {
      number = 0;
      getHomePageMatchesEntities = GetHomePageMatchesEntities(data: List());
      showMatchProgress = true;
    });
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
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
              messageText: Text(
                "Connection Error",
                textAlign: TextAlign.center,
              ))
          : showToast(context, "Connection Error");
    }
  /*  var responseNews = await sl<Cases>().homePageNews();
    if (responseNews is GetHomePageNewsEntities) {
      setState(() {
        getHomePageNewsEntities = responseNews;
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
    }
    *//*else {
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
              messageText: Text(
                "Connection Error",
                textAlign: TextAlign.center,
              ))
          : showToast(context, "Connection Error");
    }*//*
    var responseAlbums = await sl<Cases>().homePageAlbums();
    if (responseAlbums is GetHomePageAlbumsEntities) {
      setState(() {
        getHomePageAlbumsEntities = responseAlbums;
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
    }*/
    /*else {
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
              messageText: Text(
                "Connection Error",
                textAlign: TextAlign.center,
              ))
          : showToast(context, "Connection Error");
    }*/
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
        if (!_drawerKey.currentState.isDrawerOpen) {
          MoveToBackground.moveTaskToBack();
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        key: _drawerKey,
        backgroundColor: Colors.white,
        drawerScrimColor: Colors.transparent,
        drawer: Container(
          child: Drawer(
            elevation: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      Res.wightballimage,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    /* padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 10),*/
                    child: ListView(
                      children: [
                        DrawerHeader(
                            child: Container(
                          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                          /* height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.height / 4,*/
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 90, right: 90, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                //border:Border.all(color:Colors.black),
                                //borderRadius: BorderRadius.circular(20),
                                // color: Colors.white
                                ),
                            child: Image.asset("images/sideMenuLogo.png"),
                          )
                          /*CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person_outline,
                              size: 50,
                              color: Colors.grey,
                            ),
                          )*/
                          ,
                        )),
                        /*  sl<Cases>().getLoginData().data == null
                            ? InkWell(
                                onTap: () {
                                  Move.to(context: context, page: SignInPage());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "إنشاء حساب جديد",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              )
                            : Container(),*/
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              "الرئيسية",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              Move.to(context: context, page: AboutUnionPage()),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              "عن الإتحاد",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              Move.to(context: context, page: LastNewsPage()),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Text(
                              "آخر الأخبار",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              Move.to(context: context, page: ComplainPage()),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Text(
                              "تواصل معنا",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (sl<Cases>().getLoginData() != null &&
                                sl<Cases>().getUserPassword() != null) {
                              if ("Judge" ==
                                      sl<Cases>()
                                          .getLoginData()
                                          ?.data
                                          ?.userRole ??
                                  "") {
                                ProgressDialog dialog = ProgressDialog(context);
                                dialog.show();
                                var response = await sl<Cases>().login(
                                    email:
                                        sl<Cases>().getUserPassword().userName,
                                    password:
                                        sl<Cases>().getUserPassword().password);
                                dialog.hide();
                                if (response is LoginDataEntities) {
                                  sl<Cases>().setLoginData(response);
                                  Move.to(
                                      context: context,
                                      page: RefereeMainPage());
                                }
                              } else {
                                Move.to(
                                    context: context,
                                    page: RefereeSignINPage());
                              }
                            } else {
                              Move.to(
                                  context: context, page: RefereeSignINPage());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Text(
                              "الحكام",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        sl<Cases>().getLoginData().data != null
                            ? InkWell(
                                onTap: () async {
                                  Move.to(
                                      context: context,
                                      page: ChangePasswordPage());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "تغيير كلمة السر",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              )
                            : Container(),
                        sl<Cases>().getLoginData().data != null
                            ? InkWell(
                                onTap: () async {
                                  ProgressDialog dialog = ProgressDialog(context);
                                  dialog.show();
                                  LoginDataEntities response = sl<Cases>().getLoginData();
                                  var responseNo = await sl<Cases>().pushNotification(response,true);
                                  print("Push Notification : $responseNo");
                                  dialog.hide();
                                  print("responseNo: $responseNo");
                                  if(responseNo is bool){
                                    sl<Cases>().setLoginData(LoginDataEntities());
                                    sl<Cases>().putNotification(false);
                                    sl<Cases>().setNotificationIdSharedPreference(List<String>.empty(growable: true));
                                    Navigator.pop(context);
                                    Move.to(context: context, page: MyHomePage());
                                  }else if(responseNo is ResponseModelFailure){
                                    showToast(context, responseNo.message);
                                  }else{
                                    showToast(context, "حدث خطأ من فضلك حاول مره أخرى");
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "الخروج",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              )
                            : Container(),
                        sl<Cases>().getLoginData().data == null
                            ? SizedBox(
                                height: 30,
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  _launchURL("https://twitter.com/EBBFED");
                                },
                                child: Image.asset(
                                  Res.twitter,
                                  scale: 4,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  _launchURL(
                                      "https://www.instagram.com/egy_basketball_federation/");
                                },
                                child: Image.asset(
                                  Res.instgram,
                                  scale: 4,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  _launchURL("https://www.facebook.com/EBBFED");
                                },
                                child: Image.asset(
                                  Res.facebook,
                                  scale: 4,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  _launchURL("https://www.youtube.com/channel/UC3KafxSC7-CyXsFvmzvnpoQ");
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: EdgeInsets.only(top: 15,bottom: 15,right: 10,left: 10),
                                  color: Colors.white,
                                  child: Image.asset(
                                    Res.youtube_image,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              "images/Menu.png",
              color: Colors.white,
              scale: 4,
            ),
            onPressed: () {
              _drawerKey.currentState.openDrawer();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      controller.text = "";
                      getSearchData = null;
                      showSearch = !showSearch;
                    });
                  },
                ),
              ),
              Flexible(
                flex: showSearch ? 3 : 1,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 50),
                  decoration: BoxDecoration(
                      color: showSearch ? Colors.white : Color(0xffE31E24),
                      border: Border.all(color: Color(0xffE31E24)),
                      borderRadius: BorderRadius.circular(32.0)),
                  width:
                      showSearch ? MediaQuery.of(context).size.width / 1.6 : 0,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: controller,
                      maxLines: 1,
                      onChanged: (value) async {
                        var response = await sl<Cases>().homePageSearch(value);
                        if (response is GetSearchPageEntities) {
                          setState(() {
                            getSearchData = GetSearchPageEntities();
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
                          var platform = Theme.of(context).platform;
                          platform == TargetPlatform.iOS
                              ? Get.snackbar("", "",
                                  messageText: Text(
                                    "Connection Error",
                                    textAlign: TextAlign.center,
                                  ))
                              : showToast(context, "Connection Error");
                        }
                      },
                      style: TextStyle(fontSize: 15.0),
                      decoration: InputDecoration(
                          hintText: "البحث",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          labelStyle: TextStyle(fontWeight: FontWeight.w700)),
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
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width / 30,
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
        ),
        body: Stack(
          children: [
            getSearchData == null
                ? ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10,
                            right: MediaQuery.of(context).size.width / 10,
                            top: MediaQuery.of(context).size.width / 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selected = 2;
                                    getData(DateTime.now().add(Duration(days: 1)));
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: selected == 2
                                        ? BorderRadius.circular(10)
                                        : BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                    color: selected == 2
                                        ? Color(0xffE31E24)
                                        : Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "الغد",
                                    style: TextStyle(
                                        color: selected == 2
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width / 20,
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
                                      color: selected == 1
                                          ? Color(0xffE31E24)
                                          : Colors.white,
                                      borderRadius: selected == 1
                                          ? BorderRadius.circular(10)
                                          : BorderRadius.circular(0)),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "اليوم",
                                    style: TextStyle(
                                        color: selected == 1
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width / 20,
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
                                  getData(
                                      DateTime.now().subtract(Duration(days: 1)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: selected == 0
                                        ? BorderRadius.circular(10)
                                        : BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                    color: selected == 0
                                        ? Color(0xffE31E24)
                                        : Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "أمس",
                                    style: TextStyle(
                                        color: selected == 0
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width / 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*Stack(
                    children: [
                      selected == 0 ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffE31E24),
                        ),
                        width: MediaQuery.of(context).size.width / 3.8,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "أمس",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width/20,
                              fontWeight: FontWeight.w600),
                        ),
                      ):(selected == 1 ?Positioned(
                        left: MediaQuery.of(context).size.width / 3.3,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.8,
                          //margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3.8,left: MediaQuery.of(context).size.width / 3.8 ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xffE31E24),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "اليوم",
                            style: TextStyle(
                                color:Colors.white,
                                fontSize: MediaQuery.of(context).size.width/20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ):Positioned(
                        left: MediaQuery.of(context).size.width / 1.85,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:Color(0xffE31E24),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "الغد",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width/20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )),
                    ],
                  ),*/
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: TextButton.icon(
                                onPressed: () => Move.to(
                                    context: context, page: MainPageMatchesPage()),
                                icon: Icon(Icons.keyboard_arrow_down),
                                label: Text(
                                  'كل المباريات',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 6,
                            ),
                            Flexible(
                              child: TextButton.icon(
                                onPressed: () => Move.to(
                                    context: context,
                                    page: MyHomePage(
                                      getPosition: 3,
                                    )),
                                icon: Icon(Icons.keyboard_arrow_down),
                                label: Text(
                                  'كل المسابقات',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      showMatchProgress ?Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: loading(),
                      ):Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left: getHomePageMatchesEntities.data.length == 1
                                ? MediaQuery.of(context).size.width / 9
                                : 1),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: getHomePageMatchesEntities.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: MatchWidget(
                                    getHomePageMatchesData:
                                        getHomePageMatchesEntities.data[index],
                                    text: selected == 0
                                        ? "أمس"
                                        : (selected == 1 ? "اليوم" : "الغد")));
                          },
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          if (show != MainPageShow.direct) {
                            if (getHomePageOptionsEntities.status == null) {
                              setState(() {
                                showLoading =true;
                              });
                              var responseOptions =
                                  await sl<Cases>().homePageOptions();
                              setState(() {
                                showLoading =false;
                              });
                              if (responseOptions is GetHomePageOptionsEntities) {
                               // dialog.hide();
                                setState(() {
                                  getHomePageOptionsEntities = responseOptions;
                                  show = MainPageShow.direct;
                                });
                              } else if (responseOptions
                                  is ResponseModelFailure) {
                              //  dialog.hide();
                                showToast(context, responseOptions.message);
                              } else {
                                showToast(context, "connection error");
                              }
                            } else {
                              setState(() {
                                show = MainPageShow.direct;
                              });
                            }
                          } else {
                            setState(() {
                              show = MainPageShow.direct;
                            });
                          }
                        },
                        leading: show == MainPageShow.direct
                            ? Icon(Icons.keyboard_arrow_down)
                            : Icon(Icons.arrow_back_ios),
                        trailing: Container(
                          width: 10,
                          height: 50,
                          color: Color(0xffE31E24),
                        ),
                        title: Text(
                          "بث مباشر",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      /*show != MainPageShow.direct
                          ? Container()
                          :*/ Column(
                              children: [
                                ...getHomePageOptionsEntities.data
                                    .map(
                                      (e) => e.streamLink !=
                                                  "this is the streaming link" &&
                                              e.streamLink != ""
                                          ? Container(
                                              padding: EdgeInsets.all(10),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20),
                                              child: GetWatchWebWidget(e.streamLink),
                                            )
                                          : Container(),
                                    )
                                    .toList()
                              ],
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () async {
                          if (show != MainPageShow.table) {
                            if (getHomePageTableEntities.status == null) {
                              setState(() {
                                showLoading =true;
                              });
                              var responseTable = await sl<Cases>().homePageTable();
                              setState(() {
                                showLoading =false;
                              });
                              if (responseTable is GetHomePageTableEntities) {
                                setState(() {
                                  getHomePageTableEntities = responseTable;
                                  show = MainPageShow.table;
                                });
                              } else if (responseTable is ResponseModelFailure) {
                                showToast(context, responseTable.message);
                              } else {
                                showToast(context, "connection error");
                              }
                            } else {
                              setState(() {
                                show = MainPageShow.table;
                              });
                            }
                          } else {
                            setState(() {
                              show = MainPageShow.table;
                            });
                          }
                        },
                        trailing: Container(
                          width: 10,
                          height: 50,
                          color: Color(0xffE31E24),
                        ),
                        leading: show != MainPageShow.table
                            ? Icon(Icons.arrow_back_ios)
                            : InkWell(
                                onTap: () {
                                  Move.to(
                                      context: context,
                                      page: ListTeamWidget(
                                          getHomePageTableEntities:
                                              getHomePageTableEntities));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: staticColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  alignment: Alignment.center,
                                  width: 80,
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, right: 10, left: 10),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "المزيد",
                                          style:
                                              GoogleFonts.cairo(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        title: Text(
                          "ترتيب الفرق في الدوري المصري",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "ممتاز رجال",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      show != MainPageShow.table
                          ? Container()
                          : Container(
                              color: Colors.grey[200],
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.width / 20,
                                  left: MediaQuery.of(context).size.width / 20),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Text(
                                        "الترتيب",
                                        style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(context).size.width /
                                                    20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Text("الفريق",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                    ),
                                    SizedBox(),
                                    Flexible(
                                      flex: 2,
                                      child: Text("فوز",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Text("هزيمة",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Text("نقاط",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      /*show != MainPageShow.table
                          ? Container()
                          :*/ Column(
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
                                            margin: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    20),
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Table(
                                                children: [
                                                  TableRow(
                                                    children: [
                                                      Text(
                                                        "${i}",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black),
                                                      ),
                                                      Text("${e.name}",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              color: Colors.black)),
                                                      Text(
                                                        "${e.w}",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                      Text(
                                                        "${e.l}",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black),
                                                        textAlign: TextAlign.left,
                                                      ),
                                                      Text(
                                                        "${e.gb}",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black),
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
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          onTap: ()async{
                            if (show != MainPageShow.news) {
                              if (getHomePageNewsEntities.status == null) {
                                setState(() {
                                  showLoading =true;
                                });
                                var responseTable = await sl<Cases>().homePageNews();
                                setState(() {
                                  showLoading =false;
                                });
                                if (responseTable is GetHomePageNewsEntities) {
                                  setState(() {
                                    getHomePageNewsEntities = responseTable;
                                    show = MainPageShow.news;
                                  });
                                } else if (responseTable is ResponseModelFailure) {
                                  showToast(context, responseTable.message);
                                } else {
                                  showToast(context, "connection error");
                                }
                              } else {
                                setState(() {
                                  show = MainPageShow.news;
                                });
                              }
                            } else {
                              setState(() {
                                show = MainPageShow.news;
                              });
                            }
                          },
                          leading: Container(
                            width: 10,
                            height: 50,
                            color: Color(0xffE31E24),
                          ),
                          trailing: getHomePageNewsEntities.status == null
                              ? Icon(Icons.arrow_forward_ios)
                              : InkWell(
                            onTap: () {
                              Move.to(
                                  context: context,
                                  page: ListNewsPage(
                                      getHomePageNewsEntities:
                                          getHomePageNewsEntities));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: staticColor,
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              width: 80,
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, right: 10, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "المزيد",
                                    style: GoogleFonts.cairo(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          title: Text(
                            "أخر الأخبار",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          /*trailing: Container(
                      padding: EdgeInsets.all(10),
                      color: Color(0xffE31E24),
                      child: Text(
                        'المزيد',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),*/
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ...getHomePageNewsEntities.data
                          .map((e) => Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        height:
                                            MediaQuery.of(context).size.height / 3,
                                        child: e.thumb != null
                                            ? Image.network(e.thumb)
                                            : Icon(Icons.photo)),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: HtmlWidget(
                                        "${e.title}",
                                        //textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: HtmlWidget(
                                        "${e.excerpt}",
                                        //textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      SizedBox(
                        height: 10,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          onTap: ()async{
                            if (show != MainPageShow.videos) {
                              if (getHomePageVideosEntities.status == null) {
                                setState(() {
                                  showLoading =true;
                                });
                                var responseTable = await sl<Cases>().homePageVideos();
                                setState(() {
                                  showLoading =false;
                                });
                                if (responseTable is GetHomePageVideosEntities) {
                                  setState(() {
                                    getHomePageVideosEntities = responseTable;
                                    show = MainPageShow.news;
                                  });
                                } else if (responseTable is ResponseModelFailure) {
                                  showToast(context, responseTable.message);
                                } else {
                                  showToast(context, "connection error");
                                }
                              } else {
                                setState(() {
                                  show = MainPageShow.videos;
                                });
                              }
                            } else {
                              setState(() {
                                show = MainPageShow.videos;
                              });
                            }
                          },
                          leading: Container(
                            width: 10,
                            height: 50,
                            color: Color(0xffE31E24),
                          ),
                          trailing: getHomePageVideosEntities.status == null
                              ? Icon(Icons.arrow_forward_ios)
                              :InkWell(
                            onTap: () {
                              Move.to(
                                  context: context,
                                  page: MyHomePage(
                                      getPosition: 1, chosenSelected: 1));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: staticColor,
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              width: 80,
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, right: 10, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "المزيد",
                                    style: GoogleFonts.cairo(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          title: Text(
                            "الفيديوهات",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          /* trailing: Container(
                      padding: EdgeInsets.all(10),
                      color: Color(0xffE31E24),
                      child: Text(
                        'المزيد',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),*/
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ...getHomePageVideosEntities.data
                          .map(
                            (e) {
                              print(e.videoType);
                              return Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height / 3,
                                    child:e.videoType == VideoType.youtube?InkWell(
                              onTap: (){
                              print("pressed");
                              Get.to(YoutubeWatchPage(url: e.link),transition: Transition.fadeIn);
                              },
                              child: Image.network(youTubeImage(e.link)))/*GetWatchWebWidget(e.attachmentUrl)*/:ChewieListItem(videoPlayerController:VideoPlayerController.network(e.link))),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text("${e.title}"),
                                )
                              ],
                            );
                            },
                          )
                          .toList(),
                      SizedBox(
                        height: 10,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          onTap: ()async{
                            if (show != MainPageShow.albums) {
                              if (getHomePageAlbumsEntities.status == null) {
                               setState(() {
                                 showLoading =true;
                               });
                                var responseTable = await sl<Cases>().homePageAlbums();
                               setState(() {
                                 showLoading =false;
                               });
                                if (responseTable is GetHomePageAlbumsEntities) {
                                  setState(() {
                                    getHomePageAlbumsEntities = responseTable;
                                    show = MainPageShow.albums;
                                  });
                                } else if (responseTable is ResponseModelFailure) {
                                  showToast(context, responseTable.message);
                                } else {
                                  showToast(context, "connection error");
                                }
                              } else {
                                setState(() {
                                  show = MainPageShow.albums;
                                });
                              }
                            } else {
                              setState(() {
                                show = MainPageShow.albums;
                              });
                            }
                          },
                          leading: Container(
                            width: 10,
                            height: 50,
                            color: Color(0xffE31E24),
                          ),
                          trailing:  getHomePageAlbumsEntities.status == null
                              ? Icon(Icons.arrow_forward_ios)
                              :InkWell(
                            onTap: () {
                              Move.to(
                                  context: context,
                                  page: MyHomePage(
                                      getPosition: 1, chosenSelected: 0));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: staticColor,
                                  borderRadius: BorderRadius.circular(5)),
                              alignment: Alignment.center,
                              width: 80,
                              padding: EdgeInsets.only(
                                  top: 5, bottom: 5, right: 10, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "المزيد",
                                    style: GoogleFonts.cairo(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          title: Text(
                            "ألبوم الصور",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          /* trailing: Container(
                      padding: EdgeInsets.all(10),
                      color: Color(0xffE31E24),
                      child: Text(
                        'المزيد',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),*/
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ...getHomePageAlbumsEntities.data
                          .map(
                            (e) => Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height / 3,
                                    child: Image.network(
                                      e.link,
                                      fit: BoxFit.fill,
                                    )),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: HtmlWidget("${e.title}"),
                                )
                              ],
                            ),
                          )
                          .toList(),
                    ],
                  )
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
                              onTap: () =>
                                  _launchURL(getSearchData.data[index].link),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "${getSearchData.data[index].link}",
                                  style: TextStyle(color: Colors.blue[800]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            showLoading?Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ):Container()
          ],
        ),
      ),
    );
  }
}
