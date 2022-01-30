
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_listing_statitian_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_referee_conditions_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/sport_details/referee_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/TileWidget.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../injection.dart';
import 'sport_details.dart';

class StatisticiansPage extends StatefulWidget {
  StatisticiansPage({Key key,this.onChange,  this.active}) : super(key: key);
RefreePageEnum active;
ValueChanged<RefreePageEnum> onChange;
  @override
  _StatisticiansPageState createState() {
    return _StatisticiansPageState();
  }
}

class _StatisticiansPageState extends State<StatisticiansPage> {


bool showProgress = false;
  getData()async{
    setState(() {
      showProgress = true;
    });
    var responseCondition = await sl<Cases>().listingStaisticians();
    setState(() {
      showProgress = false;
    });
    if (responseCondition is GetListingStatistianEntities) {
      setState(() {
        getListingStatistianEntities = responseCondition;
          if(widget.active == RefreePageEnum.statictians){
            widget.active = RefreePageEnum.none;
          }else{
            widget.active = RefreePageEnum.statictians;
          }
          widget.onChange(widget.active);
      });

    } else if (responseCondition is ResponseModelFailure) {
      print(responseCondition.message);
    }   else {
     errorDialog(context);
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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: LiquidPullToRefresh(
              onRefresh: () async {
                setState(() {
                  getListingStatistianEntities = GetListingStatistianEntities(data: []);
                });
              },
              backgroundColor: Colors.white,
              color: staticColor,
              child: ListView(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: InkWell(
                      onTap: () {
                        if(getListingStatistianEntities.status == null){
                          getData();
                        }else{
                          setState(() {
                            if(widget.active == RefreePageEnum.statictians){
                              widget.active = RefreePageEnum.none;
                            }else{
                              widget.active = RefreePageEnum.statictians;
                            }
                            widget.onChange(widget.active);
                            print('aaaactive: ${widget.active}');
                          });
                        }
                      },
                      child: widget.active == RefreePageEnum.statictians?Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 113,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: staticColor,
                          ),
                          child: Text("قائمة الإحصائين",style: GoogleFonts.cairo(color: Colors.white),),
                        ),
                      ): TileWidget(
                        "قائمة الإحصائين",
                      ),
                    ),
                  ),
                  widget.active == RefreePageEnum.statictians ? Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    //padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ...getListingStatistianEntities.data.map((e) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            height: 150,
                          //  margin: EdgeInsets.only(bottom: 10),
                            child: CardWidget(
                              position: e.title,
                              title: e.code,
                              imageLink: e.newsThumb,
                              dateTime: e.branch,
                            ),
                          ),
                        )).toList()
                      ],
                    ),
                  ):Container(),
                ],
              ),
            ),
          ),
          showProgress ?getLoadingContainer(context):Container()
        ],
      ),
    );
  }
}