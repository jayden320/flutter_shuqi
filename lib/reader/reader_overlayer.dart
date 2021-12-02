import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shuqi/public.dart';
import 'battery_view.dart';

class ReaderOverlayer extends StatelessWidget {
  final Article article;
  final int page;
  final double topSafeHeight;

  ReaderOverlayer({required this.article, required this.page, required this.topSafeHeight});

  @override
  Widget build(BuildContext context) {
    var format = DateFormat('HH:mm');
    var time = format.format(DateTime.now());

    return Container(
      padding: EdgeInsets.fromLTRB(15, 10 + topSafeHeight, 15, 10 + Screen.bottomSafeHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.title, style: TextStyle(fontSize: fixedFontSize(14), color: SQColor.golden)),
          Expanded(child: Container()),
          Row(
            children: <Widget>[
              BatteryView(),
              SizedBox(width: 10),
              Text(time, style: TextStyle(fontSize: fixedFontSize(11), color: SQColor.golden)),
              Expanded(child: Container()),
              Text('第${page + 1}页', style: TextStyle(fontSize: fixedFontSize(11), color: SQColor.golden)),
            ],
          ),
        ],
      ),
    );
  }
}