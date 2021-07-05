import 'package:flutter/material.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_news_entities.dart';
import 'package:hi_market/basket_ball/presentation/pages/main_page.dart';

import '../../../res.dart';
import 'go_to.dart';

class ListNewsPage extends StatefulWidget {
  ListNewsPage({Key key,@required this.getHomePageNewsEntities}) : super(key: key);
GetHomePageNewsEntities getHomePageNewsEntities;
  @override
  _ListNewsPageState createState() {
    return _ListNewsPageState();
  }
}

class _ListNewsPageState extends State<ListNewsPage> {
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(Res.wightbasketimage,fit: BoxFit.fill,),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: MediaQuery.of(context).size.height / 15,
                  padding: EdgeInsets.only(bottom: 10),
                  child: IconButton(
                      icon: Image.asset(Res.backimage,color: Color(0xffE31E24),),
                      onPressed: () {
                        return Move.to(context: context, page: MainPage());
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                ...widget.getHomePageNewsEntities.data
                    .map((e) => Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height / 3,
                          child: e.thumb != null
                              ? Image.network(e.thumb)
                              : Icon(Icons.photo)),
                      Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text("${e.title}",textAlign: TextAlign.center,),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(
                          "${e.excerpt}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ))
                    .toList(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}