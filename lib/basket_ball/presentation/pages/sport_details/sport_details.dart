import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/presentation/pages/sport_details/referee_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/sport_details/statisticians_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/sport_details/trainers_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/main.dart';

import '../../../../res.dart';
import '../main_page.dart';

enum RefreePageEnum { condition, reference, statictians,showTrainer,showRules,none, }

class SportDetailsPage extends StatefulWidget {
  SportDetailsPage({Key key}) : super(key: key);

  @override
  _SportDetailsPageState createState() {
    return _SportDetailsPageState();
  }
}

class _SportDetailsPageState extends State<SportDetailsPage> {
  int selected = 0;

  RefreePageEnum active = RefreePageEnum.none;

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
    return Stack(
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
            centerTitle: true,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: Container(),
            title: Text(
              "عناصر اللعبة",
              style: GoogleFonts.cairo(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            actions: [
              backIconAction(() {
                if (active != RefreePageEnum.none) {
                  setState(() {
                    active = RefreePageEnum.none;
                    print('active:: $active');
                  });
                } else {
                  Move.to(context: context, page: MyHomePage());
                }
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
                            borderRadius: selected == 0
                                ? BorderRadius.circular(10)
                                : BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                            color: selected == 0
                                ? Colors.white
                                : Color(0xffE31E24),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "الحكام",
                            style: TextStyle(
                                color:
                                    selected == 0 ? Colors.black : Colors.white,
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
                            "الإحصائيين",
                            style: TextStyle(
                                color:
                                    selected == 1 ? Colors.black : Colors.white,
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
                            "المدربين",
                            style: TextStyle(
                                color:
                                    selected == 2 ? Colors.black : Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                /*Stack(
                  children: [
                    selected == 0 ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width / 3.5,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "ألبوم صور",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ):(selected == 1 ?Positioned(
                      left: MediaQuery.of(context).size.width / 3.3,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.2,
                        //margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3.8,left: MediaQuery.of(context).size.width / 3.8 ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "الفديوهات",
                          style: TextStyle(
                              color:Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ):Positioned(
                      left: MediaQuery.of(context).size.width / 1.51,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Colors.white,
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "النماذج",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
                  ],
                ),*/
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 8,
                child: selected == 0
                    ? RefereePage(
                        onChange: (RefreePageEnum Active) {
                          print('isActive :: ${Active}');
                          setState(() {
                            active = Active;
                          });
                        },
                        active: active,
                      )
                    : (selected == 1
                        ? StatisticiansPage(
                            onChange: (RefreePageEnum Active) {
                              print('isActive :: ${Active}');
                              setState(() {
                                active = Active;
                              });
                            },
                            active: active,
                          )
                        : TrainersPage(
                  onChange: (RefreePageEnum Active) {
                    print('isActive :: ${Active}');
                    setState(() {
                      active = Active;
                    });
                  },
                  active: active,
                )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
