
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hi_market/basket_ball/domain/entities/get_listing_statitian_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_referee_conditions_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';

import '../../../../injection.dart';

class StatisticiansPage extends StatefulWidget {
  StatisticiansPage({Key key}) : super(key: key);

  @override
  _StatisticiansPageState createState() {
    return _StatisticiansPageState();
  }
}

class _StatisticiansPageState extends State<StatisticiansPage> {
  bool showStatistician = false;

  bool showConditions = false;

/*GetListingStatistianEntities getListingStatistianEntities = GetListingStatistianEntities(data: List());*/
GetRefereesConditionsEntities getRefereesConditionsEntities = GetRefereesConditionsEntities();

  bool showStatistian = false;

  getData()async{
 /*   var response = await sl<Cases>().listingStaisticians();
    if (response is GetListingStatistianEntities) {
      setState(() {
        getListingStatistianEntities = response;
      });
    } else if (response is ResponseModelFailure) {
      print(response.message);
    }   else {
      print("Connection Error");
    }*/
    var responseCondition = await sl<Cases>().refreesCondition();
    if (responseCondition is GetRefereesConditionsEntities) {
      setState(() {
        getRefereesConditionsEntities = responseCondition;
      });
    } else if (responseCondition is ResponseModelFailure) {
      print(responseCondition.message);
    }   else {
      print("Connection Error");
    }
  }

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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
          /*  SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                onTap: () {
                  setState(() {
                    showStatistian = !showStatistian;
                    if (showConditions) {
                      showConditions = !showConditions;
                    }
                  });
                },
                leading: Container(
                  width: 10,
                  height: 50,
                  color: Color(0xffE31E24),
                ),
                title: Text(
                  "إدارات الإتحاد",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                trailing: showStatistian?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
              ),
            ),
            ...getListingStatistianEntities.data.map((e) => showStatistian ? Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(height: MediaQuery.of(context).size.height / 5,
                        child: Image.network(e.newsThumb),
                      ),
                    ),
                    Expanded(
                        flex: 2
                        ,child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${e.title}",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Text("كود المدرب",style: TextStyle(color: Colors.grey),),
                            SizedBox(width: 20,),
                            Text("${e.code}",style: TextStyle(color: Colors.black),),

                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Text("الدرجة",style: TextStyle(color: Colors.grey),),
                            SizedBox(width: 20,),
                            Text("${e.degree}",style: TextStyle(color: Colors.black),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Text("الفرع",style: TextStyle(color: Colors.grey),),
                            SizedBox(width: 20,),
                            Text("${e.branch}",style: TextStyle(color: Colors.black),),
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ):Container()).toList(),
            SizedBox(
              height: 20,
            ),*/
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                onTap: () {
                  setState(() {
                    showConditions = !showConditions;
                    if (showStatistian) {
                      showStatistian = !showStatistian;
                    }
                  });
                },
                leading: Container(
                  width: 10,
                  height: 50,
                  color: Color(0xffE31E24),
                ),
                title: Text(
                  "الشروط",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                trailing: showConditions?Icon(Icons.keyboard_arrow_down):Icon(Icons.arrow_forward_ios),
              ),
            ),
            showConditions ? Container(
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
                  child: Html(data:getRefereesConditionsEntities?.data?.contents??"")),
            ):Container(),
          ],
        ),
      ),
    );
  }
}