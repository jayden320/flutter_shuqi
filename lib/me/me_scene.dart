import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shuqi/public.dart';
import 'me_header.dart';
import 'setting_scene.dart';
import 'me_cell.dart';

class MeScene extends StatelessWidget {
  Widget buildCells(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          MeCell(
            title: '钱包',
            iconName: 'img/me_wallet.png',
            onPressed: () {},
          ),
          MeCell(
            title: '消费充值记录',
            iconName: 'img/me_record.png',
            onPressed: () {},
          ),
          MeCell(
            title: '购买的书',
            iconName: 'img/me_buy.png',
            onPressed: () {},
          ),
          MeCell(
            title: '我的会员',
            iconName: 'img/me_vip.png',
            onPressed: () {},
          ),
          MeCell(
            title: '绑兑换码',
            iconName: 'img/me_coupon.png',
            onPressed: () {},
          ),
          MeCell(
            title: '阅读之约',
            iconName: 'img/me_date.png',
            onPressed: () {},
          ),
          MeCell(
            title: '公益行动',
            iconName: 'img/me_action.png',
            onPressed: () {},
          ),
          MeCell(
            title: '我的收藏',
            iconName: 'img/me_favorite.png',
            onPressed: () {},
          ),
          MeCell(
            title: '打赏记录',
            iconName: 'img/me_record.png',
            onPressed: () {},
          ),
          MeCell(
            title: '我的书评',
            iconName: 'img/me_comment.png',
            onPressed: () {},
          ),
          MeCell(
            title: '个性换肤',
            iconName: 'img/me_theme.png',
            onPressed: () {},
          ),
          MeCell(
            title: '设置',
            iconName: 'img/me_setting.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SettingScene();
              }));
            },
          ),
          MeCell(
            title: 'Github',
            iconName: 'img/me_feedback.png',
            onPressed: () {
              AppNavigator.pushWeb(context, 'https://github.com/huanxsd/flutter_shuqi', 'Github');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              MeHeader(),
              SizedBox(height: 10),
              buildCells(context),
            ],
          ),
        ),
      ),
    );
  }
}
