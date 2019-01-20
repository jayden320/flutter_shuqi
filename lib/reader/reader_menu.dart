import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:shuqi/public.dart';

class ReaderMenu extends StatefulWidget {
  final VoidCallback onTap;
  ReaderMenu({this.onTap});

  @override
  _ReaderMenuState createState() => _ReaderMenuState();
}

class _ReaderMenuState extends State<ReaderMenu> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  buildTopMenu(BuildContext context) {
    return Positioned(
      top: -Screen.navigationBarHeight * (1 - animation.value),
      left: 0,
      right: 0,
      child: Container(
        height: Screen.navigationBarHeight,
        padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 5, 0),
        color: SQColor.darkGray,
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('img/pub_back_white.png'),
              ),
            ),
            Expanded(child: Container()),
            Container(
              width: 44,
              child: Image.asset('img/read_icon_voice.png'),
            ),
            Container(
              width: 44,
              child: Image.asset('img/read_icon_more.png'),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomMenu() {
    return Positioned(
      bottom: -(Screen.bottomSafeHeight + 60) * (1 - animation.value),
      left: 0,
      right: 0,
      child: Container(
        color: SQColor.darkGray,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildBottomItem('目录', 'img/read_icon_catalog.png'),
            buildBottomItem('亮度', 'img/read_icon_brightness.png'),
            buildBottomItem('字体', 'img/read_icon_font.png'),
            buildBottomItem('设置', 'img/read_icon_setting.png'),
          ],
        ),
      ),
    );
  }

  buildBottomItem(String title, String icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[
          Image.asset(icon),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: fixedFontSize(12), color: SQColor.lightGray)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              animationController.reverse();
              Timer(Duration(milliseconds: 200), () {
                this.widget.onTap();
              });
            },
            child: Container(color: Colors.transparent),
          ),
          buildTopMenu(context),
          buildBottomMenu(),
        ],
      ),
    );
  }
}
