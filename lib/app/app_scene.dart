import 'package:flutter/material.dart';
import 'package:shuqi/public.dart';
import 'package:shuqi/app/root_scene.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShuQi',
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: SQColor.primary,
        dividerColor: Color(0xffeeeeee),
      ),
      home: RootScene(),
    );
  }
}
