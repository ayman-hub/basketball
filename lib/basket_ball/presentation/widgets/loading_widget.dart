import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'specific_news_widget.dart';

Widget loading() {
  return Lottie.asset('images/basketball_load.json');
  /*Center(
      child: JumpingText(
        'Loading',
        style: TextStyle(color: Colors.red, fontSize: 20),
      ))*/
  ;
}

Widget getLoadingContainer(BuildContext context) {
  return Container(
   // height: MediaQuery.of(context).size.height,
   // width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: loading(),
  );
}
bool pressed = true;

Widget errorContainer (BuildContext context, Function onTap){
  return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('!!خطأ في الأتصال',textAlign: TextAlign.center,style: GoogleFonts.cairo(color:Colors.black),),
        SizedBox(height: 20,),
        Expanded(
          child: Container(
              child: SvgPicture.asset("images/error.svg")),
        ),
        SizedBox(height: 10,),
        InkWell(onTap: (){
          if(pressed){
            print('isPressed');
                pressed = false;
               onTap.call();
                Future.delayed(Duration(seconds: 5),(){
                  pressed = true;
                });
              }
            }, child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: staticColor
          ),
          height: 48,
          width: 200,
          alignment: Alignment.center,
          child: Text('أعادة التحميل',textAlign: TextAlign.center,style: GoogleFonts.cairo(color: Colors.white),),
        )),
        SizedBox(height: 30,),
      ],
    ),
  );
}


errorDialog(BuildContext context)async{
   Get.dialog(
    DialogWidget()
  );
   Future.delayed(Duration(seconds: 1),(){
     Navigator.pop(context);
   });
}

class DialogWidget extends StatelessWidget {
  DialogWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        margin: EdgeInsets.only(right: 10,left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: 20,),
              Text('!!خطأ في الأتصال',textAlign: TextAlign.center,style: GoogleFonts.cairo(color:Colors.black,fontSize: 18),),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset("images/error.svg"))),
            ],
          ),
        ),
      ),
    );
  }
}

Widget backIconAction(Function onTap, {Color color}){
  return IconButton(onPressed: onTap, icon: Icon(Icons.arrow_forward,color:color?? Colors.black,));
}

NewsWidget({String title, String thumb, String date, String content, int id,BuildContext context}) {
  Color greyColor = Colors.grey[200];
  double circleInt = 10;
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        Container(
          //padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: thumb != null&& thumb != ""
                      ? Image.network(thumb,fit: BoxFit.fill,).image
                      : Image.asset("images/sideMenuLogo.png",fit: BoxFit.fill,).image,
                  fit: BoxFit.fill
              ),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(circleInt),topRight: Radius.circular(circleInt))),
          height: MediaQuery.of(context).size.height / 3,),
        Container(
          padding: EdgeInsets.all(10),
          color: greyColor,
          alignment: Alignment.center,
          child: getTitle("${title}"),
        ),
        Container(
          color: greyColor,
          alignment: Alignment.center,
          child: getBody(
            "${content.length > 100 ? "${content.substring(0, 100)}...." : content.toString()}",
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(circleInt),bottomRight: Radius.circular(circleInt)),
            color: greyColor,
          ),
          alignment: Alignment.bottomLeft,
          child: InkWell(
            onTap: (){
              Get.to(()=>SpecificNewsWidget(title: title,contents: content,thumb: thumb,appBarTitle:'أخر الأخبار'));
            },
            child: Container(height: 30,width: 100,alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: staticColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(circleInt))
              ),
              child: Text(
                'قراءه المزيد',style: GoogleFonts.cairo(color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
          ),

        ),
      ],
    ),
  );
}

getAlbumsWidget(context,{String mainPhoto, List<String> listThumbs, String title}) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Row(
            children: [
              Flexible(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                        ,image: DecorationImage(image: Image.network(
                          mainPhoto,
                          fit: BoxFit.fill,
                        ).image,fit: BoxFit.fill)
                    ),
                    height: MediaQuery.of(context).size.height / 3,
                    margin: EdgeInsets.all(2),)),
              Flexible(
                  child: Stack(
                    children: [
                      GridView.builder(
                        // padding: EdgeInsets.only(top: 10),
                          itemCount: listThumbs.length >
                              4
                              ? 4
                              : listThumbs.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              childAspectRatio: 0.9,
                              mainAxisSpacing: 2),
                          itemBuilder: (context, ind) {
                            return Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
                                  ,image: DecorationImage(
                                      image:  Image.network(
                                        listThumbs[ind],
                                        fit: BoxFit.fill,
                                      ).image,fit: BoxFit.fill
                                  )
                              ),
                            );
                          }),
                      Container(
                        decoration: BoxDecoration(),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )
                    ],
                  )),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
            color: Colors.white,
          ),
          child: getTitle(
              "$title",
              fontSize: 12
          ),
        )
      ],
    ),
  );
}

class CardWidget extends StatelessWidget {


  CardWidget({this.position,this.dateTime,this.imageLink,this.title,Key key}) : super(key: key);
  String imageLink;
  String dateTime;
  String position;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      color: Colors.white,
      height: 100,
      margin: EdgeInsets.all(10),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 10,
                color: staticColor,
              ),
              Container(
                // decoration: BoxDecoration(border:Border.all(color:Colors.black)),
                width: 100,
                height: 120,
                child: imageLink != ""?Image.network(imageLink,fit: BoxFit.fitHeight,):Image.asset("images/sideMenuLogo.png"),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    children: [
                      Text(
                        "$position",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(
                                context)
                                .size
                                .width /
                                27,
                            fontWeight:
                            FontWeight
                                .bold),
                      ),
                      Text(
                        "${title??""}",
                        style: TextStyle(
                            color: Colors.grey),
                      ),
                      SizedBox(height: 20,)
                    ],
                  )),
            ],
          ),
          dateTime == null || dateTime == ""?Container():   Container(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 30,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: staticColor,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Text("$dateTime",style: GoogleFonts.cairo(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}

getTextFieldDecoration(String s, {double radius, IconButton icon}) {
  return  InputDecoration(
      hintText: "$s",
      filled: true,
      fillColor: Colors.white,
      prefixIcon: icon,
      contentPadding:
      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(radius??5.0)),
      focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(radius??5.0)),
      enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(radius??5.0)),
      disabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(radius??5.0)),
      errorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(radius??5.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(radius??5.0)),
      labelStyle:
      TextStyle(fontWeight: FontWeight.w700));
}