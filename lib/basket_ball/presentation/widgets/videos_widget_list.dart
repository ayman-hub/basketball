
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_videos_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/get_watch_web_two_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/video_app.dart';
import 'package:hi_market/basket_ball/presentation/widgets/youtube_watch_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:video_player/video_player.dart';
import '../../../injection.dart';
import '../../../main.dart';
import '../../../toast_utils.dart';
import 'get_watch_web_widget.dart';
import 'loading_widget.dart';
import 'package:video_player/video_player.dart';

import 'main_page/get_youtube_list_widget.dart';


class VideosWidgetList extends StatefulWidget {
  VideosWidgetList({Key key}) : super(key: key);

  @override
  _VideosWidgetListState createState() {
    return _VideosWidgetListState();
  }
}

class _VideosWidgetListState extends State<VideosWidgetList> {
  Future getVideos;

  bool showProgress = false;



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  LiquidPullToRefresh(
      onRefresh: ()async{
         getVideosScreenEntities.data = [];
       Move.noBack(context:context,page:MyHomePage(
           getPosition: 1, chosenSelected: 1));
      },
      backgroundColor: Colors.white,
      color: staticColor,
      child: Container(
          child:getVideosScreenEntities.data.length != 0?showVideosDataStyleList(getVideosScreenEntities): FutureBuilder(
        future: getVideos ?? sl<Cases>().videosScreenInitiation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            print("snapshotError : ${snapshot.error}");
            return errorContainer(
                context, () {
              setState(() {
                getVideos = sl<Cases>().videosScreenInitiation();
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
              if (snapshot.data is GetVideosScreenEntities) {
                getVideosScreenEntities = snapshot.data;
                return showVideosDataStyleList(snapshot.data);
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
                          getVideos = sl<Cases>().videosScreenInitiation();
                        });
                      });
                }
              }
              break;
          }
          return errorContainer(
              context, () {
            setState(() {
              getVideos = sl<Cases>().videosScreenInitiation();
            });
          });
        },
      )),
    );
  }

  bool showScroll = true;
  bool progress = false;

  showVideosDataStyleList(GetVideosScreenEntities getVideosScreenEntities) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: _getAlbumsMore,
          child: ListView.builder(
            itemCount: getVideosScreenEntities.data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Container(
                        width: 10,
                        height: 50,
                        color: Colors.red,
                      ),
                      title: Text(
                        "${getVideosScreenEntities.data[index].title}",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...getVideosScreenEntities.data[index].videos
                      .map((e) => Container(
                        child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height / 3,
                                    child:e.attachmentUrl == ""?Container(
                                      alignment: Alignment.center,
                                      child: Image.asset("images/basketiconlistimage.png"),
                                    ): YoutubeListWidget(
                                      e.attachmentUrl,
                                      title: e.title,
                                      videoType:e.videoType,
                                      videos:getVideosScreenEntities.data[index].videos,
                                      borderRadius:
                                      BorderRadius.only(
                                          topLeft: Radius
                                              .circular(10),
                                          topRight: Radius
                                              .circular(
                                              10)),
                                    )),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Text(
                                      "${e.title}",textAlign: TextAlign.center,),
                                )
                              ],
                            ),
                      ))
                      .toList()
                ],
              );
            },
          ),
        ),
        progress?getLoadingContainer(context):Container()
      ],
    );
  }
  bool getMoreNews = true;
  bool _getAlbumsMore(ScrollNotification notification) {
   /* if(getMoreNews){
      getAddMostViewData();
    }*/
  }
  ScrollController scrollController = ScrollController();
  getAddMostViewData() async {
    if(showScroll){
      setState(() {
        getMoreNews = false;
        progress = true;
        showScroll = false;
      });
    var response = await sl<Cases>()
        .albumsScreenLoadMore(scrollController.offset.toString());
    setState(() {
      getMoreNews = true;
    });
    if (response is GetVideosScreenEntities) {
      if (response.data.last.id !=
          getVideosScreenEntities.data.last.id) {
        setState(() {
          getVideosScreenEntities.data.addAll(response.data);
        });
      }
    } else if (response is ResponseModelFailure) {
      setState(() {
        getMoreNews = false;
      });
      print(response.message);
    } else {
      setState(() {
        getMoreNews = false;
      });
      errorDialog(context);
    }
  }
  }
}
