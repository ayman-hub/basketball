
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/get_government_entities.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/pages/referee_sign/referee_sing_in_page.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';
import 'package:hi_market/basket_ball/presentation/widgets/loading_widget.dart';
import 'package:hi_market/main.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../../../injection.dart';
import '../../../../res.dart';
import '../../../../toast_utils.dart';
import '../complain_page.dart';
import '../main_page.dart';

class RefereeSignUpPage extends StatefulWidget {
  RefereeSignUpPage({Key key}) : super(key: key);

  @override
  _RefereeSignUpPageState createState() {
    return _RefereeSignUpPageState();
  }
}

class _RefereeSignUpPageState extends State<RefereeSignUpPage> {
  String firstName;

  String lastName;

  String email;

  String phone;

  String password;
  String weight;
  String height;

  final formKey = GlobalKey<FormState>();

  int selected;

  String national_id;
  GovernmentData govertmentID;

  Future getFutureData;


  bool showProgress = false;

  String loginName;

  showDialogWidget() async {
    int showSelected = await showDialog<int>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 10),
              shape:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              content: Container(
                height: 301,
                width: MediaQuery.of(dialogContext).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(dialogContext, 0);
                          },
                          child: Image.asset(
                            "images/backimage.png",
                            //scale: 3,
                          ),
                        ),
                        Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 10),
                              child: Text("نوع الحكم",
                                style: GoogleFonts.cairo(
                                    color: Color(0xffE31E24),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selected = 0;
                        });
                      },
                      child: Container(
                        height: 148,
                        // margin: EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width:
                              MediaQuery.of(dialogContext).size.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selected == 0
                                      ? Color(0xffE31E24)
                                      : Colors.white,
                                  border: Border.all(
                                      color: selected == 0
                                          ? Color(0xffE31E24)
                                          : Colors.black)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                 /* Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "images/spoon.png",
                                      scale: 2,
                                      color: selected == 0
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),*/
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text("حكم دولى",
                                      style: GoogleFonts.ptSans(
                                          color: selected == 0
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selected = 1;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selected == 1
                                        ? Color(0xffE31E24)
                                        : Colors.white,
                                    border: Border.all(
                                        color: selected == 1
                                            ? Color(0xffE31E24)
                                            : Colors.black)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                               /*     Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        "images/big_comic.png",
                                        scale: 3,
                                        color: selected == 1
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),*/
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text("حكم محلي",
                                        style: GoogleFonts.ptSans(
                                            color: selected == 1
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        return Navigator.pop(dialogContext, selected);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffE31E24),
                        ),
                        child: Text("اختر",
                          style: GoogleFonts.ptSans(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
    print(showSelected);
    setState(() {
      selected = showSelected ?? 0;
    });
  }
  showGovernmentWidget() async {
    GovernmentEntities governmentEntities = GovernmentEntities(data: List());
setState(() {
  showProgress = true;
});
    var response = await sl<Cases>().getGovernmentEntities();
   setState(() {
     showProgress = false;
   });
    if(response is GovernmentEntities){
      setState(() {
        governmentEntities = response;
      });
      GovernmentData showSelected = await showDialog<GovernmentData>(
        context: context,
        barrierDismissible: true,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 10),
                shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                content: Container(
                  height: 301,
                  width: MediaQuery.of(dialogContext).size.width,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text("اختر المحافظة",style: GoogleFonts.cairo(color: Colors.red,fontWeight: FontWeight.bold),),
                      ),
                      Expanded(
                        child: ListView.builder(
                      itemCount: governmentEntities.data.length,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              Navigator.pop(dialogContext,governmentEntities.data[index]);
                            },
                            child: ListTile(
                              title: Container(
                                alignment: Alignment.center,
                                child: Text(governmentEntities.data[index].name,style: GoogleFonts.cairo(color: Colors.black),textAlign: TextAlign.center,),
                              ),
                            ),
                          );
                        },
                      ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      );
      print(showSelected);
      setState(() {
        govertmentID = showSelected;
      });
    }else if (response is ResponseModelFailure){
      showToast(context, response.message);
    }

  }

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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Image.asset(
              Res.blackballimage,
              fit: BoxFit.fill,
            ),
          ),
          Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 20,
                      right: MediaQuery.of(context).size.width / 20,
                      top: MediaQuery.of(context).size.height / 25),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "سجل الأن",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            maxLines: 1,
                            onChanged: (value) {
                              setState(() {
                                firstName = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "الاسم",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            maxLines: 1,
                            onChanged: (value) {
                              setState(() {
                                lastName = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "اسم العائلة",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            maxLines: 1,
                            onChanged: (value) {
                                loginName = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "اسم المستخدم",
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            maxLines: 1,
                            onChanged: (value) {
                              setState(() {
                                phone = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "رقم الموبايل",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.numberWithOptions(),
                            onChanged: (value) {
                              setState(() {
                                national_id = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "رقم بطاقة الحكم",
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "البريد الالكتروني",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child: TextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.numberWithOptions(),
                            onChanged: (value) {
                             height = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "الطول",
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child: TextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.numberWithOptions(),
                            onChanged: (value) {
                              weight = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "الوزن",
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child: TextFormField(
                            maxLines: 1,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "الرقم السري",
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child: TextFormField(
                            maxLines: 1,
                            obscureText: true,
                            onChanged: (value) {
                              //  confirmPassword = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "من فضلك املأ الخانات";
                              }else if(value != password){
                                return "تأكيد الرقم السري غير مظابق للرقم السري";
                              }
                              return null;
                            },
                            style: TextStyle(fontSize: 15.0),
                            decoration: InputDecoration(
                                hintText: "تأكيد الرقم السري",
                                contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: InkWell(
                          onTap: (){showDialogWidget();},
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(selected== null?"نوع الحكم":selected == 0 ?"حكم دولي":"حكم محلي",style: GoogleFonts.cairo(color: Colors.black),),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: InkWell(
                          onTap: (){showGovernmentWidget();},
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("${govertmentID?.name??"اختر المحافظة" }",style: GoogleFonts.cairo(color: Colors.black),),
                                ),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FlatButton(
                          onPressed: () async {
                            if(govertmentID != null && selected != null ){
                              print("govern: $govertmentID");
                              print("selected: ${selected == 0
                                  ? "international"
                                  : "local"}");
                              if (formKey.currentState.validate()) {
                                setState(() {
                                  showProgress = true;
                                });
                                var response = await sl<Cases>().judgeRegister(
                                    firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    phone: phone,
                                    weight: weight,
                                    height: height,
                                    loginName:loginName,
                                    nationalID: national_id,
                                    governmentID: govertmentID.id.toString(),
                                    type: selected == 0
                                        ? "international"
                                        : "local");
                            setState(() {
                              showProgress = false;
                            });
                                if (response is bool) {

                                  var platform = Theme.of(context).platform;
                                  platform == TargetPlatform.iOS
                                      ? Get.snackbar("", "",
                                          messageText: Text(
                                            "User Has been created succesfully",
                                            textAlign: TextAlign.center,
                                          ))
                                      : showToast(context,
                                          'User Has been created succesfully');

                                  return Move.noBack(
                                      context: context,
                                      page: RefereeSignINPage());
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
                                      : showToast(context, 'Connection Error');
                                }
                              }
                            }else{
                              showToast(context, "يجب تحديد نوع الحكم و المحافظة أولا");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffE31E24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(
                                      2.0, 2.0), // shadow direction: bottom right
                                )
                              ],
                            ),
                            //height: MediaQuery.of(context).size.height / 9,
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            child: Text(
                              "تسجيل",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () => Move.to(
                                  context: context, page: RefereeSignINPage()),
                              child: Text(
                                "سجل الأن",
                                style: TextStyle(color: Color(0xffE31E24)),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text("لديك حساب بالفعل ؟")
                        ],
                      ),

                   /* Container(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 12,right:  MediaQuery.of(context).size.width / 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height:MediaQuery.of(context).size.height / 20,
                            width:MediaQuery.of(context).size.width / 3,
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(5),
                                                     color: Colors.white,
                                                     boxShadow: [
                                                       BoxShadow(
                                                         color: Colors.grey,
                                                         blurRadius: 2.0,
                                                         spreadRadius: 0.0,
                                                         offset: Offset(
                                                             2.0, 2.0), // shadow direction: bottom right
                                                       )
                                                     ],
                                                   ),
                            child: Text("Google",style:TextStyle(color: Colors.red[600],fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width / 20),),
                          ),
                          Container(
                            height:MediaQuery.of(context).size.height / 20,
                            width:MediaQuery.of(context).size.width / 3,
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(5),
                                                     color: Colors.blue[800],
                                                     boxShadow: [
                                                       BoxShadow(
                                                         color: Colors.grey,
                                                         blurRadius: 2.0,
                                                         spreadRadius: 0.0,
                                                         offset: Offset(
                                                             2.0, 2.0), // shadow direction: bottom right
                                                       )
                                                     ],
                                                   ),
                            child: Text("Facebook",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width / 20),),
                          ),
                        ],
                      ),
                    ),*/
                    /*  SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: ()=>Move.to(context: context, page: ComplainPage()),
                              child: Text(
                                "هنا",
                                style: TextStyle(color: Color(0xffE31E24)),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text("في حاله مواجهه أي مشكله قم بمراسلتنا من")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),*/
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  onPressed: () => Move.to(context: context, page:MyHomePage()),
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
          showProgress?getLoadingContainer(context):Container()
        ],
      ),
      bottomNavigationBar: getNavigationBar(context),
    );
  }
}
