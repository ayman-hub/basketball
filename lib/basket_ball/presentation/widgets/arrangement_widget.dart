import 'package:flutter/material.dart';

class ArrangementWidget extends StatelessWidget {
  ArrangementWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
       padding: EdgeInsets.all(10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Text("2",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            ),
            Flexible(
              flex: 3,
              child: Text("الزمالك",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
            ),
            Flexible(
              flex: 1,
              child: Text("10",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
            ),
            Flexible(
              flex: 2,
              child: Text("3",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
            ),
            Flexible(
              flex: 2,
              child: Text("7",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
            ),
            Flexible(
              flex: 2,
              child: Text("24",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
