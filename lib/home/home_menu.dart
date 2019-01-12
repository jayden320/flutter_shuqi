import 'package:flutter/material.dart';

import 'package:shuqi/public.dart';

import 'home_model.dart';

class HomeMenu extends StatelessWidget {
  final List<MenuInfo> infos;

  HomeMenu(this.infos);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: infos.map((info) => menuItem(info)).toList(),
      ),
    );
  }

  Widget menuItem(MenuInfo info) {
    return Column(
      children: <Widget>[
        Image.asset(info.icon),
        SizedBox(height: 5),
        Text(info.title, style: TextStyle(fontSize: 12, color: SQColor.gray)),
      ],
    );
  }
}
