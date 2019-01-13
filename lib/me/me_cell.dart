import 'package:flutter/material.dart';

import 'package:shuqi/public.dart';

class MeCell extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconName;
  final String title;

  MeCell({this.title, this.iconName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: SQColor.white,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  Image.asset(iconName),
                  SizedBox(width: 20),
                  Text(title, style: TextStyle(fontSize: 18)),
                  Expanded(child: Container()),
                  Image.asset('img/arrow_right.png'),
                ],
              ),
            ),
            Container(
              height: 1,
              color: SQColor.lightGray,
              margin: EdgeInsets.only(left: 60),
            ),
          ],
        ),
      ),
    );
  }
}
