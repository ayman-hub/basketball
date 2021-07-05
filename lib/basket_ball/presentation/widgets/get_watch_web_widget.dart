import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
class GetWatchWebWidget extends StatefulWidget {
  GetWatchWebWidget(this.url, {Key key}) : super(key: key);
  String url;

  @override
  _GetWatchWebWidgetState createState() => _GetWatchWebWidgetState();
}

class _GetWatchWebWidgetState extends State<GetWatchWebWidget> {
//InAppWebViewController controller ;
WebViewController controller ;


  bool showLoading =true;
  @override
  void initState() {
  print("startWith: ${widget.url}");
   // getData();
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

@override
  void dispose() {
    print("dispose");
  if(controller != null){
      controller.clearCache();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
   /* return InAppWebView(
      initialUrlRequest:  URLRequest(url: Uri.parse("https://www.youtube.com/watch?v=2H8hR-YkBb0")),
      onLoadStart: (contr,uri){
        controller = controller;
      },
      onWebViewCreated: (con){
        controller = con;
      },

      onProgressChanged: (controller,d){
        controller = controller;
      },
      onCloseWindow: (controller){
        controller = controller;
      },
      onCreateWindow: (controller,d){
        controller = controller;
      },
    );*/
    return Stack(
      children: [
        WebView(
          initialUrl: widget.url,
          onWebViewCreated: (control){
            controller = control;
            controller.clearCache();
            final cookies = CookieManager();
            cookies.clearCookies();
          },
          javascriptMode: JavascriptMode.unrestricted,
          debuggingEnabled: true,
          gestureNavigationEnabled: true,
        ),
        Container(height: 50,decoration: BoxDecoration(border:Border.all(color:Colors.black)),)
      ],
    );

  }
}


