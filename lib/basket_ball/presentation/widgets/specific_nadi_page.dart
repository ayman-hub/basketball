import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/teams_screen_initation_entities.dart';
import 'package:hi_market/basket_ball/presentation/pages/nadi.dart';
import 'package:hi_market/basket_ball/presentation/widgets/getNavigationBar.dart';
import 'package:hi_market/main.dart';

import '../../../res.dart';
import 'loading_widget.dart';
import 'nadi_widget.dart';

class SpecificNadiPage extends StatefulWidget {
  SpecificNadiPage(
      {Key key, this.title, this.logo, this.teamID, this.name, this.showAhly})
      : super(key: key);
  String logo;
  String teamID;
  String name;
  showDataBoolean showAhly;
  String title;

  @override
  _SpecificNadiPageState createState() {
    return _SpecificNadiPageState();
  }
}

class _SpecificNadiPageState extends State<SpecificNadiPage> {
  Future futureMethod;

  Future futureTeamData;

  showDataBoolean showBoolean = showDataBoolean();

  bool active = false;

  @override
  void initState() {
    super.initState();
    print('getTitle::::: ${widget.title}');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            Res.wightbasketimage,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              centerTitle: true,
              leading: Container(),
              title: Text(
                "الأنديه",
                style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              actions: [
                backIconAction(() {
                  print('isActive Back::::: $active');
                  if(!active){
                    print('back');
                    Navigator.pop(context);
                  }else{
                    setState(() {
                      showBoolean = showDataBoolean();
                      active = false;
                    });
                  }
                })
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: [
                  NadiWidget(
                    name: "${widget.name}",
                    teamID: widget.teamID.toString(),
                    logo: widget.logo,
                    showBoolean: showBoolean ,
                    onChanged:((bool isActive){
                      print('isActive : $isActive');
                 setState(() {
                   active = isActive;
                 });
                    })
                  ),
                ],
              ),
            ),
            bottomNavigationBar: getNavigationBar(context)),
      ],
    );
  }

 /* getFutureData(
      GetTeamScreenInitiationEntities getTeamScreenInitiationEntities) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: getTeamScreenInitiationEntities?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            // height: MediaQuery.of(context).size.height / 15,
            child: Column(
              children: [
                NadiWidget(
                    name: "${widget.title}",
                    teamID: widget.teamID.toString(),
                    logo: widget.logo),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }*/
}
