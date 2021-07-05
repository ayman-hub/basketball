
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_achievement_categories_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';

import '../../../../../injection.dart';
import '../../../../../res.dart';
import '../../../../../toast_utils.dart';

class AchievementPage extends StatefulWidget {
  AchievementPage({Key key}) : super(key: key);

  @override
  _AchievementPageState createState() {
    return _AchievementPageState();
  }
}

class _AchievementPageState extends State<AchievementPage> {
 int showIndex = 100;

  Future getAchievements;

  @override
  void initState() {
    super.initState();
    getFutureData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: FutureBuilder(
          future: getAchievements ,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              print("snapshotError : ${snapshot.error}");
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              // TODO: Handle this case.
                break;
              case ConnectionState.waiting:
                return loading();
                break;
              case ConnectionState.active:
              // TODO: Handle this case.
                break;
              case ConnectionState.done:
                if (snapshot.data is GetEtihadAchievmentsCategoriesEntities) {
                  return getData(snapshot.data);
                } else if (snapshot.data is ResponseModelFailure) {
                  if (snapshot.data is ResponseModelFailure) {
                    ResponseModelFailure failure = snapshot.data;
                    var platform = Theme.of(context).platform;
                    platform == TargetPlatform.iOS
                        ? Get.snackbar("", "",
                        messageText: Text(
                          failure.message,
                          textAlign: TextAlign.center,
                        ))
                        : showToast(context, failure.message);
                    return IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 45,
                        ),
                        onPressed: () {
                          setState(() {
                            getAchievements = sl<Cases>().getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory();
                          });
                        });
                  }
                }
                break;
            }
            return IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 45,
                ),
                onPressed: () {
                  setState(() {
                    getAchievements = sl<Cases>().getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory();
                  });
                });
          },
        ));
  }

  getData(GetEtihadAchievmentsCategoriesEntities getEtihadAchievmentsCategoriesEntities){
    return Container(
        padding: EdgeInsets.all(10),
        child:ListView(
          children: [
           ...getEtihadAchievmentsCategoriesEntities.data.map((e) =>  Directionality(
             textDirection: TextDirection.rtl,
             child: AnimatedContainer(
               duration: Duration(milliseconds: 50),
               child: Column(
                 children: [
                   ListTile(
                     onTap: () {
                       setState(() {
                         showIndex = e.id;
                       });
                     },
                     leading: Container(
                       width: 10,
                       height: 50,
                       color: Color(0xffE31E24),
                     ),
                     title: Text(
                       "${e.title}",
                       style: TextStyle(
                           color: Colors.black,
                           fontSize: 18,
                           fontWeight: FontWeight.w600),
                     ),
                     trailing: e.id == showIndex?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
                   ),
                  ...e.achievements.map((w) =>  e.id == showIndex ?Container(
                     padding: EdgeInsets.all(10),
                     child: Column(
                       children: [
                         Row(
                           // mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Image.asset(Res.basketiconlistimage),
                             SizedBox(width: 10,),
                             Text("${w.title}")
                           ],
                         ),
                         SizedBox(height: 10,),
                         Container(
                           //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                           width:MediaQuery.of(context).size.width,
                           margin:EdgeInsets.only(right: 30),
                           child: HtmlWidget("${w.content}"),
                         )
                       ],
                     ),
                   ):Container()).toList(),
                 ],
               ),
             ),
           )).toList()
          ],
        )
    );
  }

  void getFutureData() {
    getAchievements = sl<Cases>().getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory();
  }
}
