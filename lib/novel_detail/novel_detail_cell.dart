import 'package:flutter/material.dart';

import 'package:shuqi/public.dart';

class NovelDetailCell extends StatelessWidget {
  final String iconName;
  final String title;
  final String subtitle;
  final Widget attachedWidget;

  NovelDetailCell({this.iconName, this.title, this.subtitle, this.attachedWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Divider(height: 1),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                Image.asset(iconName),
                SizedBox(width: 5),
                Text(title, style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: SQColor.gray),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                attachedWidget != null ? attachedWidget : Container(),
                SizedBox(width: 10),
                Image.asset('img/arrow_right.png'),
              ],
            ),
          ),
          Divider(height: 1),
        ],
      ),
    );
  }
}
