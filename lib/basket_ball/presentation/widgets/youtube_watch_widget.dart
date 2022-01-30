import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_videos_screen_entities.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/video_app.dart';
import 'package:hi_market/res.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';

import 'loading_widget.dart';
import 'main_page/get_youtube_list_widget.dart';

class YoutubeWatchPage extends StatefulWidget {
  YoutubeWatchPage(this.url,  this.title,this.videoType,{Key key, this.videos = const[]})
      : super(key: key);
  String url;
  String title;
  VideoType videoType;
  List<Videos> videos;

  @override
  _YoutubeWatchPageState createState() {
    return _YoutubeWatchPageState();
  }
}

class _YoutubeWatchPageState extends State<YoutubeWatchPage> {
  YoutubePlayerController _controller;
  void runYoutubePlayer() {
     _controller = YoutubePlayerController(
       initialVideoId: YoutubePlayer.convertUrlToId(
           widget.url),
       flags: YoutubePlayerFlags(
         autoPlay: true,
         enableCaption: false,
         isLive: false,
       ),

     );
  }

  @override
  void initState() {
   if( widget.videoType == VideoType.video) {
      runYoutubePlayer();
    }
    super.initState();
  }

  @override
  void dispose() {
    if( widget.videoType == VideoType.video) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void deactivate() {
    if( widget.videoType == VideoType.video) {
      _controller.pause();
    }
    super.deactivate();
  }
bool fullScreen = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(fullScreen){
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        }else{
          Navigator.pop(context);
        }
        return false;
      },
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset( Res.wightbasketimage,
              fit: BoxFit.fill,),
          ),
          Scaffold(
            appBar: fullScreen?null:AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: Container(),
              title: Text(
                "${widget.title}",
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
              child: YoutubePlayerBuilder(
                onEnterFullScreen: (){
                  setState(() {
                    fullScreen = true;
                  });
                },onExitFullScreen: (){
                  setState(() {
                    fullScreen = false;
                  });
              },
                builder: (context, player) {
                  return  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        child:widget.videoType == VideoType.youtube? player:ChewieListItem(videoPlayerController: VideoPlayerController.network(widget.url))),
                      Expanded(
                        child: Column(
                          children: [
                            Divider(height: 20,thickness: 1,color: Colors.grey,),
                            Container(alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20),
                              height: 30,
                              child: Text(': فيديوهات أخري ',style: GoogleFonts.cairo(color: Colors.grey[800],fontSize: 15),),
                            ),
                            SizedBox(height: 20,),
                            Expanded(
                              child: GridView.builder(
                                itemCount: widget.videos?.length??0,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5,),
                                itemBuilder: (context,index){
                                  return Container(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              height: 50,
                                              margin: EdgeInsets.all(10),
                                              child:widget.videos[index].attachmentUrl == ""?Container(
                                                alignment: Alignment.center,
                                                child: Image.asset("images/basketiconlistimage.png"),
                                              ): YoutubeListWidget(
                                                widget.videos[index].attachmentUrl,
                                                title: widget.videos[index].title,
                                                videoType:widget.videos[index].videoType,
                                                videos:widget.videos,
                                                onTap:(){
                                                  setState(() {
                                                    widget.url = widget.videos[index].attachmentUrl;
                                                    widget.title = widget.videos[index].title;
                                                    widget.videoType = widget.videos[index].videoType;
                                                    Move.noBack(context: context, page: YoutubeWatchPage(widget.url, widget.title, widget.videoType,videos: widget.videos,));
                                                  });
                                                },
                                                borderRadius:
                                                BorderRadius.only(
                                                    topLeft: Radius
                                                        .circular(10),
                                                    topRight: Radius
                                                        .circular(
                                                        10)),
                                              )),
                                        ),
                                        Container(
                                          // margin: EdgeInsets.all(10),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${widget.videos[index].title}",maxLines: 1,textAlign: TextAlign.center,),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
                player: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(
                        widget.url),
                    flags: YoutubePlayerFlags(
                      autoPlay: true,
                      enableCaption: false,
                      isLive: false,
                    ),
                  ),
                  actionsPadding: const EdgeInsets.only(left: 16.0, bottom: 10),
                  bottomActions: [
                    CurrentPosition(),
                    const SizedBox(width: 10.0),
                    ProgressBar(isExpanded: true),
                    const SizedBox(width: 10.0),
                    RemainingDuration(),
                    const SizedBox(width: 10.0),
                   // FullScreenButton(),
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
