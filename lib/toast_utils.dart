import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

//fluttertoast: ^3.1.3
void showToast(BuildContext context, String msg) {
  var platform = Theme.of(context).platform;
  platform == TargetPlatform.iOS
      ? Get.snackbar("", "",
          messageText: Text(
            msg,
            textAlign: TextAlign.center,
          ))
      : Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 25,);
  ;
}
