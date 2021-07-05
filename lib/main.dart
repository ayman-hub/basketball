import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/use_cases/competition_controller.dart';
import 'package:hi_market/basket_ball/presentation/pages/main_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/notificationxx.dart';
import 'package:hi_market/res.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'basket_ball/domain/entities/get_login_data.dart';
import 'basket_ball/domain/use_cases/case.dart';
import 'basket_ball/presentation/pages/competition/competitions.dart';
import 'basket_ball/presentation/pages/liberary.dart';
import 'basket_ball/presentation/pages/nadi.dart';
import 'basket_ball/presentation/pages/sport_details/sport_details.dart';
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
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          primarySwatch: generateMaterialColor(Color(0xffE31E24)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: Colors.transparent
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,this.getPosition,this.getpage,this.chosenSelected}) : super(key: key);
int getPosition ;
int getpage;
int chosenSelected;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 int position = 4;
  double ballPositionBottom = 1.0;
  double ballPositionRight = 1.0;
  bool switchBallDirection = true;

  List<Widget> images = [
    Image.asset("images/splash_1.png",fit: BoxFit.fill,),
    Image.asset("images/splash_2.png",fit: BoxFit.fill,),
    Image.asset("images/splash_3.png",fit: BoxFit.fill,),
    Image.asset("images/splash_4.png",fit: BoxFit.fill,),
    Image.asset("images/splash_5.png",fit: BoxFit.fill,),
    Image.asset("images/splash_6.png",fit: BoxFit.fill,),
    Image.asset("images/splash_7.png",fit: BoxFit.fill,),
    Image.asset("images/splash_8.png",fit: BoxFit.fill,),
    Image.asset("images/splash_9.png",fit: BoxFit.fill,),
    Image.asset("images/splash_10.png",fit: BoxFit.fill,),
  ];

   List<Widget> _children ;
  Timer timer;
  int num ;

  int index = 0;

  int durate = 300;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _children =  [
      ClubPage(),
      LiberaryPage(chosenSelected: widget.chosenSelected??0,),
      SportDetailsPage(),
      CompetitionsPage(page: widget.getpage,),
      MainPage()
    ];
    position = widget.getPosition??4;
getNotificationToken();
getNotification(context);
if(showSplash){
      timer = Timer.periodic(Duration(milliseconds: durate - 50), (timer) {
        if (index < images.length - 1) {
          setState(() {
            index++;
          });
        } else {
          setState(() {
            showSplash = false;
          });
        }
        /* if (num == null) {
        setState(() {
          num = 1 ;
          ballPositionBottom = MediaQuery.of(context).size.height / 4;
          ballPositionRight =  MediaQuery.of(context).size.width ;
        });
      }
      setState(() {
        if (ballPositionRight >= MediaQuery.of(context).size.width /1.6) {
          ballPositionRight -=1;
        }
        if (switchBallDirection) {
          ballPositionBottom -= 0.5;
          if (ballPositionBottom <= MediaQuery.of(context).size.height /20) {
            setState(() {
              switchBallDirection = false;
            });
          }
        } else {
          ballPositionBottom += 0.5;
          if (ballPositionBottom >= MediaQuery.of(context).size.height / 4) {
            setState(() {
              switchBallDirection = true;
            });
          }
        }
      });
    });*/
        /*  Future.delayed(Duration(seconds: 2), () {
      setState(() {
         showSplash = false;
        timer.cancel();
      });
    });*/
        /*   sl<Cases>().getProductInfoFuture().then((value){
      int num = 0 ;
      value.forEach((element) {
        if (element.num != 0) {
          ++num;
        }
        countData.add(num);
      });*/
      });
    }
  }

  Widget splashScreen() {
    return Scaffold(
        body: Container(
      //decoration: BoxDecoration(border:Border.all(color:Colors.blue), color: Colors.white),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AnimatedCrossFade(
        firstCurve: Curves.easeInOut,
        secondCurve: Curves.easeInOut,
        duration: Duration(milliseconds: durate),
        crossFadeState: CrossFadeState.showFirst,
        secondChild: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: images[index < images.length - 1  ? index +1 : index]), firstChild: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: images[index])),
    ) // Image.asset(Res.splash,fit: BoxFit.fill,height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,),
        );
  }

  @override
  Widget build(BuildContext context) {
    return showSplash
        ? splashScreen()
        :Scaffold(
        backgroundColor: Colors.white,
        body: _children[position],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:Color(0xffE31E24),
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image.asset(
                  Res.nadiimage,
                  color:  Colors.white,
                  //size: snap.data == 0 ? 30 : 25,
                  scale:18,
                ),
                title: Text(
                  'الأندية',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 26),
                )),
            BottomNavigationBarItem(
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
            ),
          ],
          onTap: (int) {
                  setState(() {
                    print(int);
                    position = int;
                  });
              },
        ));
  }
}
