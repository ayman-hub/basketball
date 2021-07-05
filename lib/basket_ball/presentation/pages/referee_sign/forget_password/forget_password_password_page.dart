
import 'package:flutter/material.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';
import 'package:hi_market/basket_ball/presentation/widgets/go_to.dart';

import '../../../../../res.dart';

class ForgetPasswordPasswordPage extends StatefulWidget {
  ForgetPasswordPasswordPage({Key key}) : super(key: key);

  @override
  _ForgetPasswordPasswordPageState createState() {
    return _ForgetPasswordPasswordPageState();
  }
}

class _ForgetPasswordPasswordPageState extends State<ForgetPasswordPasswordPage> {
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
                  child: Text("إعاده تعيين كلمه المرور",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                SizedBox(height: 10,),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    maxLines: 1,
                    onChanged: (value) {},
                    style: TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(
                        hintText: "كلمه المرور الجديده",
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(height: 10,),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    maxLines: 1,
                    onChanged: (value) {},
                    style: TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(
                        hintText: "تأكيد كلمه المرور الجديده",
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        labelStyle: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                SizedBox(height: 10,),
                FlatButton(onPressed: null, child: Container(
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
                  child: Text("تسجيل",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20),),
                )),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: null,
                        child: Text("هنا",style: TextStyle(color: Color(0xffE31E24)),)),
                    SizedBox(width: 10,),
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