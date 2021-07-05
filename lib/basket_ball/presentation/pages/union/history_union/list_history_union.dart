
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_histories_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';

import '../../../../../injection.dart';
import '../../../../../toast_utils.dart';

class ListHistoryUnionPage extends StatefulWidget {
  ListHistoryUnionPage({Key key}) : super(key: key);

  @override
  _ListHistoryUnionPageState createState() {
    return _ListHistoryUnionPageState();
  }
}

class _ListHistoryUnionPageState extends State<ListHistoryUnionPage> {
  Future getEtihadHistory;

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
   return Container(
        child: FutureBuilder(
          future:getEtihadHistory?? sl<Cases>().getEtihadHistoreies(), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
              if (snapshot.data is GetEtihadHistoriesEntities) {
                return getData(snapshot.data);
              }  else if (snapshot.data is ResponseModelFailure) {
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
                      getEtihadHistory = sl<Cases>().getEtihadHistoreies();
                    });
                  });
                }
              }
              break;
          }
          return Container();
        },
        )
    );
  }
  getData(GetEtihadHistoriesEntities getEtihadHistoriesEntities){
    return Container(
      child:  ListView.builder(itemCount: getEtihadHistoriesEntities.data.length,itemBuilder: (context,index){
        return Container(
         // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Html(data:"${getEtihadHistoriesEntities.data[index].content}")),
              ),
              Flexible(
                child:Container(
                    padding: EdgeInsets.only(top: 30,bottom: 30),
                    child:Icon(Icons.arrow_back,color: Color(0xffE31E24),))),
              Flexible(child: Center(child: Text("${getEtihadHistoriesEntities.data[index].title}")),)
            ],
          ),
        );
      }),
    );
  }
}