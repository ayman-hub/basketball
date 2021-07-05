
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/get_single_player_data_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_videos_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/entities/single_team_achievement_data_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/single_team_related_albums_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/single_team_staff_data_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/single_team_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/nadi.dart';
import 'package:hi_market/basket_ball/presentation/widgets/video_app.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:video_player/video_player.dart';

import '../../../injection.dart';
import '../../../res.dart';
import '../../../toast_utils.dart';

class NadiWidget extends StatefulWidget {
  NadiWidget(
      {Key key,
      @required this.name,
      @required this.showBoolean,
      @required this.teamID, this.logo})
      : super(key: key);
  String name;
  showDataBoolean showBoolean;
  String teamID;
  String logo;

  @override
  _NadiWidgetState createState() {
    return _NadiWidgetState();
  }
}

class _NadiWidgetState extends State<NadiWidget> {
  GetSingleTeamAchievementDataEntities getSingleTeamAchievementDataEntities =
      GetSingleTeamAchievementDataEntities(data: List());
  GetSingleTeamPlayersDataEntities getSingleTeamPlayersDataEntities =
      GetSingleTeamPlayersDataEntities(data: List());
  GetSingleTeamVideosEntities getVideosScreenEntities = GetSingleTeamVideosEntities(data: List());
  SingleTeamRelatedAlbumsEntities getAlbumScreenEntities = SingleTeamRelatedAlbumsEntities(data: List());
  GetSingleTeamStaffDataEntities getSingleTeamStaffDataEntities =
      GetSingleTeamStaffDataEntities(data: List());

  getData() async {

   /* var responsePlayers = await sl<Cases>().singleTeamPlayersData(widget.teamID);
    if (responsePlayers is GetSingleTeamPlayersDataEntities) {
      setState(() {
        getSingleTeamPlayersDataEntities = responsePlayers;
      });
    } else if (responsePlayers is ResponseModelFailure) {
      ResponseModelFailure failure = responsePlayers;
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
          messageText: Text(
            response.message,
            textAlign: TextAlign.center,
          ))
          : showToast(context, failure.message);
    }else if (response == null) {
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
          messageText: Text(
            "Connection Error",
            textAlign: TextAlign.center,
          ))
          : showToast(context, "Connection Error");
    }
    var responseStaff = await sl<Cases>().singleTeamStaffData(widget.teamID);
    if (responseStaff is GetSingleTeamStaffDataEntities) {
      setState(() {
        getSingleTeamStaffDataEntities = responseStaff;
      });
    } else if (responseStaff is ResponseModelFailure) {
      ResponseModelFailure failure = responseStaff;
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
          messageText: Text(
            response.message,
            textAlign: TextAlign.center,
          ))
          : showToast(context, failure.message);
    }else if (response == null) {
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
          messageText: Text(
            "Connection Error",
            textAlign: TextAlign.center,
          ))
          : showToast(context, "Connection Error");
    }
    var responseVideos = await sl<Cases>().singleTeamVideosScreenInitiation(widget.teamID);
    if (responseVideos is GetSingleTeamVideosEntities) {
      setState(() {
        getVideosScreenEntities = responseVideos;
      });
    } else if (responseVideos is ResponseModelFailure) {
      ResponseModelFailure failure = responseVideos;
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
          messageText: Text(
            response.message,
            textAlign: TextAlign.center,
          ))
          : showToast(context, failure.message);
    }else if (response == null) {
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
          messageText: Text(
            "Connection Error",
            textAlign: TextAlign.center,
          ))
          : showToast(context, "Connection Error");
    }
    var responseAlbums = await sl<Cases>().singleTeamRelatedAlbums(widget.teamID);
    if (responseAlbums is SingleTeamRelatedAlbumsEntities) {
      setState(() {
        getAlbumScreenEntities = responseAlbums;
      });
    } else if (responseAlbums is ResponseModelFailure) {
      ResponseModelFailure failure = responseAlbums;
      var platform = Theme.of(context).platform;
      platform == TargetPlatform.iOS
          ? Get.snackbar("", "",
          messageText: Text(
            response.message,
            textAlign: TextAlign.center,
          ))
          : showToast(context, failure.message);
    }else if (response == null) {
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

  @override
  void initState() {
    super.initState();
    if (widget.showBoolean.showNadi) {
      getData();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 50),
        child: Column(
          children: [
            ListTile(
              leading: widget.logo != null ?Container(
                width: 50,
                child: Image.network(widget.logo),
              ):Container(
                height: 50,
                width: 10,
                color: Colors.red,
              ),
              title: Text(
                "${widget.name}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              trailing: widget.showBoolean.showNadi
                  ? Icon(Icons.keyboard_arrow_down)
                  : Icon(Icons.arrow_forward_ios),
            ),
            widget.showBoolean.showNadi
                ? Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ListView(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 50),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: ()async{
                                    if(getSingleTeamPlayersDataEntities.status == null){
                                      ProgressDialog dialog =
                                          ProgressDialog(context);
                                      dialog.show();
                                      var response = await sl<Cases>()
                                          .singleTeamPlayersData(
                                              widget.teamID);
                                      dialog.hide();
                                      if (response
                                          is GetSingleTeamPlayersDataEntities) {
                                        dialog.hide();
                                        setState(() {
                                          getSingleTeamPlayersDataEntities =
                                              response;
                                          widget.showBoolean.showListPlayer =
                                              !widget
                                                  .showBoolean.showListPlayer;
                                          if (widget.showBoolean.showAlbums) {
                                            widget.showBoolean.showAlbums =
                                                !widget.showBoolean.showAlbums;
                                          }
                                          if (widget.showBoolean.showVideos) {
                                            widget.showBoolean.showVideos =
                                                !widget.showBoolean.showVideos;
                                          }
                                          if (widget
                                              .showBoolean.showAtchivements) {
                                            widget.showBoolean
                                                    .showAtchivements =
                                                !widget.showBoolean
                                                    .showAtchivements;
                                          }
                                          if (widget.showBoolean.showPlayers) {
                                            widget.showBoolean.showPlayers =
                                                !widget.showBoolean.showPlayers;
                                          }
                                          if (widget.showBoolean.showDevice) {
                                            widget.showBoolean.showDevice =
                                                !widget.showBoolean.showDevice;
                                          }
                                        });
                                      } else if (response
                                          is ResponseModelFailure) {
                                        dialog.hide();
                                        ResponseModelFailure failure = response;
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                                messageText: Text(
                                                  response.message,
                                                  textAlign: TextAlign.center,
                                                ))
                                            : showToast(
                                                context, failure.message);
                                      } else if (response == null) {
                                        dialog.hide();
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                                messageText: Text(
                                                  "Connection Error",
                                                  textAlign: TextAlign.center,
                                                ))
                                            : showToast(
                                                context, "Connection Error");
                                      }
                                    }else{
                                      setState(() {
                                        widget.showBoolean.showListPlayer =
                                        !widget
                                            .showBoolean.showListPlayer;
                                        if (widget.showBoolean.showAlbums) {
                                          widget.showBoolean.showAlbums =
                                          !widget.showBoolean.showAlbums;
                                        }
                                        if (widget.showBoolean.showVideos) {
                                          widget.showBoolean.showVideos =
                                          !widget.showBoolean.showVideos;
                                        }
                                        if (widget
                                            .showBoolean.showAtchivements) {
                                          widget.showBoolean
                                              .showAtchivements =
                                          !widget.showBoolean
                                              .showAtchivements;
                                        }
                                        if (widget.showBoolean.showPlayers) {
                                          widget.showBoolean.showPlayers =
                                          !widget.showBoolean.showPlayers;
                                        }
                                        if (widget.showBoolean.showDevice) {
                                          widget.showBoolean.showDevice =
                                          !widget.showBoolean.showDevice;
                                        }
                                      });
                                    }
                                  },
                                  leading: Container(
                                    width: 10,
                                    height: 50,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "قائمه اللاعبين",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: widget.showBoolean.showListPlayer
                                      ? Icon(Icons.keyboard_arrow_down)
                                      : Icon(Icons.arrow_forward_ios),
                                ),
                                ...getSingleTeamPlayersDataEntities.data.map((e) => widget.showBoolean.showListPlayer
            ? Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: MediaQuery.of(
                                              context)
                                              .size
                                              .height /
                                              5,
                                          child: Image.network(e.thumb),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                "${e.title}",
                                                style: TextStyle(
                                                    color: Colors
                                                        .black,
                                                    fontSize: 25,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors
                                                        .grey),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors
                                                        .grey),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ): Container()).toList()
                                    ,
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 50),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: ()async{
                                    if(getSingleTeamStaffDataEntities.status == null){
                                      ProgressDialog dialog =
                                      ProgressDialog(context);
                                      dialog.show();
                                      var response = await sl<Cases>()
                                          .singleTeamStaffData(
                                          widget.teamID);
                                      dialog.hide();
                                      if (response
                                      is GetSingleTeamStaffDataEntities) {
                                        dialog.hide();
                                        setState(() {
                                          getSingleTeamStaffDataEntities =
                                              response;
                                          widget.showBoolean.showDevice =
                                          !widget.showBoolean.showDevice;
                                          if (widget.showBoolean.showAlbums) {
                                            widget.showBoolean.showAlbums = !widget.showBoolean.showAlbums;
                                          }
                                          if (widget.showBoolean.showVideos) {
                                            widget.showBoolean.showVideos = !widget.showBoolean.showVideos;
                                          }
                                          if (widget.showBoolean.showAtchivements) {
                                            widget.showBoolean.showAtchivements = !widget.showBoolean.showAtchivements;
                                          }
                                          if (widget.showBoolean.showPlayers) {
                                            widget.showBoolean.showPlayers = !widget.showBoolean.showPlayers;
                                          }
                                          if (widget.showBoolean.showListPlayer) {
                                            widget.showBoolean.showListPlayer = !widget.showBoolean.showListPlayer;
                                          }
                                        });
                                      } else if (response
                                      is ResponseModelFailure) {
                                        dialog.hide();
                                        ResponseModelFailure failure = response;
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                            messageText: Text(
                                              response.message,
                                              textAlign: TextAlign.center,
                                            ))
                                            : showToast(
                                            context, failure.message);
                                      } else if (response == null) {
                                        dialog.hide();
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                            messageText: Text(
                                              "Connection Error",
                                              textAlign: TextAlign.center,
                                            ))
                                            : showToast(
                                            context, "Connection Error");
                                      }
                                    }else {
                                      setState(() {
                                        widget.showBoolean.showDevice =
                                        !widget.showBoolean.showDevice;
                                        if (widget.showBoolean.showAlbums) {
                                          widget.showBoolean.showAlbums =
                                          !widget.showBoolean.showAlbums;
                                        }
                                        if (widget.showBoolean.showVideos) {
                                          widget.showBoolean.showVideos =
                                          !widget.showBoolean.showVideos;
                                        }
                                        if (widget.showBoolean
                                            .showAtchivements) {
                                          widget.showBoolean.showAtchivements =
                                          !widget.showBoolean.showAtchivements;
                                        }
                                        if (widget.showBoolean.showPlayers) {
                                          widget.showBoolean.showPlayers =
                                          !widget.showBoolean.showPlayers;
                                        }
                                        if (widget.showBoolean.showListPlayer) {
                                          widget.showBoolean.showListPlayer =
                                          !widget.showBoolean.showListPlayer;
                                        }
                                      });
                                    }
                                  },
                                  leading: Container(
                                    width: 10,
                                    height: 50,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "الجهاز الفنى",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: widget.showBoolean.showDevice
                                      ? Icon(Icons.keyboard_arrow_down)
                                      : Icon(Icons.arrow_forward_ios),
                                ),
                               ...getSingleTeamStaffDataEntities.data.map((e) => widget.showBoolean.showDevice
                                   ?  Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: MediaQuery.of(
                                              context)
                                              .size
                                              .height /
                                              5,
                                          child: Image.network(e.thumb),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                "${e.title}",
                                                style: TextStyle(
                                                    color: Colors
                                                        .black,
                                                    fontSize: 25,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors
                                                        .grey),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "",
                                                style: TextStyle(
                                                    color: Colors
                                                        .grey),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ):Container()).toList(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 50),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: ()async{
                                    if(getSingleTeamAchievementDataEntities.status == null){
                                      ProgressDialog dialog =
                                      ProgressDialog(context);
                                      dialog.show();
                                      var response = await sl<Cases>()
                                          .singleTeamAchievementsData(
                                          widget.teamID);
                                      dialog.hide();
                                      if (response
                                      is GetSingleTeamAchievementDataEntities) {
                                        dialog.hide();
                                          getSingleTeamAchievementDataEntities =
                                              response;
                                          setState(() {
                                            widget.showBoolean.showAtchivements =
                                            !widget.showBoolean.showAtchivements;
                                            if (widget.showBoolean.showAlbums) {
                                              widget.showBoolean.showAlbums =
                                              !widget.showBoolean.showAlbums;
                                            }
                                            if (widget.showBoolean.showVideos) {
                                              widget.showBoolean.showVideos =
                                              !widget.showBoolean.showVideos;
                                            }
                                            if (widget.showBoolean.showPlayers) {
                                              widget.showBoolean.showPlayers =
                                              !widget.showBoolean.showPlayers;
                                            }
                                            if (widget.showBoolean.showDevice) {
                                              widget.showBoolean.showDevice =
                                              !widget.showBoolean.showDevice;
                                            }
                                            if (widget.showBoolean.showListPlayer) {
                                              widget.showBoolean.showListPlayer =
                                              !widget.showBoolean.showListPlayer;
                                            }
                                          });

                                      } else if (response
                                      is ResponseModelFailure) {
                                        dialog.hide();
                                        ResponseModelFailure failure = response;
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                            messageText: Text(
                                              response.message,
                                              textAlign: TextAlign.center,
                                            ))
                                            : showToast(
                                            context, failure.message);
                                      } else if (response == null) {
                                        dialog.hide();
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                            messageText: Text(
                                              "Connection Error",
                                              textAlign: TextAlign.center,
                                            ))
                                            : showToast(
                                            context, "Connection Error");
                                      }
                                    }else {
                                      setState(() {
                                        widget.showBoolean.showAtchivements =
                                        !widget.showBoolean.showAtchivements;
                                        if (widget.showBoolean.showAlbums) {
                                          widget.showBoolean.showAlbums =
                                          !widget.showBoolean.showAlbums;
                                        }
                                        if (widget.showBoolean.showVideos) {
                                          widget.showBoolean.showVideos =
                                          !widget.showBoolean.showVideos;
                                        }
                                        if (widget.showBoolean.showPlayers) {
                                          widget.showBoolean.showPlayers =
                                          !widget.showBoolean.showPlayers;
                                        }
                                        if (widget.showBoolean.showDevice) {
                                          widget.showBoolean.showDevice =
                                          !widget.showBoolean.showDevice;
                                        }
                                        if (widget.showBoolean.showListPlayer) {
                                          widget.showBoolean.showListPlayer =
                                          !widget.showBoolean.showListPlayer;
                                        }
                                      });
                                    }
                                  },
                                  leading: Container(
                                    width: 10,
                                    height: 50,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "الانجازات",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: widget.showBoolean.showAtchivements
                                      ? Icon(Icons.keyboard_arrow_down)
                                      : Icon(Icons.arrow_forward_ios),
                                ),
                                 ...getSingleTeamAchievementDataEntities.data.map((e) => widget.showBoolean.showAtchivements
            ?Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Image.asset(Res.basketiconlistimage),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("${e.title}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                        width:
                                        MediaQuery.of(context)
                                            .size
                                            .width,
                                        margin: EdgeInsets.only(
                                            right: 30),
                                        child: Text(
                                          "${e.content}",
                                          textAlign:
                                          TextAlign.right,
                                          maxLines: 5,
                                        ),
                                      )
                                    ],
                                  ),
                                ):Container()).toList(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 50),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: ()async{
                                    if(getAlbumScreenEntities.status == null){
                                      ProgressDialog dialog =
                                      ProgressDialog(context);
                                      dialog.show();
                                      var response = await sl<Cases>()
                                          .singleTeamRelatedAlbums(
                                          widget.teamID);
                                      dialog.hide();
                                      if (response
                                      is SingleTeamRelatedAlbumsEntities) {
                                        dialog.hide();
                                        setState(() {
                                          getAlbumScreenEntities =
                                              response;
                                          widget.showBoolean.showAlbums =
                                          !widget.showBoolean.showAlbums;
                                          if (widget.showBoolean.showVideos) {
                                            widget.showBoolean.showVideos = !widget.showBoolean.showVideos;
                                          }
                                          if (widget.showBoolean.showAtchivements) {
                                            widget.showBoolean.showAtchivements = !widget.showBoolean.showAtchivements;
                                          }
                                          if (widget.showBoolean.showPlayers) {
                                            widget.showBoolean.showPlayers = !widget.showBoolean.showPlayers;
                                          }
                                          if (widget.showBoolean.showDevice) {
                                            widget.showBoolean.showDevice = !widget.showBoolean.showDevice;
                                          }
                                          if (widget.showBoolean.showListPlayer) {
                                            widget.showBoolean.showListPlayer = !widget.showBoolean.showListPlayer;
                                          }
                                        });
                                      } else if (response
                                      is ResponseModelFailure) {
                                        dialog.hide();
                                        ResponseModelFailure failure = response;
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                            messageText: Text(
                                              response.message,
                                              textAlign: TextAlign.center,
                                            ))
                                            : showToast(
                                            context, failure.message);
                                      } else if (response == null) {
                                        dialog.hide();
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                            messageText: Text(
                                              "Connection Error",
                                              textAlign: TextAlign.center,
                                            ))
                                            : showToast(
                                            context, "Connection Error");
                                      }
                                    }else {
                                      setState(() {
                                        widget.showBoolean.showAlbums =
                                        !widget.showBoolean.showAlbums;
                                        if (widget.showBoolean.showVideos) {
                                          widget.showBoolean.showVideos =
                                          !widget.showBoolean.showVideos;
                                        }
                                        if (widget.showBoolean
                                            .showAtchivements) {
                                          widget.showBoolean.showAtchivements =
                                          !widget.showBoolean.showAtchivements;
                                        }
                                        if (widget.showBoolean.showPlayers) {
                                          widget.showBoolean.showPlayers =
                                          !widget.showBoolean.showPlayers;
                                        }
                                        if (widget.showBoolean.showDevice) {
                                          widget.showBoolean.showDevice =
                                          !widget.showBoolean.showDevice;
                                        }
                                        if (widget.showBoolean.showListPlayer) {
                                          widget.showBoolean.showListPlayer =
                                          !widget.showBoolean.showListPlayer;
                                        }
                                      });
                                    }
                                  },
                                  leading: Container(
                                    width: 10,
                                    height: 50,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "البومات",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: widget.showBoolean.showAlbums
                                      ? Icon(Icons.keyboard_arrow_down)
                                      : Icon(Icons.arrow_forward_ios),
                                ),
                                ...getAlbumScreenEntities.data.map((e) =>  widget.showBoolean.showAlbums
                                    ?Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ListTile(
                                          leading: Container(
                                            width: 10,
                                            height: 50,
                                            color: Colors.red,
                                          ),
                                          title: HtmlWidget(
                                            "${e.title}",
                                            /*style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),*/
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height / 3.5,
                                        // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                        child: Row(
                                          children: [
                                            Flexible(
                                                child: Stack(
                                                  children: [
                                                    GridView.builder(
                                                     // padding: EdgeInsets.only(top: 10),
                                                        itemCount: e.thubmsUrls.length >
                                                            4
                                                            ? 4
                                                            : e.thubmsUrls.length,
                                                        gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            crossAxisSpacing: 2,
                                                            childAspectRatio: 0.9,
                                                            mainAxisSpacing: 2),
                                                        itemBuilder: (context, ind) {
                                                          return Image.network(
                                                            e.thubmsUrls[ind],
                                                            fit: BoxFit.fill,
                                                          );
                                                        }),
                                                    Container(
                                                      decoration: BoxDecoration(/*border:Border.all(color:Colors.black)*/),

                                                      width: MediaQuery.of(context).size.width,
                                                      height: MediaQuery.of(context).size.height,
                                                    )
                                                  ],
                                                )),
                                            Flexible(
                                                child: Container(
                                                  //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                                    height: MediaQuery.of(context).size.height / 3,
                                                    padding: EdgeInsets.all(2),
                                                    child: Image.network(
                                                      e.albumThumb,
                                                      fit: BoxFit.fill,
                                                    ))),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ):Container()).toList()
                                    ,
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 50),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: ()async{
                                    if(getVideosScreenEntities.status == null){
                                      ProgressDialog dialog =
                                      ProgressDialog(context);
                                      dialog.show();
                                      var response = await sl<Cases>()
                                          .singleTeamVideosScreenInitiation(
                                          widget.teamID);
                                      dialog.hide();
                                      if (response
                                      is GetSingleTeamVideosEntities) {
                                        dialog.hide();
                                        setState(() {
                                          getVideosScreenEntities =
                                              response;
                                          widget.showBoolean.showVideos =
                                          !widget.showBoolean.showVideos;
                                          if (widget.showBoolean.showAlbums) {
                                            widget.showBoolean.showAlbums = !widget.showBoolean.showAlbums;
                                          }
                                          if (widget.showBoolean.showAtchivements) {
                                            widget.showBoolean.showAtchivements = !widget.showBoolean.showAtchivements;
                                          }
                                          if (widget.showBoolean.showPlayers) {
                                            widget.showBoolean.showPlayers = !widget.showBoolean.showPlayers;
                                          }
                                          if (widget.showBoolean.showDevice) {
                                            widget.showBoolean.showDevice = !widget.showBoolean.showDevice;
                                          }
                                          if (widget.showBoolean.showListPlayer) {
                                            widget.showBoolean.showListPlayer = !widget.showBoolean.showListPlayer;
                                          }
                                        });
                                      } else if (response
                                      is ResponseModelFailure) {
                                        dialog.hide();
                                        ResponseModelFailure failure = response;
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                            messageText: Text(
                                              response.message,
                                              textAlign: TextAlign.center,
                                            ))
                                            : showToast(
                                            context, failure.message);
                                      } else if (response == null) {
                                        dialog.hide();
                                        var platform =
                                            Theme.of(context).platform;
                                        platform == TargetPlatform.iOS
                                            ? Get.snackbar("", "",
                                            messageText: Text(
                                              "Connection Error",
                                              textAlign: TextAlign.center,
                                            ))
                                            : showToast(
                                            context, "Connection Error");
                                      }
                                    }else {
                                      setState(() {
                                        widget.showBoolean.showVideos =
                                        !widget.showBoolean.showVideos;
                                        if (widget.showBoolean.showAlbums) {
                                          widget.showBoolean.showAlbums =
                                          !widget.showBoolean.showAlbums;
                                        }
                                        if (widget.showBoolean
                                            .showAtchivements) {
                                          widget.showBoolean.showAtchivements =
                                          !widget.showBoolean.showAtchivements;
                                        }
                                        if (widget.showBoolean.showPlayers) {
                                          widget.showBoolean.showPlayers =
                                          !widget.showBoolean.showPlayers;
                                        }
                                        if (widget.showBoolean.showDevice) {
                                          widget.showBoolean.showDevice =
                                          !widget.showBoolean.showDevice;
                                        }
                                        if (widget.showBoolean.showListPlayer) {
                                          widget.showBoolean.showListPlayer =
                                          !widget.showBoolean.showListPlayer;
                                        }
                                      });
                                    }
                                  },
                                  leading: Container(
                                    width: 10,
                                    height: 50,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "فيديوهات",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  trailing: widget.showBoolean.showVideos
                                      ? Icon(Icons.keyboard_arrow_down)
                                      : Icon(Icons.arrow_forward_ios),
                                ),
                                 ...getVideosScreenEntities.data.map((e) => widget.showBoolean.showVideos
                                     ?Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Container(
                                          padding:
                                          EdgeInsets.all(10),
                                          height: MediaQuery.of(
                                              context)
                                              .size
                                              .height /
                                              3,
                                          child: ChewieListItem( videoPlayerController: VideoPlayerController.network(e.attachmentUrl),)),
                                      Container(
                                        margin:
                                        EdgeInsets.all(10),
                                        alignment:
                                        Alignment.center,
                                        child: Text("${e.title}"),
                                      )
                                    ],
                                  ),
                                ):Container()).toList()
                                    ,
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
