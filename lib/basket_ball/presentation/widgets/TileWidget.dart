import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_market/basket_ball/data/data_sources/constant_data.dart';

class TileWidget extends StatelessWidget {
  TileWidget(this.title, {this.isHtml = false, Key key, this.style}) : super(key: key);
  String title;
  bool isHtml;
  Style style ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 11,
            height: 41,
            color: staticColor,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: isHtml
                  ? getTitle(title,style:style)
                  : Text(
                      '$title',
                      style: GoogleFonts.cairo(fontSize: 15),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ))
        ],
      ),
    );
  }
}
