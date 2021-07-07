import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:hi_market/res.dart';
import 'package:webview_flutter/webview_flutter.dart'as web;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeWatchPage extends StatefulWidget {
  YoutubeWatchPage({Key key,@required this.url})
      : super(key: key);
  final String url;

  @override
  _YoutubeWatchPageState createState() {
    return _YoutubeWatchPageState();
  }
}

class _YoutubeWatchPageState extends State<YoutubeWatchPage> {
  /*YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    _youtubeController = YoutubePlayerController(
        initialVideoId: widget.url,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          loop: false,
          hideControls: true,
          forceHD: false,
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _youtubeController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.5),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4,bottom: MediaQuery.of(context).size.height / 4),
              child: YoutubePlayer(
                controller: _youtubeController,
                aspectRatio: 16 / 9,
                onReady: () {
                  print('video is ready');
                },
                onEnded: (end) {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
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
    runYoutubePlayer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset( Res.wightbasketimage,
              fit: BoxFit.fill,),
          ),
          YoutubePlayerBuilder(
            builder: (context, player) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("My private youtube"),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: player,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
            player: YoutubePlayer(
              controller: _controller,
            ),
          ),
        ],
      ),
    );
  }
}
