
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_achievement_categories_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/TileWidget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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
bool refresh = true;
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
    return getEtihadAchievmentsCategoriesEntities.status != null && refresh ? getData(getEtihadAchievmentsCategoriesEntities): Container(
        child: FutureBuilder(
          future: getAchievements ,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              print("snapshotError : ${snapshot.error}");
              return errorContainer(
                  context, () {
                setState(() {
                  getAchievements = sl<Cases>().getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory();
                });
              });
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
                  getEtihadAchievmentsCategoriesEntities = snapshot.data;
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
                    return errorContainer(
                       context, () {
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
    return   LiquidPullToRefresh(
        onRefresh: () async {
          setState(() {
            refresh = false;
            getAchievements = sl<Cases>().getEtihadAchievementsCategoriesAndAchievementsRelateToThisCategory();
          });

        },
        backgroundColor: Colors.white,
        color: staticColor,
        child:ListView(
          children: [
           ...getEtihadAchievmentsCategoriesEntities.data.map((e) =>  Directionality(
             textDirection: TextDirection.rtl,
             child: AnimatedContainer(
               duration: Duration(milliseconds: 50),
               child: Column(
                 children: [
                   InkWell(
                     onTap: () {
                       setState(() {
                         if(showIndex != e.id){
                                    showIndex = e.id;
                                  }else{
                           showIndex = null;
                         }
                                });
                     },
                     child: TileWidget(
                       "${e.title}",
                     ),
                   //  trailing: e.id == showIndex?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
                   ),
                 e.achievements.length == 0 &&  e.id == showIndex ?getNoDataWidget(): Column(
                    children: [
                      SizedBox(height: 10,),
                      ...e.achievements.map((w) =>  e.id == showIndex ?Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(Res.basketiconlistimage,scale: 2,),
                                SizedBox(width: 10,),
                                Flexible(child: getTitle("${w.title}",textAlign: TextAlign.right))
                              ],
                            ),
                            SizedBox(height: 10,),
                            Container(
                              //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                              width:MediaQuery.of(context).size.width,
                              margin:EdgeInsets.only(right: 30),
                              child: getBody("${w.content}",color: Colors.grey),
                            )
                          ],
                        ),
                      ):Container()).toList(),
                    ],
                  )
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
