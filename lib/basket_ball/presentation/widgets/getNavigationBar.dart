import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../res.dart';
import 'bar/bottom_bar.dart';

getFancyNavigationBar(int position) {
  return FancyBottomNavigation(
    //backgroundColor:Color(0xffE31E24),
    //type: BottomNavigationBarType.fixed,
    barBackgroundColor: Color(0xffE31E24),
    initialSelection: 6,
    textColor: Colors.white,
    borderColor: getSelectedColor(position),
    tabs: <TabData>[
      TabData(
          icon: InkWell(
              onTap: (){

              },
              child: Image.asset(Res.nadiimage,scale: 20,color: Colors.white,)),
          title:  'الأندية'
      ),
      TabData(
          icon: Image.asset(
            Res.liberaryimage,
            color: Colors.white ,
            // size: snap.data == 1 ? 30 : 25,
            scale: 20,
          ),
          title: "المكتبات"
      ),
      TabData(
          icon: Image.asset(
            Res.gameimage,
            color: Colors.white,
            //  size: snap.data == 2 ? 30 : 25,
            scale: 20,
          ),
          title:  'عناصر اللعبة'
      ),
      TabData(
          icon: Image.asset(
            Res.competitionimage,
            color: Colors.white ,
            scale: 20,
          ),
          title:  'المسابقات'
      ),
      TabData(
          icon: Icon(Icons.home,color: Colors.white,),
          title:  'الرئيسية'
      ),
      /*  BottomNavigationBarItem(
                icon: Image.asset(
                  Res.liberaryimage,
                  color: Colors.white ,
                  // size: snap.data == 1 ? 30 : 25,
                  scale: 18,
                ),
                title: Text(
                  "المكتبات",
                  style: TextStyle(
                      color:Colors.white,
                      fontSize:MediaQuery.of(context).size.width / 26),
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Res.gameimage,
                  color: Colors.white,
                  //  size: snap.data == 2 ? 30 : 25,
                  scale: 18,
                ),
                title: Text(
                  'عناصر اللعبة',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 26),
                ),
              ),
              BottomNavigationBarItem(
                icon:Image.asset(
                  Res.competitionimage,
                  color: Colors.white ,
                  scale: 18,
                ),
                title: Text(
                  'المسابقات',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 26),
                ),
              ),*/
    ],
  /*  onTabChangedListener: (int) {
      setState(() {
        print(int);
        position = int;
      });
    },*/
  );
}

getSelectedColor(int position) {
  borderColor = position == 4 ?Colors.white:Color(0xffc9c9c9);
  return position == 4 ?Colors.white:Color(0xffc9c9c9);
}