import 'package:flutter/material.dart';

class ReaderPageAgent {
  static List<Map<String, int>> getPageOffsets(String content, double height, double width, double fontSize) {
    String tempStr = content;
    List<Map<String, int>> pageConfig = [];
    int last = 0;
    while (true) {
      Map<String, int> offset = {};
      offset['start'] = last;
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(text: tempStr, style: TextStyle(fontSize: fontSize));
      textPainter.layout(maxWidth: width);
      var end = textPainter.getPositionForOffset(Offset(width, height)).offset;

      if (end == 0) {
        break;
      }
      tempStr = tempStr.substring(end, tempStr.length);
      offset['end'] = last + end;
      last = last + end;
      pageConfig.add(offset);
    }
    return pageConfig;
  }
}
