import 'package:flutter/material.dart';
import 'package:shuqi/public.dart';
import 'package:shuqi/app/root_scene.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '书旗小说',
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        dividerColor: Color(0xffeeeeee),
        scaffoldBackgroundColor: SQColor.paper,
        textTheme: TextTheme(bodyLarge: TextStyle(color: SQColor.darkGray)),
      ),
      home: RootScene(),
    );
  }
}
