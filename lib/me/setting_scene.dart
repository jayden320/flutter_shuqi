import 'package:flutter/material.dart';

import 'package:shuqi/public.dart';

class SettingScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (UserManager.instance.isLogin) {
      children.add(GestureDetector(
        onTap: () {
          Navigator.pop(context);
          UserManager.instance.logout();
        },
        child: Container(
          height: 50,
          color: Colors.white,
          child: Center(
            child: Text('退出登录', style: TextStyle(fontSize: 16, color: SQColor.red)),
          ),
        ),
      ));
    }
    return Scaffold(
      appBar: AppBar(title: Text('设置'), elevation: 0.5),
      body: Container(
        child: ListView(
          children: children,
        ),
      ),
    );
  }
}
