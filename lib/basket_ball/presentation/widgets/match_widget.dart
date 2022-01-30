
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_matches_entities.dart';

class MatchWidget extends StatelessWidget {
  MatchWidget({Key key,@required this.getHomePageMatchesData,this.text}) : super(key: key);
GetHomePageMatchesData getHomePageMatchesData;
String text;
Color firstTeam = staticColor;
Color secondTeam = staticColor;
  @override
  Widget build(BuildContext context) {
   try{
     firstTeam = (int.parse(getHomePageMatchesData.points?.first??"0") > int.parse(getHomePageMatchesData.points?.last??"0")  )?Colors.green:staticColor;
     secondTeam = (int.parse(getHomePageMatchesData.points?.last??"0") > int.parse(getHomePageMatchesData.points?.first??"0")  )?Colors.green:staticColor;
   }catch(e){
     print('e');
   }
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
      //  border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
    /*    boxShadow: [
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 15,width: 100,child: Image.network(getHomePageMatchesData.teams[0].thumb),),
                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: Text("${getHomePageMatchesData.teams[0].name}",textAlign: TextAlign.center,style: GoogleFonts.cairo(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10),),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5,),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text("${text??"اليوم"}",style: GoogleFonts.cairo(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${getHomePageMatchesData.time}",style: GoogleFonts.cairo(color: Colors.black,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width / 40),),
                          //Text(" PM",style: GoogleFonts.cairo()(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${getHomePageMatchesData.points?.first??""}",style: GoogleFonts.cairo(color: firstTeam,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width / 40),),
                          Text("${getHomePageMatchesData.points?.last??""}",style: GoogleFonts.cairo(color: secondTeam,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width / 40),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5,),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:  MediaQuery.of(context).size.height / 15,width: 100,child: Image.network(getHomePageMatchesData.teams[1].thumb),),
                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: Text("${getHomePageMatchesData.teams[1].name}",textAlign: TextAlign.center,style: GoogleFonts.cairo(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 10),),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Flexible(
            child: Container(
              alignment: Alignment.center,
              child: Text("${getHomePageMatchesData.title}",style: GoogleFonts.cairo(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: MediaQuery.of(context).size.width / 35),maxLines: 1,textAlign: TextAlign.center,),
            ),
          ),
        ],
      ),

    );
  }
}

