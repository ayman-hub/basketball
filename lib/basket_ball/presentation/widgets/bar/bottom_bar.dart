import 'package:fancy_bottom_navigation/paint/half_clipper.dart';
import 'package:fancy_bottom_navigation/paint/half_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hi_market/basket_ball/presentation/widgets/bar/tab_bar.dart';
import 'package:hi_market/basket_ball/presentation/widgets/getNavigationBar.dart';
import 'dart:math'as math;

const double CIRCLE_SIZE = 60;
const double ARC_HEIGHT = 70;
const double ARC_WIDTH = 90;
const double CIRCLE_OUTLINE = 10;
const double SHADOW_ALLOWANCE = 20;
const double BAR_HEIGHT = 60;
Color borderColor = Colors.transparent;

class FancyBottomNavigation extends StatefulWidget {
  FancyBottomNavigation(
      {@required this.tabs,
      @required this.onTabChangedListener,
      this.key,
      this.initialSelection = 0,
      this.circleColor,
      this.activeIconColor,
      this.inactiveIconColor,
      this.textColor,
      this.borderColor,
      this.notTaped = false,
      this.barBackgroundColor})
      : assert(onTabChangedListener != null),
        assert(tabs != null),
        assert(tabs.length > 1 && tabs.length < 8);

  final Function(int position) onTabChangedListener;
  final Color circleColor;
  final Color borderColor;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Color textColor;
  final Color barBackgroundColor;
  final List<TabData> tabs;
  final int initialSelection;
  bool notTaped;

  final Key key;

  @override
  FancyBottomNavigationState createState() => FancyBottomNavigationState();
}

class FancyBottomNavigationState extends State<FancyBottomNavigation>
    with TickerProviderStateMixin, RouteAware {
  Widget nextIcon = Container();
  Widget activeIcon = Container();

  int currentSelected = 0;
  double _circleAlignX = 0;
  double _circleIconAlpha = 1;

  Color circleColor;
  Color activeIconColor;
  Color inactiveIconColor;
  Color barBackgroundColor;
  Color textColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    activeIcon = widget.tabs[currentSelected].icon;

    circleColor = widget.circleColor ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Theme.of(context).primaryColor);
    borderColor = widget.borderColor ?? Colors.white
        /*  ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Theme.of(context).primaryColor)*/
        ;

    activeIconColor = widget.activeIconColor ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.black54
            : Colors.white);

    barBackgroundColor = widget.barBackgroundColor ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Color(0xFF212121)
            : Colors.white);
    textColor = widget.textColor ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Colors.black54);
    inactiveIconColor = (widget.inactiveIconColor) ??
        ((Theme.of(context).brightness == Brightness.dark)
            ? Colors.white
            : Theme.of(context).primaryColor);
  }

  @override
  void initState() {
    super.initState();
    _setSelected(widget.tabs[widget.initialSelection].key);
  }

  _setSelected(UniqueKey key) {
    int selected = widget.tabs.indexWhere((tabData) => tabData.key == key);
    print('selected::::$selected');
    if (mounted) {
      setState(() {
        borderColor = (selected == 5) ? Colors.white : Color(0xffc9c9c9);
        currentSelected = selected;
        _circleAlignX = -1 + (2 / (widget.tabs.length - 1) * selected);
        nextIcon = widget.tabs[selected].icon;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: BAR_HEIGHT,
          padding: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: barBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(
                    10)) , boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
          ]
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.tabs
                .map((t) => TabItem(
                    uniqueKey: t.key,
                    selected: t.key == widget.tabs[currentSelected].key,
                    icon: t.icon,
                    title: t.title,
                    notTabed: widget.notTaped,
                    iconColor: inactiveIconColor,
                    textColor: textColor,
                    callbackFunction: (uniqueKey) {
                      int selected = widget.tabs
                          .indexWhere((tabData) => tabData.key == uniqueKey);
                      widget.onTabChangedListener(selected);
                      _setSelected(uniqueKey);
                      _initAnimationAndStart(_circleAlignX, 1);
                    }))
                .toList(),
          ),
        ),
        widget.notTaped
            ? Container(
                height: 10,
              )
            : Positioned.fill(
                top: -(CIRCLE_SIZE + CIRCLE_OUTLINE + SHADOW_ALLOWANCE) / 2,
                child: Container(
                  child: AnimatedAlign(
                    duration: Duration(milliseconds: ANIM_DURATION),
                    curve: Curves.easeOut,
                    alignment: Alignment(_circleAlignX, 1),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: FractionallySizedBox(
                        widthFactor: 1 / widget.tabs.length,
                        child: GestureDetector(
                          onTap: widget.tabs[currentSelected].onclick as void
                              Function(),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: CIRCLE_SIZE +
                                    CIRCLE_OUTLINE +
                                    SHADOW_ALLOWANCE,
                                width: CIRCLE_SIZE +
                                    CIRCLE_OUTLINE +
                                    SHADOW_ALLOWANCE,
                                child: ClipRect(
                                    clipper: HalfClipper(),
                                    child: Container(
                                      child: Center(
                                        child: Container(
                                            width: CIRCLE_SIZE + CIRCLE_OUTLINE,
                                            height:
                                                CIRCLE_SIZE + CIRCLE_OUTLINE,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              /* boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 8)
                                          ]*/
                                            )),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                  height: ARC_HEIGHT,
                                  width: ARC_WIDTH,
                                  child: CustomPaint(
                                    painter: HalfPainter(Colors.transparent),
                                  )),
                              SizedBox(
                                height: CIRCLE_SIZE *3.7/4,
                                width: CIRCLE_SIZE *3.7/4,
                                child: Stack(
                                  children: [
                                    MyArc(diameter: CIRCLE_SIZE *3.7/4),
                                    Container(
                                      height: CIRCLE_SIZE *3.7/4,
                                      width: CIRCLE_SIZE *3.7/4,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: circleColor,
                                          border: Border.all(
                                              width: 5,
                                              color: Colors.transparent)),
                                      margin: EdgeInsets.all(5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: AnimatedOpacity(
                                          duration: Duration(
                                              milliseconds: ANIM_DURATION ~/ 5),
                                          opacity: _circleIconAlpha,
                                          child: activeIcon,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }

  _initAnimationAndStart(double from, double to) {
    _circleIconAlpha = 0;

    Future.delayed(Duration(milliseconds: ANIM_DURATION ~/ 5), () {
      setState(() {
        activeIcon = nextIcon;
      });
    }).then((_) {
      Future.delayed(Duration(milliseconds: (ANIM_DURATION ~/ 5 * 3)), () {
        setState(() {
          _circleIconAlpha = 1;
        });
      });
    });
  }

  void setPage(int page) {
    print("getPage:::" + page.toString());
    if (!(widget.notTaped)) {
      widget.onTabChangedListener(page);
      _setSelected(widget.tabs[page].key);
      _initAnimationAndStart(_circleAlignX, 1);

      setState(() {
        currentSelected = page;
        print('currentSelected::::$currentSelected');
      });
    }
  }
}

class TabData {
  TabData({@required this.icon, @required this.title, this.onclick});

  Widget icon;
  String title;
  Function onclick;
  final UniqueKey key = UniqueKey();
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = borderColor;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi *2,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
