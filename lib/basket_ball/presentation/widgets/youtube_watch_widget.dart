import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
  YoutubePlayerController _youtubeController;

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
     String html = """<!DOCTYPE html>
          <html>
            <head>
            <style>
            body {
              overflow: hidden; 
            }
        .embed-youtube {
            position: relative;
            padding-bottom: 56.25%; 
            padding-top: 0px;
            height: 0;
            overflow: hidden;
        }

        .embed-youtube iframe,
        .embed-youtube object,
        .embed-youtube embed {
            border: 0;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
        </style>

        <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
          <meta http-equiv="X-UA-Compatible" content="ie=edge">
           </head>
          <body bgcolor="#121212">                                    
        <div class="embed-youtube">
         <iframe
          id="vjs_video_3_Youtube_api"
          style="width:100%;height:100%;top:0;left:0;position:absolute;"
          class="vjs-tech holds-the-iframe"
          frameborder="0"
          allowfullscreen="1"
          allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
          webkitallowfullscreen mozallowfullscreen allowfullscreen
          title="Live Tv"
          frameborder="0"
          src="https://www.youtube.com/embed/IXpz_yD-N7s"
          ></iframe></div>
          </body>                                    
        </html>
  """;
    final Completer<web.WebViewController> _controller =
    Completer<web.WebViewController>();
    final String contentBase64 =
    base64Encode(const Utf8Encoder().convert(html));
    return web.WebView(
      initialUrl: 'data:text/html;base64,$contentBase64',
      javascriptMode: web.JavascriptMode.unrestricted,
      onWebViewCreated: (web.WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
      gestureNavigationEnabled: true,
    );
   /* return YoutubePlayer(
      controller: _youtubeController,
      aspectRatio: 16 / 9,
      onReady: () {
        print('video is ready');
      },
      onEnded: (end) {
      },
    );*/
  }
}
