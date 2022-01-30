import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/use_cases/competition_controller.dart';
import 'package:hi_market/basket_ball/presentation/pages/main_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/notificationxx.dart';
import 'package:hi_market/basket_ball/presentation/widgets/specific_nadi_page.dart';
import 'package:hi_market/res.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'basket_ball/domain/entities/get_login_data.dart';
import 'basket_ball/domain/use_cases/case.dart';
import 'basket_ball/presentation/pages/competition/competitions.dart';
import 'basket_ball/presentation/pages/liberary.dart';
import 'basket_ball/presentation/pages/menu_page.dart';
import 'basket_ball/presentation/pages/nadi.dart';
import 'basket_ball/presentation/pages/sport_details/sport_details.dart';
import 'basket_ball/presentation/widgets/bar/bottom_bar.dart';
import 'basket_ball/presentation/widgets/notifications/push_notificaion.dart';
import 'generate_material_color.dart';
import 'injection.dart';

bool showNotificationBoolean = true;
bool showSplash = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => CompetitionContoller());
  // SharedPreferences.setMockInitialValues({});
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      );
    }
  }
  await init();
  print('app initialize');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Basket Ball',
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: generateMaterialColor(Color(0xffE31E24)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: Colors.transparent),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.getPosition, this.getpage, this.chosenSelected})
      : super(key: key);
  int getPosition;

  int getpage;
  int chosenSelected;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with TickerProviderStateMixin {
   AnimationController _controller;
  int position = 5;
  double ballPositionBottom = 1.0;
  double ballPositionRight = 1.0;
  bool switchBallDirection = true;


  List<Widget> _children;

  Timer timer;
  int num;

  int index = 0;

 

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _children = [
      MenuPage(),
      ClubPage(),
      LiberaryPage(
        chosenSelected: widget.chosenSelected ?? 0,
      ),
      SportDetailsPage(),
      CompetitionsPage(
        page: widget.getpage,
      ),
      MainPage(),
    ];
    position = widget.getPosition ?? 5;
    getNotificationToken();
    getNotification(context);
    _controller.addListener(() {
      if(_controller.isCompleted){
        print('completed:::::::::::');
        setState(() {
          showSplash = false;
        });
      }
    });
   /* if (showSplash) {
      Future.delayed(Duration(seconds: 3),(){
        setState(() {
          showSplash = false;
        });
      });
    }*/
  }

  Widget splashScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
      //decoration: BoxDecoration(border:Border.all(color:Colors.blue), color: Colors.white),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Lottie.asset("images/splash.json",controller: _controller,
        onLoaded: (composition) {
          // Configure the AnimationController with the duration of the
          // Lottie file and start the animation.
          _controller
            ..duration = composition.duration
            ..forward();
        },)//Image.asset("images/Final_Full_HD24fps_1.gif")
      ,
    )
        );
  }

  @override
  Widget build(BuildContext context) {
    return showSplash
        ? splashScreen()
        : WillPopScope(
            onWillPop: () async {
              print('main will pop scope');
              Move.noBack(context: context, page: MyHomePage());
              print('nothing else ');
              return false;
            },
            child: Scaffold(
                backgroundColor: (position == 5) ? Colors.white : Color(0xffc9c9c9),
                body: _children[position],
                bottomNavigationBar: FancyBottomNavigation(
                  //backgroundColor:Color(0xffE31E24),
                  //type: BottomNavigationBarType.fixed,
                  initialSelection: position,
                  barBackgroundColor: Color(0xffE31E24),
                  textColor: Colors.white,
                  borderColor: (position == 5) ? Colors.white : Color(0xffc9c9c9),
                  tabs: <TabData>[
                    TabData(
                        icon: Icon(
                          Icons.view_headline,
                          color: Colors.white,
                        ),
                        title: 'المزيد'),
                    TabData(
                        icon: Image.asset(
                          Res.nadiimage,
                          scale: 20,
                          color: Colors.white,
                        ),
                        title: 'الأندية'),
                    TabData(
                        icon: Image.asset(
                          Res.liberaryimage,
                          color: Colors.white,
                          // size: snap.data == 1 ? 30 : 25,
                          scale: 20,
                        ),
                        title: "المكتبات"),
                    TabData(
                        icon: Image.asset(
                          Res.gameimage,
                          color: Colors.white,
                          //  size: snap.data == 2 ? 30 : 25,
                          scale: 20,
                        ),
                        title: 'عناصر اللعبة'),
                    TabData(
                        icon: Image.asset(
                          Res.competitionimage,
                          color: Colors.white,
                          scale: 20,
                        ),
                        title: 'المسابقات'),
                    TabData(
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        title: 'الرئيسية'),
                    /*  BottomNavigationBarItem(
                icon: Image.asset(
                  Res.liberaryimage,
                  color: Colors.white ,
                  // size: snap.data == 1 ? 30 : 25,
                  scale: 18,
                ),
                title: Text(
                  "المكتبات",
                  style: TextStyle(
                      color:Colors.white,
                      fontSize:MediaQuery.of(context).size.width / 26),
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Res.gameimage,
                  color: Colors.white,
                  //  size: snap.data == 2 ? 30 : 25,
                  scale: 18,
                ),
                title: Text(
                  'عناصر اللعبة',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 26),
                ),
              ),
              BottomNavigationBarItem(
                icon:Image.asset(
                  Res.competitionimage,
                  color: Colors.white ,
                  scale: 18,
                ),
                title: Text(
                  'المسابقات',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 26),
                ),
              ),*/
                  ],
                  onTabChangedListener: (int) {
                    setState(() {
                      print(int);
                      position = int;
                    });
                  },
                )),
          );
  }

/*  getSelectedColor(int position) {
    setState(() {
      borderColor = (position == 4) ?Colors.white:Color(0xffc9c9c9);
    });
    //print('color ${position}');
   // return position == 4 ?Colors.white:Color(0xffc9c9c9);
  }*/

}
