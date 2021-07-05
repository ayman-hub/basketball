import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_form_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
//import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../../../injection.dart';
import '../../../toast_utils.dart';
import 'loading_widget.dart';

class NamozagWidget extends StatefulWidget {
  NamozagWidget({Key key}) : super(key: key);

  @override
  _NamozagWidgetState createState() {
    return _NamozagWidgetState();
  }
}

class _NamozagWidgetState extends State<NamozagWidget> {
  int dateIndex ;

  Future getForm;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: FutureBuilder(
          future:getForm, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            print("snapshotError : ${snapshot.error}");
          }
          switch(snapshot.connectionState) {

            case ConnectionState.none:
            // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              return loading();
              break;
            case ConnectionState.active:
            // TODO: Handle this case.
              break;
            case ConnectionState.done:
              if (snapshot.data is GetFormScreenEntities) {
                return getDataWidget(snapshot.data);
              }  else  if(snapshot.data is ResponseModelFailure){
                ResponseModelFailure failure = snapshot.data;
                var platform = Theme.of(context).platform;
                platform == TargetPlatform.iOS
                    ? Get.snackbar("", "",
                    messageText: Text(
                      failure.message,
                      textAlign: TextAlign.center,
                    ))
                    : showToast(context,failure.message);
                return IconButton(icon: Icon(Icons.refresh,color: Colors.red,size: 45,), onPressed:(){
                  setState(() {
                    getForm = sl<Cases>().formScreenInitiation();
                  });
                });
              }
              break;
          }
          return IconButton(icon: Icon(Icons.refresh,color: Colors.red,size: 45,), onPressed:(){
            setState(() {
              getForm = sl<Cases>().formScreenInitiation();
            });
          });
        },
        )
    );
  }

  getDataWidget(GetFormScreenEntities formScreenEntities){
    return Container(
      child: ListView.builder(itemCount: formScreenEntities.data.length,itemBuilder: (context,index){
        return  AnimatedContainer(
          duration: Duration(milliseconds: 50),
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  onTap: (){
                    setState(() {
                      if(dateIndex == index){
                        dateIndex = null;
                      }else {
                        dateIndex = index;
                      }
                    });
                  },
                  leading:Container(width: 10,height: 50,color: Colors.red,),
                  title: Text("${formScreenEntities.data[index].title}",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
                  trailing: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.red,child: InkWell(child:Icon(Icons.file_download,color: Colors.white,),   onTap: () async {
                    var tempDir = await getTemporaryDirectory();
                    String fullPath = tempDir.path + "${formScreenEntities.data[index].attachmentUrl.split("/").last}";
                    print('full path ${fullPath}');
                    download2(Dio(),formScreenEntities.data[index].attachmentUrl,  "${formScreenEntities.data[index].attachmentUrl.split("/").last}",context);
                  },),),
                ),
              ),
              index == dateIndex ?Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                 // height: MediaQuery.of(context).size.height / 1.5,
                  child: Container(
                     decoration: BoxDecoration(
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
                    width: MediaQuery.of(context).size.width,
                    child: HtmlWidget(formScreenEntities.data[index].content/*,padding: EdgeInsets.all(10)*/,),
                  ),
                ),
              ):Container(),
            ],
          ),
        );
      }),
    );
  }

  void getData() {
    getForm = sl<Cases>().formScreenInitiation();
  }



}