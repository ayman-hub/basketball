
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_decision_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../../injection.dart';
import '../../../../toast_utils.dart';

class UnionDecisionPage extends StatefulWidget {
  UnionDecisionPage({Key key}) : super(key: key);

  @override
  _UnionDecisionPageState createState() {
    return _UnionDecisionPageState();
  }
}

class _UnionDecisionPageState extends State<UnionDecisionPage> {
  Future getBoardDecision;
  int showIndex = 10000;

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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
     // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: FutureBuilder(
        future: getBoardDecision,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return loading();
              break;
            case ConnectionState.done:
              print("done");
              print("snapshot data :${snapshot.data}");
              if (snapshot.data is GetEtihadDecisionEntities) {
                print("done in");
                GetEtihadDecisionEntities getEtihadDecisionEntities = snapshot.data;
                print("getManagerToJson: ${getEtihadDecisionEntities.toJson()}");
                return ListView.builder(
                  itemCount: getEtihadDecisionEntities.data.length,
                  itemBuilder: (context,index){
                    print("here");
                    return  Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: ListTile(
                            onTap: (){
                              setState(() {
                                if (index == showIndex) {
                                  setState(() {
                                    showIndex = 10000;
                                  });
                                }else {
                                  setState(() {
                                    showIndex = index;
                                  });
                                }
                              });
                            },
                            leading:Container(width: 10,height: 50,color: Color(0xffE31E24),),
                            title: Text("${getEtihadDecisionEntities.data[index].title}",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
                            trailing: Icon(showIndex == index ?Icons.keyboard_arrow_down:Icons.arrow_forward_ios),
                          ),
                        ),
                        SizedBox(height: 10,),
                        showIndex == index ? Container(
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
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Html(data:"${getEtihadDecisionEntities.data[index].content}")),
                        ):Container()
                      ],
                    );
                  },
                );
              }else if (snapshot.data is ResponseModelFailure) {
                     if(snapshot.data is ResponseModelFailure){
                                                     ResponseModelFailure failure = snapshot.data;
                                                     var platform = Theme.of(context).platform;
                                                     platform == TargetPlatform.iOS
                                                         ? Get.snackbar("", "",
                                                         messageText: Text(
                                                           failure.message,
                                                           textAlign: TextAlign.center,
                                                         ))
                                                         : showToast(context,failure.message);
                                                   return IconButton(icon: Icon(Icons.refresh,color: Colors.white,size: 45,), onPressed:(){
                                                     setState(() {
                                                       getBoardDecision = sl<Cases>().getEtihadDecision();
                                                     });
                                                   });
                                                   }
              }
              break;
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
          }
          return IconButton(icon: Icon(Icons.refresh,color: Colors.white,size: 45,), onPressed:(){
            setState(() {
              getBoardDecision = sl<Cases>().getEtihadDecision();
            });
          });
        }
      ),
    );
  }

  void getData() {
    getBoardDecision=sl<Cases>().getEtihadDecision();
  }
}