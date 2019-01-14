import 'package:flutter/material.dart';

import 'package:shuqi/public.dart';

class NovelDetailToolbar extends StatelessWidget {
  read() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Screen.bottomSafeHeight),
      color: Colors.white,
      height: 50 + Screen.bottomSafeHeight,
      child: Row(children: <Widget>[
        Expanded(
          child: Center(
            child: Text(
              '加书架',
              style: TextStyle(fontSize: 16, color: SQColor.primary),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(color: SQColor.primary, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                '开始阅读',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              '下载',
              style: TextStyle(fontSize: 16, color: SQColor.primary),
            ),
          ),
        ),
      ]),
    );
  }
}
