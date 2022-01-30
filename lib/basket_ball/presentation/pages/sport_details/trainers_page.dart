import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_code_rules_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_listing_all_referees_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_referee_conditions_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/sport_details/sport_details.dart';
import 'package:hi_market/basket_ball/presentation/widgets/TileWidget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../../../../injection.dart';
import '../../../../res.dart';

class TrainersPage extends StatefulWidget {
  TrainersPage({Key key, this.onChange, this.active}) : super(key: key);
  ValueChanged<RefreePageEnum> onChange;
  RefreePageEnum active;

  @override
  _TrainersPageState createState() {
    return _TrainersPageState();
  }
}

class _TrainersPageState extends State<TrainersPage> {
  bool showProgress = false;

  int selectedIndex;

/*  GetListingAllRefereesEntities getListingAllRefereesEntities = GetListingAllRefereesEntities(data: List());*/
  getData() async {
    setState(() {
      showProgress = true;
    });
    var responseCondition = await sl<Cases>().coachesTermsConditions();
    setState(() {
      showProgress = false;
    });
    if (responseCondition is GetRefereesConditionsEntities) {
      setState(() {
        getRefereesConditionsEntitiesTrain = responseCondition;
        widget.active = RefreePageEnum.showTrainer;
        widget.onChange(widget.active);
      });
    } else if (responseCondition is ResponseModelFailure) {
      print(responseCondition.message);
    } else {
      print("Connection Error");
    }
    var responseRules = await sl<Cases>().coachesRules();
    if (responseRules is GetCoachesRulesEntities) {
      setState(() {
        getCoachesRulesEntities = responseRules;
      });
    } else if (responseRules is ResponseModelFailure) {
      print(responseRules.message);
    } else {
      print("Connection Error");
    }
  }


  @override
  void didUpdateWidget(TrainersPage oldWidget) {
    if(widget.active == RefreePageEnum.none){
      setState(() {
        selectedIndex = null;
      });
    }
  }

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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            ListView(
              children: [
               widget.active  == RefreePageEnum.showRules?Container(): Directionality(
                  textDirection: TextDirection.rtl,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 50),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (getRefereesConditionsEntitiesTrain.data ==
                                null) {
                              getData();
                            } else {
                              setState(() {
                                if (widget.active ==
                                    RefreePageEnum.showTrainer) {
                                  widget.active = RefreePageEnum.none;
                                } else {
                                  widget.active = RefreePageEnum.showTrainer;
                                }
                                widget.onChange(widget.active);
                              });
                            }
                          },
                          child: widget.active == RefreePageEnum.showTrainer ? getContainerSelected(  "شروط قيد المدربين") : TileWidget(
                            "شروط قيد المدربين",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.active == RefreePageEnum.showTrainer
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: getBody(
                            getRefereesConditionsEntitiesTrain.data.contents),
                      )
                    : Container(),
                SizedBox(
                  height:widget.active == RefreePageEnum.none? 20:0,
                ),
              widget.active == RefreePageEnum.showTrainer?Container():  Directionality(
                  textDirection: TextDirection.rtl,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 50),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (widget.active == RefreePageEnum.showRules) {
                                widget.active = RefreePageEnum.none;
                              } else {
                                widget.active = RefreePageEnum.showRules;
                              }
                              widget.onChange(widget.active);
                            });
                          },
                          child: widget.active == RefreePageEnum.showRules?getContainerSelected("قواعد تصنيف المدرب"): TileWidget(
                            "قواعد تصنيف المدرب",
                          ),
                        ),
                        getCoachesRulesEntities.data.length == 0 &&
                                widget.active == RefreePageEnum.showRules
                            ? getNoDataWidget()
                            : Column(
                                children: [
                                  ...getCoachesRulesEntities.data
                                      .asMap()
                                      .entries
                                      .map((e) => widget.active ==
                                              RefreePageEnum.showRules
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      if (selectedIndex ==
                                                          e.key) {
                                                        selectedIndex = null;
                                                      } else {
                                                        selectedIndex = e.key;
                                                      }
                                                    });
                                                  },
                                                  child: TileWidget(
                                                      "${e.value.title}"),
                                                ),
                                                selectedIndex == e.key
                                                    ? Container(
                                                  margin: EdgeInsets.only(top: 10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: getBody(
                                                            e.value.contents),
                                                      )
                                                    : Container(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            )
                                          : Container()),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            showProgress ? getLoadingContainer(context) : Container()
          ],
        ),
      ),
    );
  }

  getContainerSelected(String s) {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: staticColor,
        ),
        alignment: Alignment.center,
        height: 50,
        width: 150,
        child: Text('$s',style: GoogleFonts.cairo(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
