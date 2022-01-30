import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/image_widget_list.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/namozag_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/videos_widget_list.dart';
import 'package:hi_market/main.dart';

import '../../../res.dart';
import 'main_page.dart';

class LiberaryPage extends StatefulWidget {
  LiberaryPage({Key key,@required this.chosenSelected}) : super(key: key);
int chosenSelected;
  @override
  _LiberaryPageState createState() {
    return _LiberaryPageState();
  }
}

class _LiberaryPageState extends State<LiberaryPage> {
  int selected = 0;

  @override
  void initState() {
    super.initState();
    selected = widget.chosenSelected??0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       Get.off(MyHomePage(),transition: Transition.fadeIn);
        return false;
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              Res.wightbasketimage,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              centerTitle: true,
              leading: Container(),
              title: Text(
                "المكتبة",
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
            body: Column(
              children: [
                Container(
                  //  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffE31E24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: selected == 0 ? BorderRadius.circular(10):BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: selected == 0 ? Colors.white:Color(0xffE31E24),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "ألبوم الصور",
                              style: TextStyle(
                                  color:  selected == 0 ?Colors.black:Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: selected == 1
                                  ? BorderRadius.circular(10)
                                  : BorderRadius.only(
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0)),
                              color: selected == 1
                                  ? Colors.white
                                  : Color(0xffE31E24),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "الفيديوهات",
                              style: TextStyle(
                                  color: selected == 1 ?Colors.black:Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selected = 2;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: selected == 2
                                  ? BorderRadius.circular(10)
                                  : BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                              color: selected == 2
                                  ? Colors.white
                                  : Color(0xffE31E24),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "النماذج",
                              style: TextStyle(
                                  color:  selected == 2 ?Colors.black:Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: selected == 0
                      ? ImageWidgetList()
                      : (selected == 1 ? VideosWidgetList() : NamozagWidget()),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
