import 'package:flutter/material.dart';

import 'package:shuqi/public.dart';


class Router {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  // 小说详情
  static pushNovelDetail(BuildContext context, Novel novel) {
  }
}
