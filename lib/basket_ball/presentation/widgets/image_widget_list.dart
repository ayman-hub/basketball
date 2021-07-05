import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/get_albums_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/show_image_page.dart';

import '../../../injection.dart';
import '../../../toast_utils.dart';
import 'loading_widget.dart';

class ImageWidgetList extends StatefulWidget {
  ImageWidgetList({Key key}) : super(key: key);

  @override
  _ImageWidgetListState createState() {
    return _ImageWidgetListState();
  }
}

class _ImageWidgetListState extends State<ImageWidgetList> {
  Future getalbumsImage;
  GetAlbumScreenEntities getAlbumScreenEntities = GetAlbumScreenEntities(data: List());
  ScrollController scrollController = ScrollController();

  getAddMostViewData() async {
      setState(() {
        getMoreNews = false;
      });
      var response = await sl<Cases>()
          .albumsScreenLoadMore(scrollController.offset.toString());
      setState(() {
        getMoreNews = true;
      });
      if (response is GetAlbumScreenEntities) {
        if (response.data.last.id !=
            getAlbumScreenEntities.data.last.id) {
          setState(() {
            getAlbumScreenEntities.data.addAll(response.data);
          });
        }
      } else if (response is ResponseModelFailure) {
        setState(() {
          getMoreNews = false;
        });
        print(response.message);
      } else {
        setState(() {
          getMoreNews = false;
        });
        print("connection error");
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
    return Container(
        child: FutureBuilder(
      future: getalbumsImage,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          print("snapshotError : ${snapshot.error}");
        }
        if (snapshot.hasData){
          if (snapshot.data is GetAlbumScreenEntities) {
            return showImagesStyleWidget(snapshot.data);
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
              return IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 45,
                  ),
                  onPressed: () {
                    setState(() {
                      getalbumsImage = sl<Cases>().albumsScreenInitiation();
                    });
                  });
            }
          } else {
            return IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 45,
                ),
                onPressed: () {
                  setState(() {
                    getalbumsImage = sl<Cases>().albumsScreenInitiation();
                  });
                });
          }
        }
        return loading();
      },
    ));
  }

  showImagesStyleWidget(GetAlbumScreenEntities getAlbumScreen) {
    if(getAlbumScreenEntities.data.length == 0){
      getAlbumScreenEntities = getAlbumScreen;
    }
    return NotificationListener<ScrollNotification>(
      onNotification: _getAlbumsMore,
      child: ListView.builder(
        controller: scrollController,
        itemCount: getAlbumScreenEntities.data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Move.to(
                  context: context,
                  page: ShowImagePage(
                      getAlbumScreenEntities:
                          getAlbumScreenEntities.data[index]));
            },
            child: Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    leading: Container(
                      width: 10,
                      height: 50,
                      color: Colors.red,
                    ),
                    title: HtmlWidget(
                      "${getAlbumScreenEntities.data[index].title}",
                      /*style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),*/
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.width / 2,
                  // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    children: [
                      Flexible(
                          child: Stack(
                            children: [
                              GridView.builder(
                                  itemCount: getAlbumScreenEntities
                                              .data[index].thubmsUrls.length > 4 ? 4
                                      : getAlbumScreenEntities
                                          .data[index].thubmsUrls.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 2,
                                          childAspectRatio: 0.94,
                                          mainAxisSpacing: 2),
                                  itemBuilder: (context, ind) {
                                    return Image.network(
                                      getAlbumScreenEntities
                                          .data[index].thubmsUrls[ind],
                                      fit: BoxFit.fill,
                                    );
                                  }),
                              Container(
                                decoration: BoxDecoration(/*border:Border.all(color:Colors.black)*/),

                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                              )
                            ],
                          )),
                      Flexible(
                          child: Container(
                              //  decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                              height: MediaQuery.of(context).size.width / 2,
                              padding: EdgeInsets.all(2),
                              child: Image.network(
                                getAlbumScreenEntities.data[index].albumThumb,
                                fit: BoxFit.fill,
                              ))),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
  bool getMoreNews = true;
  bool _getAlbumsMore(ScrollNotification notification) {
    if(getMoreNews){
      getAddMostViewData();
    }
  }

  void getData() {
    getalbumsImage = sl<Cases>().albumsScreenInitiation();
  }
}
