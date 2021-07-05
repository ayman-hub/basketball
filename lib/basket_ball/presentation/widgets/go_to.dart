

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
    transitionDuration:Duration(milliseconds: 100),
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,) =>
    page, transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}

class Move {
  static to({@required BuildContext context,@required Widget page}){
    Navigator.push(context, FadeRoute(page: page));
  }

  static noBack({@required BuildContext context,@required Widget page}){
    Navigator.pushReplacement(context, FadeRoute(page: page));
  }

  static back(BuildContext context){
    Navigator.pop(context);
  }

  static bottomSheet({@required BuildContext context,double minHeight,double maxHeight,Widget headContent, Widget bodyContent}){
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      isScrollControlled: true,
      builder:
          (BuildContext context) {
        return SolidBottomSheet(
            minHeight:minHeight,
            maxHeight: maxHeight,
            headerBar: headContent,
            body: bodyContent);
      },
    );
  }

}