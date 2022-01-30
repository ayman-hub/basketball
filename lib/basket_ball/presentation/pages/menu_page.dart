import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/domain/entities/get_login_data.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/refree_page/refree_main_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/sing_up/sign_in_password_page.dart';
import 'package:hi_market/basket_ball/presentation/pages/union/about_union.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../injection.dart';
import '../../../main.dart';
import '../../../res.dart';
import '../../../toast_utils.dart';
import 'complain_page.dart';
import 'last_news/last_news_page.dart';
import 'referee_sign/referee_sing_in_page.dart';

class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() {
    return _MenuPageState();
  }
}

class _MenuPageState extends State<MenuPage> {
 bool  showProgress = false;
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
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            Res.wightbasketimage,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            centerTitle: true,
            leading: Container(),
            title:sl<Cases>().getLoginData().data != null
                ? Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Text( '${sl<Cases>().getLoginData().data.userName}',style:
              GoogleFonts.cairo(color: Colors.black,),),
              SizedBox(width: 20,),
              Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                /* height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.height / 4,*/
                child: Container(
                  child: Image.asset("images/sideMenuLogo.png",scale: 10,),
                )
                /*CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person_outline,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              )*/
                ,
              )
            ],):Container(),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Stack(
              children: [
              /*  Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "images/wightbasketimage.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),*/
                Container(
                  /* padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 10),*/
                  child: ListView(
                    children: [
                      /*  sl<Cases>().getLoginData().data == null
                                ? InkWell(
                                    onTap: () {
                                      Move.to(context: context, page: SignInPage());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "إنشاء حساب جديد",
                                        style:
                                        GoogleFonts.cairo()(
                                            color: Colors.white,

                                            fontSize: 20),
                                      ),
                                    ),
                                  )
                                : Container(),*/
                      InkWell(
                        onTap: () =>
                            Move.to(context: context, page: AboutUnionPage()),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: ListTile(
                            trailing: SvgPicture.asset("images/Group_530.svg"),
                            title: Text(
                              "عن الإتحاد",
                              textAlign: TextAlign.right,
                              style:
                              GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            Move.to(context: context, page: LastNewsPage()),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: ListTile(
                            trailing: SvgPicture.asset("images/Group_531.svg"),
                            title: Text(
                              "آخر الأخبار",
                              textAlign: TextAlign.right,
                              style:
                              GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            Move.to(context: context, page: ComplainPage()),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: ListTile(
                            trailing: SvgPicture.asset("images/Group_532.svg"),
                            title: Text(
                              "تواصل معنا",
                              textAlign: TextAlign.right,
                              style:
                              GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (sl<Cases>().getLoginData() != null &&
                              sl<Cases>().getUserPassword() != null) {
                            if ("Judge" ==
                                sl<Cases>()
                                    .getLoginData()
                                    ?.data
                                    ?.userRole ??
                                "") {
                             setState(() {
                               showProgress = true;
                             });
                              var response = await sl<Cases>().login(
                                  email:
                                  sl<Cases>().getUserPassword().userName,
                                  password:
                                  sl<Cases>().getUserPassword().password);
                           setState(() {
                             showProgress = false;
                           });
                           print('get response ;:: ${response.runtimeType}');
                              if (response is LoginDataEntities) {
                                print('go to referee main page');
                                sl<Cases>().setLoginData(response);
                                Move.to(
                                    context: context,
                                    page: RefereeMainPage());
                              }else if (response is ResponseModelFailure){
                                showToast(context, "${response.message}");
                              }
                            } else {
                              Move.to(
                                  context: context,
                                  page: RefereeSignINPage());
                            }
                          } else {
                            Move.to(
                                context: context, page: RefereeSignINPage());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: ListTile(
                            trailing: SvgPicture.asset("images/Group_537.svg"),
                            title: Text(
                              "الحكام",
                              textAlign: TextAlign.right,
                              style:
                              GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      sl<Cases>().getLoginData().data != null
                          ? InkWell(
                        onTap: () async {
                          Move.to(
                              context: context,
                              page: ChangePasswordPage());
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: ListTile(
                            trailing: Icon(Icons.lock,color: Colors.black,),
                            title: Text(
                              "تغيير كلمة السر",
                              textAlign: TextAlign.right,
                              style:
                              GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      )
                          : Container(),
                      sl<Cases>().getLoginData().data == null
                          ? SizedBox(
                        height: 30,
                      )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                _launchURL("https://twitter.com/EBBFED");
                              },
                              child: SvgPicture.asset(
                                "images/twitter.svg"
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                _launchURL(
                                    "https://www.instagram.com/egy_basketball_federation/");
                              },
                              child: SvgPicture.asset(
                                "images/instagram.svg"
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                _launchURL("https://www.facebook.com/EBBFED");
                              },
                              child: SvgPicture.asset(
                               "images/facebook.svg"
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                _launchURL("https://www.youtube.com/channel/UC3KafxSC7-CyXsFvmzvnpoQ");
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 15,bottom: 15,right: 5,left: 5),
                                //color: Colors.white,
                                child: SvgPicture.asset("images/ youtube.svg",width:30 ,height: 35,),
                              )),
                        ],
                      ),
                      SizedBox(height: 20,),
                      sl<Cases>().getLoginData().data != null
                          ? InkWell(
                        onTap: () async {
                          setState(() {
                            showProgress = true;
                          });
                          LoginDataEntities response = sl<Cases>().getLoginData();
                          var responseNo = await sl<Cases>().pushNotification(response,true);
                          setState(() {
                            showProgress =false;
                          });
                          print("Push Notification : $responseNo");

                          print("responseNo: $responseNo");
                          if(responseNo is bool){
                            sl<Cases>().setLoginData(LoginDataEntities());
                            sl<Cases>().putNotification(false);
                            sl<Cases>().setNotificationIdSharedPreference(List<String>.empty(growable: true));
                            Navigator.pop(context);
                            Move.to(context: context, page: MyHomePage());
                          }else if(responseNo is ResponseModelFailure){
                            showToast(context, responseNo.message);
                          }else{
                            showToast(context, "حدث خطأ من فضلك حاول مره أخرى");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: ListTile(
                            trailing: SvgPicture.asset("images/Group_533.svg"),
                            title: Text(
                              "الخروج",
                              textAlign: TextAlign.right,
                              style:
                              GoogleFonts.cairo(
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ),
                showProgress ? getLoadingContainer(context):Container()
              ],
            ),
          ),
        ),
      ],
    );
  }
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}