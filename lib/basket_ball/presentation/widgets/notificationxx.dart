/*
// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
    ..status = data['status'];
  return item;
}

class Item {
  Item({this.itemId});
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
          () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => DetailPage(itemId),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  DetailPage(this.itemId);
  final String itemId;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Item _item;
  StreamSubscription<Item> _subscription;

  @override
  void initState() {
    super.initState();
    _item = _items[widget.itemId];
    _subscription = _item.onChanged.listen((Item item) {
      if (!mounted) {
        _subscription.cancel();
      } else {
        setState(() {
          _item = item;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item ${_item.itemId}"),
      ),
      body: Material(
        child: Center(child: Text("Item status: ${_item.status}")),
      ),
    );
  }
}

class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

class _PushMessagingExampleState extends State<PushMessagingExample> {
  String _homeScreenText = "Waiting for token...";
  bool _topicButtonsDisabled = false;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _topicController =
  TextEditingController(text: 'topic');

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text("Item ${item.itemId} has been updated"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Push Messaging Demo'),
        ),
        // For testing -- simulate a message being received
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showItemDialog(<String, dynamic>{
            "data": <String, String>{
              "id": "2",
              "status": "out of stock",
            },
          }),
          tooltip: 'Simulate Message',
          child: const Icon(Icons.message),
        ),
        body: Material(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(_homeScreenText),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: TextField(
                      controller: _topicController,
                      onChanged: (String v) {
                        setState(() {
                          _topicButtonsDisabled = v.isEmpty;
                        });
                      }),
                ),
                FlatButton(
                  child: const Text("subscribe"),
                  onPressed: _topicButtonsDisabled
                      ? null
                      : () {
                    _firebaseMessaging
                        .subscribeToTopic(_topicController.text);
                    _clearTopicText();
                  },
                ),
                FlatButton(
                  child: const Text("unsubscribe"),
                  onPressed: _topicButtonsDisabled
                      ? null
                      : () {
                    _firebaseMessaging
                        .unsubscribeFromTopic(_topicController.text);
                    _clearTopicText();
                  },
                ),
              ])
            ],
          ),
        ));
  }

  void _clearTopicText() {
    setState(() {
      _topicController.text = "";
      _topicButtonsDisabled = true;
    });
  }
}*/

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/notification_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/notification_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/notifications/push_notificaion.dart';
import 'package:hi_market/injection.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../main.dart';
import '../../../res.dart';
import '../../../toast_utils.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
StreamController<int> countData ;
int notificationCount = 0 ;
getNotificationToken() {
  print("getDataToken getpermission");
  firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true));
  firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
    print("Settings registered: $settings");
  });
  print("get Token ");
  firebaseMessaging.getToken().then((String token) {
    // assert(token != null);
    print("ttttoken: $token");
    sl<Cases>().setNotificationFirebase(token.toString());
    String homeScreenText = "Push Messaging token: $token";
    print(homeScreenText);
  });
}
getNotification(BuildContext context) {
  showNotificationBoolean = false;
  firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
print("onMessage:$message");
if(countData != null){
        if (!(countData.isClosed)) {
          countData.add(++notificationCount);
        }
      }
      Get.snackbar("", "",backgroundColor: Colors.white,borderRadius: 5.0,isDismissible: true,duration: Duration(seconds: 10),titleText:Container(
  child: InkWell(
    onTap: ()async{
      if(message['data']['notification_type'] == "refree_update"){
      getNotificationData(context);
      }
    },
    child: Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(Res.basketiconlistimage),
            ),
            //Text("EBBFED .8 min")
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                flex: 4,
                child: Text(
                  "${message['notification']['body']}",
                  textDirection: TextDirection.rtl,
                  maxLines: 3,
                )),
            SizedBox(
              width: 5,
            ),
            Flexible(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(Res.basketiconlistimage),
                )),
          ],
        ),
       /* SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
                onPressed: () async {
                               var response = await sl<Cases>()
                                                      .judgeNotificationAction(
                                                      not_id: message['data']['notification_id'], res: false);
                                                  if (response is bool) {
                                                    Get.back();
                                                    var platform = Theme.of(context).platform;
                                                    platform == TargetPlatform.iOS
                                                        ? Get.snackbar("", "",
                                                        messageText: Text(
                                                          "تم ارسال الرد",
                                                          textAlign: TextAlign.center,
                                                        ))
                                                        : showToast(context, "تم ارسال الرد");
                                                  } else if (response is ResponseModelFailure) {
                                                    var platform = Theme.of(context).platform;
                                                    platform == TargetPlatform.iOS
                                                        ? Get.snackbar("", "",
                                                        messageText: Text(
                                                          response.message,
                                                          textAlign: TextAlign.center,
                                                        ))
                                                        : showToast(context, response.message);
                                                  } else {
                                                    var platform = Theme.of(context).platform;
                                                    platform == TargetPlatform.iOS
                                                        ? Get.snackbar("", "",
                                                        messageText: Text(
                                                          "Connection Error",
                                                          textAlign: TextAlign.center,
                                                        ))
                                                        : showToast(
                                                        context, "Connection Error");
                                                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "رفض",
                    style: TextStyle(color: Colors.black),
                  ),
                )),
            FlatButton(
                onPressed: () async {
                            var response = await sl<Cases>()
                                                      .judgeNotificationAction(
                                                      not_id: message['data']['notification_id'], res: true);
                                                  if (response is bool) {
                                                    Get.back();
                                                    var platform = Theme.of(context).platform;
                                                    platform == TargetPlatform.iOS
                                                        ? Get.snackbar("", "",
                                                        messageText: Text(
                                                          "تم ارسال الرد",
                                                          textAlign: TextAlign.center,
                                                        ))
                                                        : showToast(context, "تم ارسال الرد");
                                                  } else if (response is ResponseModelFailure) {
                                                    var platform = Theme.of(context).platform;
                                                    platform == TargetPlatform.iOS
                                                        ? Get.snackbar("", "",
                                                        messageText: Text(
                                                          response.message,
                                                          textAlign: TextAlign.center,
                                                        ))
                                                        : showToast(context, response.message);
                                                  } else {
                                                    var platform = Theme.of(context).platform;
                                                    platform == TargetPlatform.iOS
                                                        ? Get.snackbar("", "",
                                                        messageText: Text(
                                                          "Connection Error",
                                                          textAlign: TextAlign.center,
                                                        ))
                                                        : showToast(
                                                        context, "Connection Error");
                                                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "قبول",
                    style: TextStyle(color: Colors.black),
                  ),
                )),
          ],
        ),*/
      ],
    ),
  ),
));
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      if(sl<Cases>().getLoginData()!=null){
        Get.to(NotificationPage(),transition: Transition.fadeIn);
      }
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      if(sl<Cases>().getLoginData()!=null){
        Get.to(NotificationPage(),transition: Transition.fadeIn);
      }
    },
  );
  print("getDataToken getpermission");
  firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true));
  firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
    print("Settings registered: $settings");
  });
  print("get Token ");
  firebaseMessaging.getToken().then((String token) {
    // assert(token != null);
    print("ttttoken: $token");
  });
}

getNotificationData(context) async {
  ProgressDialog dialog = ProgressDialog(context);
  dialog.show();
  var response = await sl<Cases>().getNotification();
  dialog.hide();
  if (response is NotificationEntities) {
    dialog.hide();
    Move.to(context: context, page: NotificationPage(notificationEntities: response,));
  } else if (response is ResponseModelFailure) {
    var platform = Theme.of(context).platform;
    platform == TargetPlatform.iOS
        ? Get.snackbar("", "",
        messageText: Text(
          response.message,
          textAlign: TextAlign.center,
        ))
        : showToast(context, response.message);
  } else {
    var platform = Theme.of(context).platform;
    platform == TargetPlatform.iOS
        ? Get.snackbar("", "",
        messageText: Text(
          'Connection Error',
          textAlign: TextAlign.center,
        ))
        : showToast(context, 'Connection Error');
  }
  dialog.hide();
}