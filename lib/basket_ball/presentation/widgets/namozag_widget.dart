import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';


import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_form_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/TileWidget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/view_pdf_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
//import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../../../injection.dart';
import '../../../main.dart';
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

  bool showProgress = false;
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
    return  LiquidPullToRefresh(
      onRefresh: ()async{
        getFormScreenEntities.data = [];
        Move.noBack(context: context,page:MyHomePage(
            getPosition: 1, chosenSelected: 2));
      },
      backgroundColor: Colors.white,
      color: staticColor,
      child: Stack(
        children: [
          Container(
              child: getFormScreenEntities.data.length != 0 ?getDataWidget(getFormScreenEntities):FutureBuilder(
                future:getForm, builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  print("snapshotError : ${snapshot.error}");
                  return errorContainer(context,(){
                    setState(() {
                      getForm = sl<Cases>().formScreenInitiation();
                    });
                  });
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
                      getFormScreenEntities = snapshot.data;
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
                      return errorContainer(context,(){
                        setState(() {
                          getForm = sl<Cases>().formScreenInitiation();
                        });
                      });
                    }
                    break;
                }
                return errorContainer(context,(){
                  setState(() {
                    getForm = sl<Cases>().formScreenInitiation();
                  });
                });
              },
              )
          ),
          showProgress ? getLoadingContainer(context):Container()
        ],
      ),
    );
  }

  getDataWidget(GetFormScreenEntities formScreenEntities){
    return Container(
      child: ListView.builder(itemCount: formScreenEntities.data.length,itemBuilder: (context,index){
        return  AnimatedContainer(
          duration: Duration(milliseconds: 50),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 5,),
                      Container(
                        width: 75,
                        height: 40,
                       decoration: BoxDecoration(
                         color: staticColor,
                         borderRadius: BorderRadius.circular(10)
                       ),child: TextButton.icon(icon:Icon(Icons.file_download,color: Colors.white,size: 15,), label: Text('تحميل',style: GoogleFonts.cairo(fontSize: 12,color: Colors.white),)  ,onPressed: () async {
                        if(formScreenEntities.data[index].attachmentUrl != ""){
                          var tempDir = await getTemporaryDirectory();
                          String fullPath = tempDir.path +
                              "${formScreenEntities.data[index].attachmentUrl.split("/").last}";
                          print('full path ${fullPath}');
                          setState(() {
                           showProgress = true;
                          });
                       bool done = await   download2(
                              Dio(),
                              formScreenEntities.data[index].attachmentUrl,
                              "${formScreenEntities.data[index].attachmentUrl.split("/").last}",
                              context);
                          if(done){
                                    setState(() {
                                      showProgress = false;
                                    });
                                  }
                                }else{
                          showToast(context, "لا يوجد ملف للتحميل");
                        }
                      },),),
                      SizedBox(width: 5,),
                      Container(
                        width: 75,
                         height: 40,
                         decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(10),
                                                 color: Colors.white,
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.grey.withOpacity(0.5),
                                                     blurRadius: 2.0,
                                                     spreadRadius: 0.0,
                                                     offset: Offset(
                                                         2.0, 2.0), // shadow direction: bottom right
                                                   )
                                                 ],
                                               ), child: TextButton.icon(icon:Icon(Icons.remove_red_eye,size: 15,color: Colors.black,),label: Text(
                        'إطلاع',style: GoogleFonts.cairo(color: Colors.black,fontSize: 12),
                      ),onPressed: () async {
                        Get.to(()=>ViewPdfWidget(url:formScreenEntities.data[index].attachmentUrl,title:formScreenEntities.data[index].title));
                      },),),
                    ],
                  ),
                  Expanded(child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TileWidget("${formScreenEntities.data[index].title}",isHtml: true,style:Style(fontSize: FontSize(12),fontWeight: FontWeight.bold))))
                ],
              ),
             SizedBox(height: 10,),
             /* index == dateIndex ?Directionality(
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
                    child: getBody(formScreenEntities.data[index].content*//*,padding: EdgeInsets.all(10)*//*,),
                  ),
                ),
              ):Container(),*/
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