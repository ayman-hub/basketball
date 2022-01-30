import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html/style.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';

import '../../../main.dart';
import '../../../res.dart';
import 'go_to.dart';
import 'loading_widget.dart';

class SpecificNewsWidget extends StatefulWidget {
  String thumb;

  String title;

  String contents;

  String appBarTitle;

  SpecificNewsWidget(
      {Key key, this.thumb, this.title, this.contents, this.appBarTitle})
      : super(key: key);

  @override
  _SpecificNewsWidgetState createState() {
    return _SpecificNewsWidgetState();
  }
}

class _SpecificNewsWidgetState extends State<SpecificNewsWidget> {
  @override
  void initState() {
    super.initState();
  }

  Color greyColor = Colors.grey[200];
  double circleInt = 10;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Image.asset(Res.wightbasketimage, fit: BoxFit.fill,),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: Container(),
              centerTitle: true,
              title: Text(
                "${widget.appBarTitle??""}",
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
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  Container(
                    //padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: widget.thumb != null && widget.thumb != ""
                                ? Image
                                .network(widget.thumb, fit: BoxFit.fill,)
                                .image
                                : Image
                                .asset(
                              "images/sideMenuLogo.png", fit: BoxFit.fill,)
                                .image,
                            fit: BoxFit.fill
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(circleInt),
                            topRight: Radius.circular(circleInt))),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 3,),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: greyColor,
                    alignment: Alignment.center,
                    child: getTitle("${widget.title}"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(circleInt),
                          bottomRight: Radius.circular(circleInt)),
                      color: greyColor,
                    ),
                    alignment: Alignment.center,
                    child: getBody("${widget.contents}"
                    ),
                  ),
                ],
              ),
            )
        ),
      ],
    );
  }
}