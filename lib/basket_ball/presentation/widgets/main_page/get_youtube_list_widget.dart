

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_videos_screen_entities.dart';
import 'package:hi_market/basket_ball/presentation/widgets/video/video_thumb_nail.dart';
import 'package:path/path.dart';

import '../video_app.dart';
import '../youtube_watch_widget.dart';
import 'package:video_player/video_player.dart';


class YoutubeListWidget extends StatelessWidget {
  YoutubeListWidget(this.link,{this.title,this.showTitle = false,Key key,  this.borderRadius,  this.videoType,  this.videos, this.onTap}) : super(key: key);
  String link ;
  String title;
  bool showTitle ;
  VideoType videoType;
  BorderRadius borderRadius;
  List<Videos> videos;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    print('getLink:::::$link');
    return InkWell(
        onTap: onTap ??() {
          print("pressed");
          Get.to(
              YoutubeWatchPage(
                  link,
                  title??"البث المباشر",
                videoType,
              videos:videos,
             ),
              transition:
              Transition.fadeIn);
        },
        child: Container(
            width:
            MediaQuery.of(context)
                .size
                .width,
            height: 200,
            decoration: videoType == VideoType.youtube? BoxDecoration(
                borderRadius:
               borderRadius?? BorderRadius
                    .circular(10),
                image: DecorationImage(
                  image: Image.network(
                    youTubeImage(
                       link),
                    fit:
                    BoxFit.fitWidth,
                  ).image,
                  fit: BoxFit.fitWidth,
                )):BoxDecoration(),
            padding: EdgeInsets.all(10),
            alignment:
            Alignment.bottomRight,
            child: videoType == VideoType.video?Stack(
              children: [
                VideoImage(link),//ChewieListItem(videoPlayerController:VideoPlayerController.network(link),autoPlay: false,showControls: false,),
                Column(
                  children: [
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          alignment:
                          Alignment.center,
                          child: Container(
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  5),
                              color: Colors
                                  .white
                                  .withOpacity(
                                  0.3),
                            ),
                            height: 45,
                            width: 75,
                            alignment: Alignment
                                .center,
                            child: Icon(
                              Icons.play_arrow,
                              size: 30,
                              color:
                              Colors.white,
                            ),
                          ),
                        )),
                    showTitle? Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .end,
                      children: [
                        Expanded(
                          child: Text(
                            title?? "مباشر",
                            maxLines: 1,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.cairo(
                                color: Colors
                                    .white,
                                fontSize: 15,
                                fontWeight:
                                FontWeight
                                    .w400),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "images/basketiconlistimage.png",
                          scale: 2,
                        )
                      ],
                    ):Container(),
                  ],
                )
              ],
            ):Column(
              children: [
                Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      alignment:
                      Alignment.center,
                      child: Container(
                        decoration:
                        BoxDecoration(
                          borderRadius:
                          BorderRadius
                              .circular(
                              5),
                          color: Colors
                              .white
                              .withOpacity(
                              0.3),
                        ),
                        height: 45,
                        width: 75,
                        alignment: Alignment
                            .center,
                        child: Icon(
                          Icons.play_arrow,
                          size: 30,
                          color:
                          Colors.white,
                        ),
                      ),
                    )),
               showTitle? Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .end,
                  children: [
                    Expanded(
                      child: Text(
                       title?? "مباشر",
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.cairo(
                            color: Colors
                                .white,
                            fontSize: 15,
                            fontWeight:
                            FontWeight
                                .w400),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "images/basketiconlistimage.png",
                      scale: 2,
                    )
                  ],
                ):Container(),
              ],
            )));
  }
}
