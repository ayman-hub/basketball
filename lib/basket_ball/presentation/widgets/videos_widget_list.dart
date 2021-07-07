
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_videos_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/get_watch_web_two_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/video_app.dart';
import 'package:hi_market/basket_ball/presentation/widgets/youtube_watch_widget.dart';
import 'package:video_player/video_player.dart';
import '../../../injection.dart';
import '../../../toast_utils.dart';
import 'get_watch_web_widget.dart';
import 'loading_widget.dart';
import 'package:video_player/video_player.dart';


class VideosWidgetList extends StatefulWidget {
  VideosWidgetList({Key key}) : super(key: key);

  @override
  _VideosWidgetListState createState() {
    return _VideosWidgetListState();
  }
}

class _VideosWidgetListState extends State<VideosWidgetList> {
  Future getVideos;



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
    // TODO: implement build
    return Container(
        child: FutureBuilder(
      future: getVideos ?? sl<Cases>().videosScreenInitiation(),
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
            if (snapshot.data is GetVideosScreenEntities) {
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
                return IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 45,
                    ),
                    onPressed: () {
                      setState(() {
                        getVideos = sl<Cases>().videosScreenInitiation();
                      });
                    });
              }
            }
            break;
        }
        return Container();
      },
    ));
  }

  showVideosDataStyleList(GetVideosScreenEntities getVideosScreenEntities) {
    return ListView.builder(
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
                              child: e.videoType == VideoType.youtube?InkWell(
                                  onTap: (){
                                    print("pressed");
                                    Get.to(YoutubeWatchPage(url: e.attachmentUrl),transition: Transition.fadeIn);
                                  },
                                  child: Image.network(youTubeImage(e.attachmentUrl)))/*GetWatchWebWidget(e.attachmentUrl)*/:ChewieListItem(videoPlayerController:VideoPlayerController.network(e.attachmentUrl))),
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
    );
  }
}
