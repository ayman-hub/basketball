
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../res.dart';
import 'main_page.dart';

class ShowMainPageVideos extends StatefulWidget {
  ShowMainPageVideos({Key key, @required this.url}) : super(key: key);
  final String url;

  @override
  _ShowMainPageVideosState createState() {
    return _ShowMainPageVideosState();
  }
}

class _ShowMainPageVideosState extends State<ShowMainPageVideos> {
  YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
   // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _youtubeController = YoutubePlayerController(
        initialVideoId: widget.url,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          loop: false,
          forceHD: false,
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _youtubeController.pause();
    _youtubeController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            Res.wightbasketimage,
            fit: BoxFit.fill,
          ),
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
                    icon: Image.asset(
                      Res.backimage,
                      color: Color(0xffE31E24),
                    ),
                    onPressed: () {
                      return Get.back();
                    }),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: YoutubePlayer(
                  controller: _youtubeController,
                  aspectRatio: 16 / 9,
                  onReady: () {
                    print('video is ready');
                  },
                  onEnded: (end) {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
