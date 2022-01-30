import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/domain/entities/get_albums_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_code_rules_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_achievement_categories_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_decision_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_etihad_histories_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_form_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_albums_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_matches_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_option_enities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_table.dart';
import 'package:hi_market/basket_ball/domain/entities/get_home_page_videos_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_news_initialize_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_last_viewed_more_news_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_listing_statitian_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_branches.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_department_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_according_to_year_enities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_manager_head_Entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_referee_conditions_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/get_videos_screen_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/referee_reference_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/teams_screen_initation_entities.dart';
import 'package:hi_market/basket_ball/presentation/pages/union/union_board/union_board_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/bar/bottom_bar.dart';
import 'package:hi_market/basket_ball/presentation/widgets/getNavigationBar.dart';
import 'package:hi_market/main.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../../res.dart';
import '../../../toast_utils.dart';

const Color staticColor = Color(0xffE31E24);
//const youTubeImage = 'http://i3.ytimg.com/vi/1yhxY6k-AOg/hqdefault.jpg';

String youTubeImage(String url) {
  String b = url.split('v=').last;
  //print(b.split('&').first);
  return 'http://i3.ytimg.com/vi/${b}/hqdefault.jpg';
}

enum ShowCompetition {
  showFirstCompetitionList,
  showMainCompetition,
}
enum RoleType { Judge, Guest }

enum matchType { start, end, result, note, report }

enum refereeType { main, edit, report }

DateTime refactorDate(String date) {
  if (date.toString() != "null" && date.toString() != "") {
    List formateDate = date.contains("/")
        ? date.split("/").toList()
        : date.split("-").toList();
    //print("formateData: ${formateDate}");
    DateTime dateTime = DateTime(int.parse(formateDate[2]),
        int.parse(formateDate[1]), int.parse(formateDate[0]));
    ////print("formDate: ${"${formateDate[2]}-${formateDate[1].toString().padLeft(2,"0")}-${formateDate[0].toString().length<(2)?"0${formateDate[0]}":formateDate[0]}"}");
    return dateTime; //"${"${formateDate[2]}-${formateDate[1].toString().padLeft(2,"0")}-${formateDate[0].toString().length<(2)?"0${formateDate[0]}":formateDate[0]}"}";}
  } else {
    return DateTime.now();
  }
}

getChatTime(String time) {
  if (time != "") {
    List<String> timeList = time.split(":");
    int hour = int.parse(timeList.first) > 12
        ? int.parse(timeList.first) - 12
        : int.parse(timeList.first);
    return "${hour}:${int.parse(timeList.last)} ${hour < 12 ? "AM" : "PM"}";
  } else {
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
    File file = await _downloadFile(url, savePath);
    /*Response response = await dio.download(
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",savePath,
      onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
    );*/

    /*  //print(response.headers);
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);*/
    OpenFile.open(file.path);
    showToast(context, "download Successfully in $savePath");
    return true;
    // await raf.close();
  } catch (e) {
    print(e);
    return true;
  }
}

void showDownloadProgress(received, total) {
  if (total != -1) {
    //print((received / total * 100).toStringAsFixed(0) + "%");
  }
}

launchPhone(String phone) {
  launch('tel:+${phone.toString()}');
}

launchEmail(String email) {
  launch('mailto:${email}');
}

FancyBottomNavigation getNavigationBar(BuildContext context, {int position}) {
  return FancyBottomNavigation(
    barBackgroundColor: Color(0xffE31E24),
    initialSelection: position??4,
    textColor: Colors.white,
    borderColor: getSelectedColor(position),
    tabs: <TabData>[
      TabData(
          icon: InkWell(
            onTap: () {
              Get.to(
                  MyHomePage(
                    getPosition: 0,
                  ),
                  transition: Transition.fadeIn);
            },
            child: Icon(
              Icons.view_headline,
              color: Colors.white,
            ),
          ),
          title: 'المزيد'),
      TabData(
        icon: InkWell(
          onTap: () {
            Get.to(
                MyHomePage(
                  getPosition: 1,
                ),
                transition: Transition.fadeIn);
          },
          child: Image.asset(
            Res.nadiimage,
            color: Colors.white,
            //size: snap.data == 0 ? 30 : 25,
            scale: 18,
          ),
        ),
        title: 'الأندية',
      ),
      TabData(
        icon: InkWell(
          onTap: () {
            Get.to(
                MyHomePage(
                  getPosition: 2,
                ),
                transition: Transition.fadeIn);
          },
          child: Image.asset(
            Res.liberaryimage,
            color: Colors.white,
            // size: snap.data == 1 ? 30 : 25,
            scale: 18,
          ),
        ),
        title: "المكتبات",
      ),
      TabData(
        icon: InkWell(
          onTap: () {
            Get.to(
                MyHomePage(
                  getPosition: 3,
                ),
                transition: Transition.fadeIn);
          },
          child: Image.asset(
            Res.gameimage,
            color: Colors.white,
            //  size: snap.data == 2 ? 30 : 25,
            scale: 18,
          ),
        ),
        title: 'عناصر اللعبة',
      ),
      TabData(
        icon: InkWell(
          onTap: () {
            Get.to(
                MyHomePage(
                  getPosition: 4,
                ),
                transition: Transition.fadeIn);
          },
          child: Image.asset(
            Res.competitionimage,
            color: Colors.white,
            scale: 18,
          ),
        ),
        title: 'المسابقات',
      ),
      TabData(
        icon: InkWell(
          onTap: () {
            Get.to(
                MyHomePage(
                  getPosition: 5,
                ),
                transition: Transition.fadeIn);
          },
          child: Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: 'الرئيسية',
      ),
    ],
    onTabChangedListener: (int) {},
    notTaped: position == null,
  );
}

getNoDataWidget() {
  return Container(
    alignment: Alignment.center,
    child: Text(
      " لا يوجد بيانات ",
      style: TextStyle(color: Colors.black, fontSize: 20),
    ),
  );
}



getTitle(String s, {Color color, TextAlign textAlign, double fontSize = 18, Style style}) {
  return Html(
    data: "$s",
    style: {
      'html': style ??Style(
          textAlign: textAlign ?? TextAlign.center,
          fontWeight: FontWeight.bold,
          fontSize: FontSize(fontSize),
          color: color ?? Colors.black),
    },
    // maxLines: 1,
    //style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
  );
}

getBody(String s, {Color color,Style style}) {
  // print('data::::: $s');
  if (s != "" && s != null) {
    //  print('${english.contains(s.trimLeft().characters.first)}');
    if (english.contains(s.trimLeft().characters.first)) {
      return Html(
        data: "$s",
        style: {
          'html':
             style?? Style(textAlign: TextAlign.left, color: color ?? Colors.black),
        },
        // maxLines: 1,
        //style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
      );
    }
  }
  return Html(
    data: "$s",
    style: {
      'html': Style(textAlign: TextAlign.right, color: color ?? Colors.black),
    },
    // maxLines: 1,
    //style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
  );
}

String english =
    "qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPLKJHGFDSAZXCVBNM/=1234567890";

String removeSpecificData(String data) {
  List<String> d = data.split("");
  bool isFirst = false;
  int x = 0;
  String last = "";
  d.forEach((e) {
    if (e == "[") {
      isFirst = true;
      //last = last + e;
      //print('1 $e');
    } else if (english.contains(e) && isFirst) {
      //print("2 $e");
    } else if (isFirst) {
    } else if (e == "]" && isFirst) {
      //print("3 $e");
      isFirst = false;
    } else {
      //print('4 $e');
      last = last + e;
    }
  });
  return last;
}
StreamController downloadStreamController = StreamController.broadcast();

disposeDownloadStreamController(){
  downloadStreamController.close();
}



// for basic news screen
GetLastNewsScreenInitializeEntities getLastNewsScreenInitializeEntities =
    GetLastNewsScreenInitializeEntities(data: List());
GetLoadMostViewedMoreNewsEntities getLoadMostViewedMoreNewsEntities =
    GetLoadMostViewedMoreNewsEntities(data: List());
GetLoadMostViewedMoreNewsEntities getSuggestedNewsEntities =
    GetLoadMostViewedMoreNewsEntities(data: List());

// for home page
GetHomePageMatchesEntities getHomePageMatchesEntities =
    GetHomePageMatchesEntities(data: List());
GetHomePageVideosEntities getHomePageVideosEntities =
    GetHomePageVideosEntities(data: List());
GetHomePageOptionsEntities getHomePageOptionsEntities =
    GetHomePageOptionsEntities(data: List());
GetHomePageAlbumsEntities getHomePageAlbumsEntities =
    GetHomePageAlbumsEntities(data: List());
GetHomePageTableEntities getHomePageTableEntities =
    GetHomePageTableEntities(data: List());

// for nadi

GetTeamScreenInitiationEntities getTeamScreenInitiationEntities =
    GetTeamScreenInitiationEntities(data: []);

//liberary
GetAlbumScreenEntities getAlbumScreenEntities =
    GetAlbumScreenEntities(data: List());

GetVideosScreenEntities getVideosScreenEntities =
    GetVideosScreenEntities(data: []);

GetFormScreenEntities getFormScreenEntities = GetFormScreenEntities(data: []);


// etihad bourd

GetManagerHeadEntities getManagerHeadEntities = GetManagerHeadEntities(data: List());
GetManagerAccordingToDepartmentEntities getManagerAccordingToDepartmentEntities = GetManagerAccordingToDepartmentEntities(data: List());
GetManagerAccordingtoBranchesEntities getManagerAccordingtoBranchesEntities = GetManagerAccordingtoBranchesEntities(data: List());
GetManagerAccordingtoYearEntities getManagerAccordingtoYearEntities = GetManagerAccordingtoYearEntities(data: List());

//etihad atchievement
GetEtihadAchievmentsCategoriesEntities getEtihadAchievmentsCategoriesEntities = GetEtihadAchievmentsCategoriesEntities(data: []);
// etihad historyList
GetEtihadHistoriesEntities getEtihadHistoriesEntities = GetEtihadHistoriesEntities();

UnionBoard unionBoard = UnionBoard.none;

// refree on element(details)
GetRefereesConditionsEntities getRefereesConditionsEntities =
GetRefereesConditionsEntities();
RefereeReferenceEntities refereeReferenceEntities =
RefereeReferenceEntities();

//union decision

GetEtihadDecisionEntities getEtihadDecisionEntities = GetEtihadDecisionEntities(data: []);
// statistics

GetListingStatistianEntities getListingStatistianEntities = GetListingStatistianEntities(data: []);

// train page

GetCoachesRulesEntities getCoachesRulesEntities = GetCoachesRulesEntities(data:[]);
GetRefereesConditionsEntities getRefereesConditionsEntitiesTrain  = GetRefereesConditionsEntities() ;