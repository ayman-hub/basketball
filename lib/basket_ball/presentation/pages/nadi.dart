
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/entities/teams_screen_initation_entities.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/nadi_widget.dart';
import 'package:hi_market/main.dart';

import '../../../injection.dart';
import '../../../res.dart';
import '../../../toast_utils.dart';
import 'main_page.dart';
bool showMainPage;
class ClubPage extends StatefulWidget {
  ClubPage({Key key}) : super(key: key);

  @override
  _ClubPageState createState() {
    return _ClubPageState();
  }
}

class _ClubPageState extends State<ClubPage> {
  showDataBoolean showAhly = showDataBoolean();

  Future futureMethod ;
int teamID = 0;
String title = "";
String logo = "";

  Future futureTeamData;


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
   // var controller = ScrollController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(Res.wightbasketimage,fit: BoxFit.fill,),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  height: MediaQuery.of(context).size.height / 10,
                  padding: EdgeInsets.only(bottom: 10),
                  child: IconButton(
                      icon: Image.asset(Res.backimage,color: Color(0xffE31E24),),
                      onPressed: () {
                      if(showAhly.showNadi){
                        setState(() {
                          showAhly.showNadi = false;
                        });
                      }else{  return Move.to(context: context, page: MyHomePage());}
                      }),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffE31E24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(
                    "الأنديه",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
               showAhly.showNadi ? Expanded(
                 flex: 6,
                 child: ListView(
                   children: [
                     NadiWidget(name: "$title", showBoolean: showAhly, teamID: teamID.toString(),logo: logo,),
                   ],
                 ),
               ):Expanded(
                 flex: 6,
                 child: FutureBuilder(future:futureMethod, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                   if (snapshot.hasError) {
                     print("snapshotError : ${snapshot.error}");
                   }
                   switch (snapshot.connectionState){
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
                       if(snapshot.data is GetTeamScreenInitiationEntities){ return getFutureData(snapshot.data);}else if (snapshot.data is ResponseModelFailure) {
                         if(snapshot.data is ResponseModelFailure){
                           ResponseModelFailure failure = snapshot.data;
                           var platform = Theme.of(context).platform;
                           platform == TargetPlatform.iOS
                               ? Get.snackbar("", "",
                               messageText: Text(
                                 failure.message,
                                 textAlign: TextAlign.center,
                               ))
                               : showToast(context,failure.message);
                           return IconButton(icon: Icon(Icons.refresh,color: Colors.white,size: 45,), onPressed:(){
                             setState(() {
                               futureMethod = sl<Cases>().teamsScreenInitiation();
                             });
                           });
                         }
                       }
                       break;
                   }
                   return Container();
                 },),
               )
              ],
            ),
          ),
        ],
      ),
    );
  }
  getFutureData(GetTeamScreenInitiationEntities getTeamScreenInitiationEntities){
    return  Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
      itemCount: getTeamScreenInitiationEntities?.data?.length??0,
        itemBuilder: (context,index){
        return Container(
         // height: MediaQuery.of(context).size.height / 15,
          child: Column(
            children: [
              InkWell(
                  onTap: (){
                    setState(() {
                      showAhly.showNadi = !showAhly.showNadi;
                      print("teamID:${getTeamScreenInitiationEntities.data[index].id}");
                      teamID = getTeamScreenInitiationEntities.data[index].id;
                      title = getTeamScreenInitiationEntities.data[index].title;
                      logo = getTeamScreenInitiationEntities.data[index].logo;
                    });
                  },
                  child: NadiWidget(name: "${getTeamScreenInitiationEntities.data[index].title}", showBoolean: showAhly, teamID: teamID.toString(),logo:getTeamScreenInitiationEntities.data[index].logo)),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
        },
      ),
    );
  }

  void getData() {
    futureMethod =  sl<Cases>().teamsScreenInitiation();
  }
}

class showDataBoolean {
  bool showNadi = false;
  bool showListPlayer = false;

  bool showDevice = false;

  bool showPlayers = false;

  bool showAtchivements = false;

  bool showAlbums = false;

  bool showVideos = false;

  showDataBoolean(
      {this.showNadi = false,
      this.showListPlayer = false,
      this.showDevice = false,
      this.showPlayers = false,
      this.showAtchivements = false,
      this.showAlbums = false,
      this.showVideos =false});
}
