import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_table.dart';
import 'package:hi_market/basket_ball/presentation/pages/main_page.dart';

import '../../../res.dart';
import 'go_to.dart';

class ListTeamWidget extends StatefulWidget {
  ListTeamWidget({Key key,@required this.getHomePageTableEntities}) : super(key: key);
GetHomePageTableEntities getHomePageTableEntities;
  @override
  _ListTeamWidgetState createState() {
    return _ListTeamWidgetState();
  }
}

class _ListTeamWidgetState extends State<ListTeamWidget> {
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
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(Res.wightbasketimage,fit: BoxFit.fill,),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: MediaQuery.of(context).size.height / 15,
                  padding: EdgeInsets.only(bottom: 10),
                  child: IconButton(
                      icon: Image.asset(Res.backimage,color: Color(0xffE31E24),),
                      onPressed: () {
                      return Get.back();
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(10),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Table(
                      columnWidths: {
                        2:FixedColumnWidth(0.5)
                      },
                      children: [
                        TableRow(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    "الترتيب",
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width / 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text("  الفريق",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ),
                                SizedBox(),
                                Expanded(
                                  flex: 2,
                                  child: Text("  فوز",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ),
                      Expanded(

                                  flex: 2,
                                  child: Text("  هزيمة",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text("نقاط",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ...widget.getHomePageTableEntities.data.map((e) {
                  int i = 0 ;
                  for(int x= 0 ; x< widget.getHomePageTableEntities.data.length; x++){
                    if (e.name == widget.getHomePageTableEntities.data[x].name) {
                      i = x+1;
                    }
                  }
                  return Container(
                    color: i == 1 ?Color(0xffE31E24):i %2 == 0 ?Colors.white:Colors.grey[100],
                    padding: EdgeInsets.all(10),
                    //margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 20,left: MediaQuery.of(context).size.width / 20),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Table(
                       // defaultColumnWidth: FixedColumnWidth(1),
                        children: [
                          TableRow(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                child: Text(
                                  "${i}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                //decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                child: Text("${e.name}",
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                              ),
                              Container(
                                //decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                child: Text("${e.w}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),textAlign: TextAlign.left,),
                              ),
                              Container(
                                //decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                child: Text("${e.l}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),textAlign: TextAlign.left,),
                              ),
                              Container(
                                //decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                                child: Text("${e.gb}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),textAlign: TextAlign.left,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },).toList(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}