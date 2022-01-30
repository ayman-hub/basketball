import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_albums_screen_entities.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../../../res.dart';
import 'go_to.dart';
import 'loading_widget.dart';

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

  //TransformerPageController   controller =  TransformerPageController();

  @override
  Widget build(BuildContext context) {
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
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leading: Container(),
              title: Text(
                "${widget.getAlbumScreenEntities.title}",
                style: GoogleFonts.cairo(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                ),
              ),
              actions: [
                backIconAction(() {
                  Get.back();
                })
              ],
            ),
            body: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: widget.getAlbumScreenEntities.thubmsUrls.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 5,mainAxisSpacing: 10),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: Image.network(widget.getAlbumScreenEntities.thubmsUrls[index],fit: BoxFit.fill,).image,fit: BoxFit.fill)
                  ),
                ),
              );
            }),
          ),
          selectedIndex != null?InkWell(
            onTap: (){
              setState(() {
                selectedIndex = null;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.5),
              child: TransformerPageView(
                itemCount: widget.getAlbumScreenEntities.thubmsUrls.length,
                duration: Duration(milliseconds: 50),
                index: selectedIndex,
                onPageChanged: (page) {
                  setState(() {
                    selectedIndex = page;
                    print(page);
                  });
                },
                scrollDirection: Axis.horizontal,
               // controller: controller,
                pageSnapping: true,
                loop: false,
                transformer: ShowTransformer(),
                itemBuilder: (context, index) {
                  return Container(
                    child: Image.network(widget.getAlbumScreenEntities.thubmsUrls[index],fit: BoxFit.fitWidth,),
                  );
                },
              )/*Container(
                child: Image.network(widget.getAlbumScreenEntities.thubmsUrls[selectedIndex],fit: BoxFit.fitWidth,),
              )*/,
            ),
          ):Container()
        ],
      ),
      bottomNavigationBar: getNavigationBar(context),
    );
  }

}

class ShowTransformer extends PageTransformer {
  @override
  Widget transform(Widget child, TransformInfo info) {
    var dim = info.position.isNegative ? info.position * -1 : info.position;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: child,
      margin: EdgeInsets.all(dim * 80),
    );
  }
}