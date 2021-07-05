import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/main.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res.dart';
import '../../../toast_utils.dart';


const Color staticColor = Color(0xffE31E24);

enum ShowCompetition {
  showFirstCompetitionList,
  showMainCompetition,
}
enum RoleType { Judge, Guest }

enum matchType { start, end, result , note , report}

enum refereeType { main, edit, report }

DateTime refactorDate(String date) {
  if (date.toString() != "null" && date.toString() != "") {
    List formateDate = date.contains("/") ? date.split("/").toList() : date
        .split("-").toList();
    print("formateData: ${formateDate}");
    DateTime dateTime = DateTime(
        int.parse(formateDate[2]), int.parse(formateDate[1]),
        int.parse(formateDate[0]));
    //print("formDate: ${"${formateDate[2]}-${formateDate[1].toString().padLeft(2,"0")}-${formateDate[0].toString().length<(2)?"0${formateDate[0]}":formateDate[0]}"}");
    return dateTime; //"${"${formateDate[2]}-${formateDate[1].toString().padLeft(2,"0")}-${formateDate[0].toString().length<(2)?"0${formateDate[0]}":formateDate[0]}"}";}
  } else {
    return DateTime.now();
  }
}

getChatTime(String time) {
  if(time != ""){
    List<String> timeList = time.split(":");
    int hour = int.parse(timeList.first) > 12
        ? int.parse(timeList.first) - 12
        : int.parse(timeList.first);
    return "${hour}:${int.parse(timeList.last)} ${hour < 12 ? "AM" : "PM"}";
  }else{
    return "";
  }
}
Future<File> _downloadFile(String url, String filename) async {
  Client client = new Client();
  var req = await client.get(Uri.parse(url));
  var bytes = req.bodyBytes;
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/$filename');
  await file.writeAsBytes(bytes);
  return file;
}

Future download2(
    Dio dio, String url, String savePath, BuildContext context) async {
  try {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.show();
    File file = await _downloadFile(url, savePath);
    /*Response response = await dio.download(
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",savePath,
      onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
    );*/
    if(dialog.isShowing()){
      dialog.hide();
    }
  /*  print(response.headers);
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);*/


    OpenFile.open(file.path);
    showToast(context, "download Successfully in $savePath");
   // await raf.close();
  } catch (e) {
    print(e);
  }
}

void showDownloadProgress(received, total) {
  if (total != -1) {
    print((received / total * 100).toStringAsFixed(0) + "%");
  }
}
launchPhone(String phone){
  launch('tel:+${phone.toString()}');
}
launchEmail(String email){
  launch('mailto:${email}');
}
BottomNavigationBar getNavigationBar(BuildContext context){
  return BottomNavigationBar(
    backgroundColor:Color(0xffE31E24),
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: InkWell(
            onTap: (){
              Get.to(MyHomePage(getPosition: 0,),transition: Transition.fadeIn);
            },
            child: Image.asset(
              Res.nadiimage,
              color:  Colors.white,
              //size: snap.data == 0 ? 30 : 25,
              scale:18,
            ),
          ),
          title:  InkWell(
            onTap: (){
              Get.to(MyHomePage(getPosition: 0,),transition: Transition.fadeIn);
            },child: Text(
              'الأندية',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 26),
            ),
          )),
      BottomNavigationBarItem(
        icon: InkWell(
          onTap: (){
            Get.to(MyHomePage(getPosition: 1,),transition: Transition.fadeIn);
          },child: Image.asset(
            Res.liberaryimage,
            color: Colors.white ,
            // size: snap.data == 1 ? 30 : 25,
            scale: 18,
          ),
        ),
        title: InkWell(
          onTap: (){
            Get.to(MyHomePage(getPosition: 1,),transition: Transition.fadeIn);
          },child: Text(
            "المكتبات",
            style: TextStyle(
                color:Colors.white,
                fontSize:MediaQuery.of(context).size.width / 26),
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: InkWell(
          onTap: (){
            Get.to(MyHomePage(getPosition: 2,),transition: Transition.fadeIn);
          },child: Image.asset(
            Res.gameimage,
            color: Colors.white,
            //  size: snap.data == 2 ? 30 : 25,
            scale: 18,
          ),
        ),
        title: InkWell(
          onTap: (){
            Get.to(MyHomePage(getPosition: 2,),transition: Transition.fadeIn);
          },child: Text(
            'عناصر اللعبة',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 26),
          ),
        ),
      ),
      BottomNavigationBarItem(
        icon: InkWell(
          onTap: (){
            Get.to(MyHomePage(getPosition: 3,),transition: Transition.fadeIn);
          },child: Image.asset(
            Res.competitionimage,
            color: Colors.white ,
            scale: 18,
          ),
        ),
        title: InkWell(
          onTap: (){
            Get.to(MyHomePage(getPosition: 3,),transition: Transition.fadeIn);
          },child: Text(
            'المسابقات',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 26),
          ),
        ),
      ),
    ],
  );

}

