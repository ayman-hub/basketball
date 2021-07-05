import 'package:flutter/material.dart';
import 'package:hi_market/injection.dart';

import '../../../res.dart';

class MatchResultWidget extends StatelessWidget {
  MatchResultWidget({Key key,@required this.time,@required this.date,@required this.fName,@required this.fLogo,@required this.fPoints,@required this.sLogo,@required this.sName,@required this.sPoints}) : super(key: key);
String fLogo;
String sLogo;
String fName;
String sName;
String fPoints;
String sPoints;
String date;
String time;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
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
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,width: 100,child: Image.network(fLogo),),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  child: Text("$fName",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                ),
              ],
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("$date",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                      SizedBox(height: 10,),
                      Text("$time",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w600,fontSize: 15),),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("$fPoints",style: TextStyle(color: Colors.red,fontSize: 20),),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white
                                ),
                                  padding: EdgeInsets.all(5),
                               /*   child: Text("30",style: TextStyle(color: Colors.white,fontSize: 20),)*/
                              )
                            ],
                          ),
                          Text("$sPoints",style: TextStyle(color: Colors.red,fontSize: 20),),
                        ],
                      ),
                    //  Text("$",style: TextStyle(color: Colors.grey),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 5,),
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,width: 100,child: Image.network(sLogo),),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  child: Text("$sName",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
