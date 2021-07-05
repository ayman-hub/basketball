
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/domain/entities/response_failure.dart';
import 'package:hi_market/basket_ball/domain/use_cases/case.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';

import '../../../../../injection.dart';
import '../../../../../res.dart';
import '../../../../../toast_utils.dart';
import '../referee_sing_in_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({Key key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() {
    return _ForgetPasswordPageState();
  }
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String email;

  final formKey = GlobalKey<FormState>();

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
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              icon: Image.asset(
                Res.backimage,
                color: Color(0xffE31E24),
              ),
              onPressed: () => Move.back(context))),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(Res.blackballimage),
          ),
         ListView(
           children: [
             Container(
               //decoration: BoxDecoration(border: Border.all(color: Colors.white)),
               child: Image.asset(Res.email_blocker),
               alignment: Alignment.topCenter,
             ),
             Form(
               key: formKey,
               child: Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 padding: EdgeInsets.all(10),
                 margin: EdgeInsets.only(
                     left: MediaQuery.of(context).size.width / 15,
                     right: MediaQuery.of(context).size.width / 15,
                     top: 20,
                     bottom: MediaQuery.of(context).size.height / 7),
                 child: Column(
                   children: [
                     Container(
                       alignment: Alignment.center,
                       child: Text(
                         "نسيت كلمه المرور ؟",
                         style: TextStyle(
                             color: Colors.black,
                             fontWeight: FontWeight.bold,
                             fontSize: 20),
                       ),
                     ),
                     SizedBox(
                       height: 30,
                     ),
                     Directionality(
                       textDirection: TextDirection.rtl,
                       child: TextFormField(
                         maxLines: 1,
                         onChanged: (value) {
                           setState(() {
                             email = value;
                           });
                         },
                         validator: (value) {
                           if (value.isEmpty) {
                             return "يجب كتابة البريد الاكتروني";
                           }
                           return null;
                         },
                         style: TextStyle(fontSize: 15.0),
                         decoration: InputDecoration(
                             hintText: "البريد الاكترونى",
                             contentPadding:
                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                             border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(32.0)),
                             labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                       ),
                     ),
                     SizedBox(
                       height: 30,
                     ),
                     FlatButton(
                         onPressed: () async {
                           if (formKey.currentState.validate()) {
                             var response =
                             await sl<Cases>().forgetPassword(email);
                             if (response is bool) {
                               var platform = Theme.of(context).platform;
                               platform == TargetPlatform.iOS
                                   ? Get.snackbar("", "",
                                   messageText: Text(
                                     "يتم ارسال الباسورد الجديد للبريد الاكتروني",
                                     textAlign: TextAlign.center,
                                   ))
                                   : showToast(context,"يتم ارسال الباسورد الجديد للبريد الاكتروني");
                               Move.to(context: context, page: RefereeSignINPage());
                             } else if (response is ResponseModelFailure) {
                               var platform = Theme.of(context).platform;
                               platform == TargetPlatform.iOS
                                   ? Get.snackbar("", "",
                                   messageText: Text(
                                     response.message,
                                     textAlign: TextAlign.center,
                                   ))
                                   : showToast(context,response.message);
                             }
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
                       height: 30,
                     ),
                     /*    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: null,
                          child: Text("هنا",style: TextStyle(color: Color(0xffE31E24)),)),
                      SizedBox(width: 30,),
                      Text("في حاله مواجهه أي مشكله قم بمراسلتنا من")
                    ],
                  ),
                  SizedBox(height: 10,),*/
                   ],
                 ),
               ),
             ),
           ],
         )
        ],
      ),
      bottomNavigationBar: getNavigationBar(context),
    );
  }
}
