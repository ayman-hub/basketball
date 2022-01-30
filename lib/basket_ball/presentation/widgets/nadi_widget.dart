
import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_videos_entities.dart';
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
import 'package:hi_market/basket_ball/presentation/widgets/youtube_watch_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:video_player/video_player.dart';

import '../../../injection.dart';
import '../../../res.dart';
import '../../../toast_utils.dart';
import 'TileWidget.dart';
import 'loading_widget.dart';
import 'main_page/get_youtube_list_widget.dart';

class NadiWidget extends StatefulWidget {
  NadiWidget(
      {Key key,
      @required this.name,
      @required this.showBoolean,
      @required this.teamID, this.logo,  this.onChanged,})
      : super(key: key);
  String name;
  showDataBoolean showBoolean;
  String teamID;
  String logo;
  ValueChanged<bool> onChanged;
  Function isActiveMethod ;

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

  bool showProgress = false;


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
    return Stack(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 50),
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
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
                  ),
                ),
             SizedBox(height: 20,),
             Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: ListView(
                          children: [
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 50),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: ()async{
                                        if(getSingleTeamPlayersDataEntities.status == null){
                                          setState(() {
                                            showProgress =true;
                                          });
                                          var response = await sl<Cases>()
                                              .singleTeamPlayersData(
                                                  widget.teamID);
                                          setState(() {
                                            showProgress =false;
                                          });
                                          if (response
                                              is GetSingleTeamPlayersDataEntities) {
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
                                              widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                  .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                            });
                                          } else if (response
                                              is ResponseModelFailure) {
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
                                            widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                          });
                                        }
                                      },
                                      child: TileWidget(
                                        "قائمه اللاعبين",
                                      ),
                                    ),
                                    widget.showBoolean.showListPlayer &&getSingleTeamPlayersDataEntities.data.length == 0 ?getNoDataWidget() :Column(
                                      children: [
                                        ...getSingleTeamPlayersDataEntities.data.map((e) => widget.showBoolean.showListPlayer ? Container(
                                          height: 100,
                                          child:CardWidget(imageLink: e.thumb,position: e.title,)
                                        ): Container()).toList()
                                      ],
                                    )
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
                                    InkWell(
                                      onTap: ()async{
                                        if(getSingleTeamStaffDataEntities.status == null){
                                          setState(() {
                                            showProgress =true;
                                          });
                                          var response = await sl<Cases>()
                                              .singleTeamStaffData(
                                              widget.teamID);
                                          setState(() {
                                            showProgress =false;
                                          });
                                          if (response
                                          is GetSingleTeamStaffDataEntities) {

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
                                              widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                  .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                            });
                                          } else if (response
                                          is ResponseModelFailure) {

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
                                            widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                          });
                                        }
                                      },
                                      child: TileWidget(
                                        "الجهاز الفنى",
                                      ),
                                    ),
                                    widget.showBoolean.showDevice && getSingleTeamStaffDataEntities.data.length == 0?getNoDataWidget():  Column(
                                    children: [
                                      ...getSingleTeamStaffDataEntities.data.map((e) => widget.showBoolean.showDevice
                                          ?  Container(
                                        height: 100,
                                        child: CardWidget(position: e.position,imageLink: e.thumb,title: e.title,),
                                      ):Container()).toList()
                                    ],
                                  ),
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
                                    InkWell(
                                      onTap: ()async{
                                        if(getSingleTeamAchievementDataEntities.status == null){
                                          setState(() {
                                            showProgress =true;
                                          });
                                          var response = await sl<Cases>()
                                              .singleTeamAchievementsData(
                                              widget.teamID);
                                           setState(() {
                                             showProgress =false;
                                           });
                                          if (response
                                          is GetSingleTeamAchievementDataEntities) {
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
                                                widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                    .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                              });

                                          } else if (response
                                          is ResponseModelFailure) {
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
                                            widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                          });
                                        }
                                      },
                                      child: TileWidget(
                                        "الانجازات",
                                      ),
                                    ),
                                    widget.showBoolean.showAtchivements && getSingleTeamAchievementDataEntities.data.length == 0?getNoDataWidget(): Column(
                                       children: [
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
                                         ):Container()).toList()
                                       ],
                                     ),
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
                                    InkWell(
                                      onTap: ()async{
                                        if(getAlbumScreenEntities.status == null){

                                          setState(() {
                                            showProgress =true;
                                          });
                                          var response = await sl<Cases>()
                                              .singleTeamRelatedAlbums(
                                              widget.teamID);
                                          setState(() {
                                            showProgress =false;
                                          });
                                          if (response
                                          is SingleTeamRelatedAlbumsEntities) {
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
                                              widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                  .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                            });
                                          } else if (response
                                          is ResponseModelFailure) {
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
                                            widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                          });
                                        }
                                      },
                                      child: TileWidget(
                                        "البومات",
                                      ),
                                    ),
                                    widget.showBoolean.showAlbums && getAlbumScreenEntities.data.length == 0?getNoDataWidget():  Column(
                                      children: [
                                        ...getAlbumScreenEntities.data.map((e) =>  widget.showBoolean.showAlbums
                                            ?getAlbumsWidget(context,mainPhoto:e.albumThumb,listThumbs:e.thubmsUrls,title:e.title):Container()).toList()
                                      ],
                                    )
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
                                    InkWell(
                                      onTap: ()async{
                                        if(getVideosScreenEntities.status == null){
                                          setState(() {
                                            showProgress =true;
                                          });
                                          var response = await sl<Cases>()
                                              .singleTeamVideosScreenInitiation(
                                              widget.teamID);
                                          if (response
                                          is GetSingleTeamVideosEntities) {
                                            setState(() {
                                              showProgress =false;
                                            });
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
                                              widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                  .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                            });
                                          } else if (response
                                          is ResponseModelFailure) {
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
                                            widget.onChanged(widget.showBoolean.showDevice || widget.showBoolean.showPlayers||widget
                                                .showBoolean.showAtchivements||widget.showBoolean.showVideos||widget.showBoolean.showAlbums||widget.showBoolean.showListPlayer);
                                          });
                                        }
                                      },
                                      child: TileWidget(
                                        "فيديوهات",
                                      ),
                                    ),
                                    widget.showBoolean.showVideos && getVideosScreenEntities.data.length == 0?getNoDataWidget(): Column(
                                     children: [
                                       ...getVideosScreenEntities.data.map((e) => widget.showBoolean.showVideos
                                           ?Container(
                                         padding: EdgeInsets.all(10),
                                         child: Column(
                                           children: [
                                             Container(
                                                 padding: EdgeInsets.all(10),
                                                 height: MediaQuery.of(context).size.height / 3,
                                                 child:e.videoType == VideoType.youtube? YoutubeListWidget(
                                                   e.attachmentUrl,
                                                   title: e.title,
                                                   borderRadius:
                                                   BorderRadius.only(
                                                       topLeft: Radius
                                                           .circular(10),
                                                       topRight: Radius
                                                           .circular(
                                                           10)),
                                                 ):ChewieListItem(videoPlayerController:VideoPlayerController.network(e.attachmentUrl))),
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
                                     ],
                                   ),
                                    SizedBox(height: 100,),
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
              ],
            ),
          ),
        ),
        showProgress?getLoadingContainer(context):Container()
      ],
    );
  }
}
