
import 'package:flutter/material.dart';

class Screen {
  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static navigationBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + 44;
  }

  static statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static bottomSafeHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}