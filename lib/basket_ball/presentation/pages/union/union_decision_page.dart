import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_decision_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/TileWidget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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
  int showIndex;

  bool refresh = true;

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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: getEtihadDecisionEntities.status != null && refresh?getWidgetData(getEtihadDecisionEntities):FutureBuilder(
          future: getBoardDecision,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return errorContainer(context, () {
              getData();
              });
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return loading();
                break;
              case ConnectionState.done:
                print("done");
                print("snapshot data :${snapshot.data}");
                if (snapshot.data is GetEtihadDecisionEntities) {
                  print("done in");
                  getEtihadDecisionEntities = snapshot.data;
                  print(
                      "getManagerToJson: ${getEtihadDecisionEntities.toJson()}");
                  return getWidgetData(getEtihadDecisionEntities);
                } else if (snapshot.data is ResponseModelFailure) {
                  if (snapshot.data is ResponseModelFailure) {
                    ResponseModelFailure failure = snapshot.data;
                    var platform = Theme.of(context).platform;
                    platform == TargetPlatform.iOS
                        ? Get.snackbar("", "",
                            messageText: Text(
                              failure.message,
                              textAlign: TextAlign.center,
                            ))
                        : showToast(context, failure.message);
                    return errorContainer(context, () {
                   getData();
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
            return errorContainer(context, () {
             getData();
            });
          }),
    );
  }

  void getData() {
    setState(() {
      getBoardDecision = sl<Cases>().getEtihadDecision();
    });
  }

  Widget getWidgetData(GetEtihadDecisionEntities getEtihadDecisionEntities) {
    return LiquidPullToRefresh(
      onRefresh: () async {
        setState(() {
          refresh = false;
          getData();
        });

      },
      backgroundColor: Colors.white,
      color: staticColor,
      child: ListView.builder(
        itemCount: getEtihadDecisionEntities.data.length,
        itemBuilder: (context, index) {
          print("here");
          return Column(
            children: [
            (showIndex != null && showIndex != index)?Container():  Directionality(
                textDirection: TextDirection.rtl,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (index == showIndex) {
                        setState(() {
                          showIndex = null;
                        });
                      } else {
                        setState(() {
                          showIndex = index;
                        });
                      }
                    });
                  },
                  child: TileWidget("${getEtihadDecisionEntities.data[index].title}",
                ),
              )),
              SizedBox(
                height: showIndex == null ? 10:0,
              ),
              showIndex == index
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      /*  boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],*/
                      ),
                      padding: EdgeInsets.all(10),
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: getBody(
                              "${getEtihadDecisionEntities.data[index].content}")),
                    )
                  : Container()
            ],
          );
        },
      ),
    );
  }
}
