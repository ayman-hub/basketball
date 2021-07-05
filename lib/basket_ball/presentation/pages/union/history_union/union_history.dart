
import 'package:flutter/material.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';

import 'achievement_page.dart';
import 'list_history_union.dart';

class UnionHistoryPage extends StatefulWidget {
  UnionHistoryPage({Key key}) : super(key: key);

  @override
  _UnionHistoryPageState createState() {
    return _UnionHistoryPageState();
  }
}

class _UnionHistoryPageState extends State<UnionHistoryPage> {
  int selected = 0 ;

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
      body: Container(
        child: Column(
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
                    offset: Offset(
                        2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selected = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:selected == 0 ? BorderRadius.circular(10):BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                          color: selected == 0 ?Colors.white:Color(0xffE31E24) ,
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text("تاريخ الإتحاد",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
                      ),
                    ),
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selected = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:selected == 1 ? BorderRadius.circular(10): BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                          color: selected == 1 ? Colors.white:Color(0xffE31E24),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text("الإنجازات",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              flex: 10,
              child: selected == 0 ? ListHistoryUnionPage():AchievementPage(),
            )
          ],
        ),
      ),
    );
  }
}