/*
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';


import '../../../../injection.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationSubject =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String> selectNotificationSubject =
    StreamController<String>.broadcast();

NotificationAppLaunchDetails notificationAppLaunchDetails;

final MethodChannel platform =
    MethodChannel('crossingthestreams.io/resourceResolver');

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

void requestIOSPermissions() {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

void configureDidReceiveLocalNotificationSubject(context) {
  didReceiveLocalNotificationSubject.stream
      .listen((ReceivedNotification receivedNotification) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: receivedNotification.title != null
            ? Text(receivedNotification.title)
            : null,
        content: receivedNotification.body != null
            ? Text(receivedNotification.body)
            : null,
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {

            },
          )
        ],
      ),
    );
  });
}

void configureSelectNotificationSubject(context) {
*/
/*  selectNotificationSubject.stream.listen((String payload) async {
    print("configureSelectNotificationSubject");
    GetAllNotificationEntities entities =
        await sl<CaseLogin>().getAllNotification();
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NotificationsPage(notification: entities.data)),
    );
  });*//*

}

pushNotificaion() async {
  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
    android:  initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
}

Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('repeating channel id',
      'repeating channel name', 'repeating description');
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
      'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
      androidAllowWhileIdle: true);
  print('before notificaiton.......');
  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: 'item x');
  print('after notification......');

}

Future<void> showNotificationWithNoBody() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'plain title', "",platformChannelSpecifics,
      payload: 'item x');
}

Future<void> cancelNotification() async {
  await flutterLocalNotificationsPlugin.cancel(0);
}

/// Schedules a notification that specifies a different icon, sound and vibration pattern
Future<void> scheduleNotification() async {
  var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
  var vibrationPattern = Int64List(4);
  vibrationPattern[0] = 0;
  vibrationPattern[1] = 1000;
  vibrationPattern[2] = 5000;
  vibrationPattern[3] = 2000;

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      'your other channel description',
      icon: 'secondary_icon',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      largeIcon: DrawableResourceAndroidBitmap('sample_large_icon'),
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500);
  var iOSPlatformChannelSpecifics =
      IOSNotificationDetails(sound: 'slow_spring_board.aiff');
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.schedule(
      0,
      'scheduled title',
      'scheduled body',
      scheduledNotificationDateTime,
      platformChannelSpecifics);
}

Future<void> showNotificationWithNoSound() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'silent channel id', 'silent channel name', 'silent channel description',
      playSound: false, styleInformation: DefaultStyleInformation(true, true));
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(presentSound: false);
  var platformChannelSpecifics = NotificationDetails(
     android: androidPlatformChannelSpecifics, iOS:iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, '<b>silent</b> title', '<b>silent</b> body', platformChannelSpecifics);
}

Future<void> showSoundUriNotification() async {
  // this calls a method over a platform channel implemented within the example app to return the Uri for the default
  // alarm sound and uses as the notification sound
  String alarmUri = await platform.invokeMethod('getAlarmUri');
  final x = UriAndroidNotificationSound(alarmUri);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'uri channel id', 'uri channel name', 'uri channel description',
      sound: x,
      playSound: true,
      styleInformation: DefaultStyleInformation(true, true));
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(presentSound: false);
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'uri sound title', 'uri sound body', platformChannelSpecifics);
}

Future<void> showTimeoutNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'silent channel id', 'silent channel name', 'silent channel description',
      timeoutAfter: 3000,
      styleInformation: DefaultStyleInformation(true, true));
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(presentSound: false);
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, 'timeout notification',
      'Times out after 3 seconds', platformChannelSpecifics);
}

Future<String> downloadAndSaveFile(String url, String fileName) async {
  // need http and path provider
  var directory = await getApplicationDocumentsDirectory();
  var filePath = '${directory.path}/$fileName';
  var response = await get(url);
  var file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<void> showBigPictureNotification() async {
  var largeIconPath = await downloadAndSaveFile(
      'http://via.placeholder.com/48x48', 'largeIcon');
  var bigPicturePath = await downloadAndSaveFile(
      'http://via.placeholder.com/400x800', 'bigPicture');
  var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      'big text channel description',
      styleInformation: bigPictureStyleInformation);
  var platformChannelSpecifics =
      NotificationDetails(android:androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'big text title', 'silent body', platformChannelSpecifics);
}

Future<void> showBigPictureNotificationHideExpandedLargeIcon() async {
  var largeIconPath = await downloadAndSaveFile(
      'http://via.placeholder.com/48x48', 'largeIcon');
  var bigPicturePath = await downloadAndSaveFile(
      'http://via.placeholder.com/400x800', 'bigPicture');
  var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      'big text channel description',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      styleInformation: bigPictureStyleInformation);
  var platformChannelSpecifics =
      NotificationDetails(android:androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'big text title', 'silent body', platformChannelSpecifics);
}

Future<void> showNotificationMediaStyle() async {
  var largeIconPath = await downloadAndSaveFile(
      'http://via.placeholder.com/128x128/00FF00/000000', 'largeIcon');
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'media channel id',
    'media channel name',
    'media channel description',
    largeIcon: FilePathAndroidBitmap(largeIconPath),
    styleInformation: MediaStyleInformation(),
  );
  var platformChannelSpecifics =
      NotificationDetails(android:androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'notification title', 'notification body', platformChannelSpecifics);
}

Future<void> showBigTextNotification() async {
  var bigTextStyleInformation = BigTextStyleInformation(
      'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      htmlFormatBigText: true,
      contentTitle: 'overridden <b>big</b> content title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'big text channel id',
      'big text channel name',
      'big text channel description',
      styleInformation: bigTextStyleInformation);
  var platformChannelSpecifics =
      NotificationDetails(android:androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'big text title', 'silent body', platformChannelSpecifics);
}

Future<void> showInboxNotification() async {
  var lines = List<String>();
  lines.add('line <b>1</b>');
  lines.add('line <i>2</i>');
  var inboxStyleInformation = InboxStyleInformation(lines,
      htmlFormatLines: true,
      contentTitle: 'overridden <b>inbox</b> context title',
      htmlFormatContentTitle: true,
      summaryText: 'summary <i>text</i>',
      htmlFormatSummaryText: true);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'inbox channel id', 'inboxchannel name', 'inbox channel description',
      styleInformation: inboxStyleInformation);
  var platformChannelSpecifics =
      NotificationDetails(android:androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'inbox title', 'inbox body', platformChannelSpecifics);
}

Future<void> showMessagingNotification(platform) async {
  // use a platform channel to resolve an Android drawable resource to a URI.
  // This is NOT part of the notifications plugin. Calls made over this channel is handled by the app
  String imageUri = await platform.invokeMethod('drawableToUri', 'food');
  var messages = List<Message>();
  // First two person objects will use icons that part of the Android app's drawable resources
  var me = Person(
    name: 'Me',
    key: '1',
    uri: 'tel:1234567890',
    icon: DrawableResourceAndroidIcon('me'),
  );
  var coworker = Person(
    name: 'Coworker',
    key: '2',
    uri: 'tel:9876543210',
    icon: FlutterBitmapAssetAndroidIcon('icons/coworker.png'),
  );
  // download the icon that would be use for the lunch bot person
  var largeIconPath = await downloadAndSaveFile(
      'http://via.placeholder.com/48x48', 'largeIcon');
  // this person object will use an icon that was downloaded
  var lunchBot = Person(
    name: 'Lunch bot',
    key: 'bot',
    bot: true,
    icon: BitmapFilePathAndroidIcon(largeIconPath),
  );
*/
/*  messages.add(Message('Hi', DateTime.now()));
  messages.add(Message(
      'What\'s up?', DateTime.now().add(Duration(minutes: 5)), coworker));
  messages.add(Message(
      'Lunch?', DateTime.now().add(Duration(minutes: 10)),
      dataMimeType: 'image/png', dataUri: imageUri));*//*

  messages.add(Message('What kind of food would you prefer?',
      DateTime.now().add(Duration(minutes: 10)), lunchBot));
  var messagingStyle = MessagingStyleInformation(me,
      groupConversation: true,
      conversationTitle: 'Team lunch',
      htmlFormatContent: true,
      htmlFormatTitle: true,
      messages: messages);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'message channel id',
      'message channel name',
      'message channel description',
      category: 'msg',
      styleInformation: messagingStyle);
  var platformChannelSpecifics =
      NotificationDetails(android:androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'message title', 'message body', platformChannelSpecifics);

  // wait 10 seconds and add another message to simulate another response
  await Future.delayed(Duration(seconds: 10), () async {
   */
/* messages
        .add(Message('Thai', DateTime.now().add(Duration(minutes: 11))));*//*

    await flutterLocalNotificationsPlugin.show(
        0, 'message title', 'message body', platformChannelSpecifics);
  });
}

Future<void> showGroupedNotifications(context) async {
  var groupKey = 'com.android.example.WORK_EMAIL';
  var groupChannelId = 'grouped channel id';
  var groupChannelName = 'grouped channel name';
  var groupChannelDescription = 'grouped channel description';
  // example based on https://developer.android.com/training/notify-user/group.html
  var firstNotificationAndroidSpecifics = AndroidNotificationDetails(
      groupChannelId, groupChannelName, groupChannelDescription,
      importance: Importance.max, priority: Priority.high, groupKey: groupKey);
  var firstNotificationPlatformSpecifics =
      NotificationDetails(android: firstNotificationAndroidSpecifics);
  await flutterLocalNotificationsPlugin.show(1, 'Alex Faarborg',
      'You will not believe...', firstNotificationPlatformSpecifics);
  var secondNotificationAndroidSpecifics = AndroidNotificationDetails(
      groupChannelId, groupChannelName, groupChannelDescription,
      importance: Importance.max, priority: Priority.high, groupKey: groupKey);
  var secondNotificationPlatformSpecifics =
      NotificationDetails(android: secondNotificationAndroidSpecifics);
  await flutterLocalNotificationsPlugin.show(
      2,
      'Jeff Chang',
      'Please join us to celebrate the...',
      secondNotificationPlatformSpecifics);

  // create the summary notification to support older devices that pre-date Android 7.0 (API level 24).
  // this is required is regardless of which versions of Android your application is going to support
  var lines = List<String>();
  lines.add('Alex Faarborg  Check this out');
  lines.add('Jeff Chang    Launch Party');
  var inboxStyleInformation = InboxStyleInformation(lines,
      contentTitle: '2 messages', summaryText: 'janedoe@example.com');
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      groupChannelId, groupChannelName, groupChannelDescription,
      styleInformation: inboxStyleInformation,
      groupKey: groupKey,
      setAsGroupSummary: true);
  var platformChannelSpecifics =
      NotificationDetails(android:androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      3, 'Attention', 'Two messages', platformChannelSpecifics);
}

Future<void> checkPendingNotificationRequests(context) async {
  var pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  for (var pendingNotificationRequest in pendingNotificationRequests) {
    debugPrint(
        'pending notification: [id: ${pendingNotificationRequest.id}, title: ${pendingNotificationRequest.title}, body: ${pendingNotificationRequest.body}, payload: ${pendingNotificationRequest.payload}]');
  }
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
            '${pendingNotificationRequests.length} pending notification requests'),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> cancelAllNotifications() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

Future<void> showOngoingNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, 'ongoing notification title',
      'ongoing notification body', platformChannelSpecifics);
}

Future<void> repeatNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
      'repeating description');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
      'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics);
}

Future<void> showDailyAtTime() async {
  var time = Time(10, 0, 0);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'show daily title',
      'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
      time,
      platformChannelSpecifics);
}

Future<void> showWeeklyAtDayAndTime() async {
  var time = Time(10, 0, 0);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'show weekly channel id',
      'show weekly channel name',
      'show weekly description');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      0,
      'show weekly title',
      'Weekly notification shown on Monday at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
      Day.monday,
      time,
      platformChannelSpecifics);
}

Future<void> showNotificationWithNoBadge() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'no badge channel', 'no badge name', 'no badge description',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'no badge title', 'no badge body', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> showProgressNotification() async {
  var maxProgress = 5;
  for (var i = 0; i <= maxProgress; i++) {
    await Future.delayed(Duration(seconds: 1), () async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'progress channel',
          'progress channel',
          'progress channel description',
          channelShowBadge: false,
          importance: Importance.max,
          priority: Priority.high,
          onlyAlertOnce: true,
          showProgress: true,
          maxProgress: maxProgress,
          progress: i);
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          0,
          'progress notification title',
          'progress notification body',
          platformChannelSpecifics,
          payload: 'item x');
    });
  }
}

Future<void> showIndeterminateProgressNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'indeterminate progress channel',
      'indeterminate progress channel',
      'indeterminate progress channel description',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      indeterminate: true);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0,
      'indeterminate progress notification title',
      'indeterminate progress notification body',
      platformChannelSpecifics,
      payload: 'item x');
}

Future<void> showNotificationWithUpdatedChannelDescription() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your updated channel description',
      importance: Importance.max,
      priority: Priority.high,
      channelAction: AndroidNotificationChannelAction.update);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0,
      'updated notification channel',
      'check settings to see updated channel description',
      platformChannelSpecifics,
      payload: 'item x');
}

Future<void> showPublicNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      visibility: NotificationVisibility.public);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, 'public notification title',
      'public notification body', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> showNotificationWithIconBadge() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'icon badge channel', 'icon badge name', 'icon badge description');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(badgeNumber: 1);
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'icon badge title', 'icon badge body', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> showNotificationWithoutTimestamp() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.max, priority: Priority.high, showWhen: false);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, 'plain title', 'plain body', platformChannelSpecifics,
      payload: 'item x');
}

Future<void> showNotificationWithAttachment() async {
  var bigPicturePath = await downloadAndSaveFile(
      'http://via.placeholder.com/600x200', 'bigPicture.jpg');
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      attachments: [IOSNotificationAttachment(bigPicturePath)]);
  var bigPictureAndroidStyle =
      BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureAndroidStyle);
  var notificationDetails = NotificationDetails(
      android:androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0,
      'notification with attachment title',
      'notification with attachment body',
      notificationDetails);
}

String _toTwoDigitString(int value) {
  return value.toString().padLeft(2, '0');
}

Future<void> onDidReceiveLocalNotification(
    int id, String title, String body, var notification, context) async {
  // display a dialog with the notification details, tap ok to go to another page
  await showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: title != null ? Text(title) : null,
      content: body != null ? Text(body) : null,
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () async {
            print("onDidReceiveLocalNotification");

          },
        )
      ],
    ),
  );
}
*/
