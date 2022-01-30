import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_albums_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/show_image_page.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../injection.dart';
import '../../../main.dart';
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
  bool showProgress = false;

  ScrollController scrollController = ScrollController();
int page = 1;
bool showScroll = true;
bool progress = false;
  getAddMostViewData() async {
    if(showScroll){
      setState(() {
        getMoreNews = false;
        progress = true;
        showScroll = false;
      });
      var response = await sl<Cases>()
          .albumsScreenLoadMore((++page).toString());
      setState(() {
        getMoreNews = true;
        progress = false;
        showScroll = true;
      });
      if (response is GetAlbumScreenEntities) {
        print('response: $page: ${response.data.length}');
        if(response.data.length == 0){
          setState(() {
            showScroll = false;
          });
        }
      response.data.forEach((element) {
        bool add = true;
        getAlbumScreenEntities.data.forEach((e) {
          if (element.id == e.id) {
          add =false;
          }
        });
        if(add){
          setState(() {
            print('hereree : $page ${response.data.length}');
            getAlbumScreenEntities.data.add(element);
          });
        }
      });
      } else if (response is ResponseModelFailure) {
        print(response.message);
        errorDialog(context);
      } else {
        errorDialog(context);
      }
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
    return  LiquidPullToRefresh(
      onRefresh: ()async{
       setState(() {
         getAlbumScreenEntities.data = [];
       });
    Move.noBack(context: context, page: MyHomePage(getPosition: 2, chosenSelected: 0));
        },
      backgroundColor: Colors.white,
      color: staticColor,
      child:Scaffold(
        body: Container(
            child: getAlbumScreenEntities.data.length != 0 ? showImagesStyleWidget(getAlbumScreenEntities): FutureBuilder(
              future: getalbumsImage,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  print("snapshotError : ${snapshot.error}");
                  return errorContainer(
                      context, () {
                    setState(() {
                      getalbumsImage = sl<Cases>().albumsScreenInitiation();
                    });
                  });
                }
                switch (snapshot.connectionState){
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
                    if (snapshot.hasData){
                      if (snapshot.data is GetAlbumScreenEntities) {
                        getAlbumScreenEntities = snapshot.data;
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
                          return errorContainer(
                              context, () {
                            setState(() {
                              getalbumsImage = sl<Cases>().albumsScreenInitiation();
                            });
                          });
                        }
                      } else {
                        return errorContainer(
                            context, () {
                          setState(() {
                            getalbumsImage = sl<Cases>().albumsScreenInitiation();
                          });
                        });
                      }
                    }
                    break;
                }

                return errorContainer(
                    context, () {
                  setState(() {
                    getalbumsImage = sl<Cases>().albumsScreenInitiation();
                  });
                });
              },
            )),
        //bottomNavigationBar: getNavigationBar(context),
      ),
    );
  }

  showImagesStyleWidget(GetAlbumScreenEntities getAlbumScreen) {
    if(getAlbumScreenEntities.data.length == 0){
      getAlbumScreenEntities = getAlbumScreen;
    }
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: _getAlbumsMore,
          child: ListView.builder(
            controller: scrollController,
            itemCount: getAlbumScreenEntities.data.length,
            itemBuilder: (context, index) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: InkWell(
                  onTap: () {
                    Move.to(
                        context: context,
                        page: ShowImagePage(
                            getAlbumScreenEntities:
                                getAlbumScreenEntities.data[index]));
                  },
                  child:getAlbumsWidget(context,mainPhoto:  getAlbumScreenEntities.data[index].albumThumb,listThumbs:   getAlbumScreenEntities.data[index].thubmsUrls,title:   getAlbumScreenEntities.data[index].title )/*Column(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListTile(
                          leading: Container(
                            width: 10,
                            height: 50,
                            color: Colors.red,
                          ),
                          title: getTitle(
                            "${getAlbumScreenEntities.data[index].title}",
                            *//*style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),*//*
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
                                      decoration: BoxDecoration(*//*border:Border.all(color:Colors.black)*//*),

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
                  )*/,
                ),
              );
            },
          ),
        ),
        progress?getLoadingContainer(context):Container()
      ],
    );
  }
  bool getMoreNews = true;
  bool _getAlbumsMore(ScrollNotification notification) {
    if(notification is ScrollNotification &&
        scrollController.position.extentAfter == 0){
      getAddMostViewData();
    }
  }

  void getData() {
    getalbumsImage = sl<Cases>().albumsScreenInitiation();
  }
}
