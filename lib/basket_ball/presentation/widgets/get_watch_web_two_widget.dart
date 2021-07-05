import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart'as d;
import 'package:webview_flutter/webview_flutter.dart';
class GetWatchWebTwoWidget extends StatefulWidget {
  GetWatchWebTwoWidget(this.url, {Key key}) : super(key: key);
  String url;

  @override
  _GetWatchWebTwoWidgetState createState() => _GetWatchWebTwoWidgetState();
}

class _GetWatchWebTwoWidgetState extends State<GetWatchWebTwoWidget> {
  String width = "350";
  String height = "208";

  WebViewController _controller ;
  getData()async{
    if (Platform.isAndroid) {
      d.WebView.platform = SurfaceAndroidWebView();}else{
      width ="1000";
      height = "500";
    }
  }
  @override
  void initState() {
    getData();
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
    if(_controller != null){
      _controller.clearCache();
    }
  }

  @override
  Widget build(BuildContext context) {
    /*return InAppWebView(
      initialUrlRequest:  URLRequest(url: Uri.parse(widget.url)),
    );*/
    return Stack(
      children: [
        d.WebView(
          initialUrl: Uri.dataFromString("<video width=\"${width}\" height=\"${height}\" src=\"${widget.url}\" controls></video>", mimeType: 'text/html').toString(),
          javascriptMode: d.JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          debuggingEnabled: true,
          gestureNavigationEnabled: true,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(),
          margin: EdgeInsets.only(left: 330,top: 150,bottom: 20),
        )
      ],
    );

  }
}


