import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/domain/entities/get_albums_screen_entities.dart';

import '../../../res.dart';
import 'go_to.dart';

class ShowImagePage extends StatefulWidget {
  ShowImagePage({Key key,@required this.getAlbumScreenEntities}) : super(key: key);
GetAlbumScreenEntitiesData getAlbumScreenEntities =  GetAlbumScreenEntitiesData();
  @override
  _ShowImagePageState createState() {
    return _ShowImagePageState();
  }
}

class _ShowImagePageState extends State<ShowImagePage> {
  int selectedIndex ;
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
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              Res.wightbasketimage,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 15 ,),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Text("${widget.getAlbumScreenEntities.title}",style: GoogleFonts.cairo(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),textAlign: TextAlign.center,),
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Image.network(selectedIndex != null?widget.getAlbumScreenEntities.thubmsUrls[selectedIndex]:widget.getAlbumScreenEntities.albumThumb,fit: BoxFit.fill,),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 150,
                  child: ListView.builder(
                    itemCount: widget.getAlbumScreenEntities.thubmsUrls.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        height: 150 ,
                        width:  150,
                        margin: EdgeInsets.only(left: 20),
                        child: Image.network(widget.getAlbumScreenEntities.thubmsUrls[index],fit: BoxFit.fill,),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  onPressed: () => Move.back(context),
                  child: Container(
                    // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 12,
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 19,
                      width: MediaQuery.of(context).size.height / 19,
                      child: CircleAvatar(
                        backgroundColor: Color(0xffE31E24),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}