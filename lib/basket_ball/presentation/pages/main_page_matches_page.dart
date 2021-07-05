
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/match_widget.dart';
import 'package:hi_market/main.dart';

import '../../../injection.dart';
import '../../../res.dart';
import '../../../toast_utils.dart';
import 'main_page.dart';

class MainPageMatchesPage extends StatefulWidget {
  MainPageMatchesPage({Key key}) : super(key: key);

  @override
  _MainPageMatchesPageState createState() {
    return _MainPageMatchesPageState();
  }
}

class _MainPageMatchesPageState extends State<MainPageMatchesPage> {
  GetHomePageMatchesEntities getHomePageMatchesEntitiesToday =
  GetHomePageMatchesEntities(data: List());
  GetHomePageMatchesEntities getHomePageMatchesEntitiesTomorrow =
  GetHomePageMatchesEntities(data: List());
  GetHomePageMatchesEntities getHomePageMatchesEntitiesYesterday =
  GetHomePageMatchesEntities(data: List());
  getData() async {
    var responseMatches =
    await sl<Cases>().homePageMatches(DateTime.now());
    if (responseMatches is GetHomePageMatchesEntities) {
      setState(() {
        //getHomePageMatchesEntitiesToday = GetHomePageMatchesEntities(data: List());
        getHomePageMatchesEntitiesToday = responseMatches;
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
    var responseMatchesTomorrow =
    await sl<Cases>().homePageMatches(DateTime.now().add(Duration(days: 1)));
    if (responseMatchesTomorrow is GetHomePageMatchesEntities) {
      setState(() {
        //getHomePageMatchesEntitiesToday = GetHomePageMatchesEntities(data: List());
        getHomePageMatchesEntitiesTomorrow = responseMatchesTomorrow;
      });
    }
    var responseMatchesYesterday =
    await sl<Cases>().homePageMatches(DateTime.now().subtract(Duration(days: 1)));
    if (responseMatchesYesterday is GetHomePageMatchesEntities) {
      setState(() {
        //getHomePageMatchesEntitiesToday = GetHomePageMatchesEntities(data: List());
        getHomePageMatchesEntitiesYesterday = responseMatchesYesterday;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getData();
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
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(Res.wightbasketimage,fit: BoxFit.fill,),
            ),
            ListView(
              children: [
                Row(children: [
                  IconButton(icon: Image.asset(Res.backimage,color: Colors.red,), onPressed: () { Move.to(context: context, page: MyHomePage()); },)
                ],),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "الأمس ${DateTime.now().subtract(Duration(days: 1)).year}-${DateTime.now().subtract(Duration(days: 1)).month}-${DateTime.now().subtract(Duration(days: 1)).day}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 20,
                        height: 50,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ...getHomePageMatchesEntitiesYesterday.data.map((e) => Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: MatchWidget(
                      getHomePageMatchesData: e,
                      text: "الأمس",
                    ))).toList(),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "اليوم ${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 20,
                        height: 50,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ...getHomePageMatchesEntitiesToday.data.map((e) => Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: MatchWidget(
                      getHomePageMatchesData: e,
                      text: "اليوم",
                    ))).toList(),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "غداً ${DateTime.now().add(Duration(days: 1)).year}-${DateTime.now().add(Duration(days: 1)).month}-${DateTime.now().add(Duration(days: 1)).day}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 20,
                        height: 50,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ...getHomePageMatchesEntitiesTomorrow.data.map((e) => Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: MatchWidget(
                      getHomePageMatchesData: e,
                      text: "غدا",
                    ))).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}