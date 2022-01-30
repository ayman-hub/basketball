import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_listing_all_referees_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_referee_conditions_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/referee_reference_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/sport_details/sport_details.dart';
import 'package:hi_market/basket_ball/presentation/widgets/TileWidget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/view_pdf_widget.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../injection.dart';
import '../../../../toast_utils.dart';

class RefereePage extends StatefulWidget {
  RefereePage({Key key,  this.onChange,this.active}) : super(key: key);
ValueChanged<RefreePageEnum> onChange;
RefreePageEnum active;
  @override
  _RefereePageState createState() {
    return _RefereePageState();
  }
}

class _RefereePageState extends State<RefereePage> {

/*
  GetListingAllRefereesEntities getListingAllRefereesEntities =
      GetListingAllRefereesEntities(data: List());*/


  bool showProgress = false;


  @override
  void didUpdateWidget(RefereePage oldWidget) {
    print('update Widgets');
    getActive();
  }

  getActive(){
  print('getActive: ${widget.active}');
  setState(() {

  });
}
  @override
  void initState() {
    super.initState();
   getActive();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            ListView(
              children: [
             widget.active == RefreePageEnum.reference ?Container():   Directionality(
                  textDirection: TextDirection.rtl,
                  child: InkWell(
                    onTap: () async{
                      if(getRefereesConditionsEntities.data == null){
                        setState(() {
                          showProgress = true;
                        });
                        var responseCondition = await sl<Cases>().refreesCondition();
                        setState(() {
                          showProgress = false;
                        });
                        if (responseCondition is GetRefereesConditionsEntities) {
                          setState(() {
                            if(widget.active == RefreePageEnum.condition){
                              widget.active = RefreePageEnum.none;
                            }else{
                              widget.active = RefreePageEnum.condition;
                            }
                            widget.onChange(widget.active);
                          });
                          setState(() {
                            getRefereesConditionsEntities = responseCondition;
                          });
                        } else if (responseCondition is ResponseModelFailure) {
                          print(responseCondition.message);
                        } else {
                          errorDialog(context);
                        }
                      }else{
                        setState(() {
                          if(widget.active == RefreePageEnum.condition){
                            widget.active = RefreePageEnum.none;
                          }else{
                            widget.active = RefreePageEnum.condition;
                          }
                          widget.onChange(widget.active);
                        });
                      }

                    },
                    child: widget.active == RefreePageEnum.condition ?Container(
                      alignment: Alignment.centerRight,
                      child:Container(
                        width: 133,
                          height: 50,
                          margin: EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: staticColor
                          ),
                          child:Text("شروط قيد الحكام",style: GoogleFonts.cairo(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w500),)) ,
                    ):TileWidget(
                      "شروط قيد الحكام",
                    ),
                  ),
                ),
                widget.active == RefreePageEnum.condition
                    ? Container(
                        decoration: BoxDecoration(
                        //  borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                       // padding: EdgeInsets.all(10),
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: getBody(
                                  getRefereesConditionsEntities?.data?.contents ?? "",
                            )),
                      )
                    : Container(),
                SizedBox(height: widget.active != RefreePageEnum.none ?0:10,),
             widget.active == RefreePageEnum.condition? Container():  AnimatedContainer(
                  duration: Duration(milliseconds: 50),
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: InkWell(
                          onTap: ()async {
                            if(refereeReferenceEntities.data == null){
                       getRefreeMethod((){
                                      setState(() {
                                        if (widget.active ==
                                            RefreePageEnum.reference) {
                                          widget.active = RefreePageEnum.none;
                                        } else {
                                          widget.active =
                                              RefreePageEnum.reference;
                                        }
                                        widget.onChange(widget.active);
                                      });
                                    });
                            }else{
                              setState(() {
                                if(widget.active == RefreePageEnum.reference){
                                  widget.active = RefreePageEnum.none;
                                }else{
                                  widget.active = RefreePageEnum.reference;
                                }
                                widget.onChange(widget.active);
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TileWidget( "مرجع الحكم"))),
                              Row(
                                children: [
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
                       getRefreeMethod((){
                                      Get.to(()=>ViewPdfWidget(url:refereeReferenceEntities.data.url,title: "مرجع الحكم"));
                       });
                                  },),),
                                  SizedBox(width: 5,),
                                  Container(
                                    width: 75,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: staticColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),child: TextButton.icon(icon:Icon(Icons.file_download,color: Colors.white,size: 15,), label: Text('تحميل',style: GoogleFonts.cairo(fontSize: 12,color: Colors.white),)  ,onPressed: () async {
                                  getRefreeMethod(()async{
                                    if(refereeReferenceEntities.data.url != ""){
                                      var tempDir = await getTemporaryDirectory();
                                      String fullPath = tempDir.path +
                                          "${refereeReferenceEntities.data.url.split("/").last}";
                                      print('full path ${fullPath}');
                                      setState(() {
                                        showProgress = true;
                                      });
                                      bool done = await download2(
                                          Dio(),
                                          refereeReferenceEntities.data.url,
                                          "${refereeReferenceEntities.data.url.split("/").last}",
                                          context);
                                      if(done){
                                        setState(() {
                                          showProgress = false;
                                        });
                                      }
                                    }else{
                                      showToast(context, "لا يوجد ملف للتحميل");
                                    }
                                  });
                                  },),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      widget.active == RefreePageEnum.reference
                          ? Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                // height: MediaQuery.of(context).size.height / 1.5,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                   // borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  //padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  child: getBody(
                                   refereeReferenceEntities.data?.text??"",
                                  /*  padding: EdgeInsets.all(10),*/
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
            showProgress ?getLoadingContainer(context):Container()
          ],
        ),
      ),
    );
  }

  void getRefreeMethod( Function onTap) async{
    if(refereeReferenceEntities.data == null){
      setState(() {
        showProgress = true;
      });
      var responseReference = await sl<Cases>().refereeReference();
      setState(() {
        showProgress = false;
      });
      if (responseReference is RefereeReferenceEntities) {
        setState(() {
          print('data::: ${responseReference.data.toJson()}');
          refereeReferenceEntities.data = RefreeReferenceData(text: "",url: "");
          refereeReferenceEntities.data.text = responseReference?.data?.text??"";
          refereeReferenceEntities.data.url = responseReference?.data?.url??"";
        });
        onTap.call();
      } else if (responseReference is ResponseModelFailure) {
        print(responseReference.message);
      }
    }else{
      onTap.call();
    }
  }
}
