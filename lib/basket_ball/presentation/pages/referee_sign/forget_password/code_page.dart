
import 'package:flutter/material.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';

import '../../../../../res.dart';
import 'forget_password_password_page.dart';

class CodePage extends StatefulWidget {
  CodePage({Key key}) : super(key: key);

  @override
  _CodePageState createState() {
    return _CodePageState();
  }
}

class _CodePageState extends State<CodePage> {
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
          leading:  IconButton(icon: Image.asset(Res.backimage,color: Color(0xffE31E24),), onPressed: ()=>Move.back(context))),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(Res.blackballimage),
          ),
          Container(
            child: Image.asset(Res.email_blocker),
            alignment: Alignment.topCenter,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left:MediaQuery.of(context).size.width / 15,right: MediaQuery.of(context).size.width / 15,top: MediaQuery.of(context).size.height / 4,bottom: MediaQuery.of(context).size.height /4),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text("تم إرسال الرابط الخاص بإعاده تعيين كلمه المرورقم بالرجوع للبريك الاكترونى الخاص بك",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(onPressed: null, child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                      child: Text("إعاده ارسال",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),),
                    )),
                    SizedBox(width: 30,),
                    FlatButton(onPressed: ()=>Move.to(context: context, page: ForgetPasswordPasswordPage()), child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                      child: Text("تم التوصيل",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),),
                    )),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: null,
                        child: Text("هنا",style: TextStyle(color: Color(0xffE31E24)),)),
                    SizedBox(width: 30,),
                    Text("في حاله مواجهه أي مشكله قم بمراسلتنا من")
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: getNavigationBar(context),
    );
  }
}