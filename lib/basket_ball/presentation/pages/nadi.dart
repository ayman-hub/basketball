
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/entities/teams_screen_initation_entities.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/nadi_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/specific_nadi_page.dart';
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
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(Res.wightbasketimage,fit: BoxFit.fill,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            centerTitle: true,
            leading: Container(),
            title: Text(
              "الأنديه",
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
          body: Container(
          //  padding: EdgeInsets.all(10),
            child: getTeamScreenInitiationEntities.data.length != 0?getFutureData(getTeamScreenInitiationEntities) :FutureBuilder(future:futureMethod, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                  if(snapshot.data is GetTeamScreenInitiationEntities){
                    getTeamScreenInitiationEntities = snapshot.data;
                    return getFutureData(snapshot.data);
                  }else if (snapshot.data is ResponseModelFailure) {
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
                      return errorContainer(context,(){
                        setState(() {
                          futureMethod = sl<Cases>().teamsScreenInitiation();
                        });
                      });
                    }
                  }
                  break;
              }
              return Container(
                alignment: Alignment.center,
                child: errorContainer(context, (){
                  getData();
                }),
              );
            },),
          ),
        ),
      ],
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
                    print("${getTeamScreenInitiationEntities.data[index].title}");
                    Get.to(SpecificNadiPage(name: "${getTeamScreenInitiationEntities.data[index].title}", showAhly: showAhly, teamID: getTeamScreenInitiationEntities.data[index].id.toString(),logo:getTeamScreenInitiationEntities.data[index].logo),transition: Transition.fadeIn);
                  },
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: getTeamScreenInitiationEntities.data[index].logo != null ?Container(
                        width: 50,
                        child: Image.network(getTeamScreenInitiationEntities.data[index].logo),
                      ):Container(
                        height: 50,
                        width: 10,
                        color: Colors.red,
                      ),
                      title: Text(
                        "${getTeamScreenInitiationEntities.data[index].title}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
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
   setState(() {
     futureMethod =  sl<Cases>().teamsScreenInitiation();
   });
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
