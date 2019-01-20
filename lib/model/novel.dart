import 'package:flutter/material.dart';
import 'package:shuqi/app/sq_color.dart';

import 'chapter.dart';

class Novel {
  String id;
  String name;
  String imgUrl;
  String firstChapter;
  Chapter lastChapter;
  String author;
  double price;
  double score;
  String type;
  String introduction;
  int chapterCount;
  int recommendCount;
  int commentCount;
  int firstArticleId;

  List<String> roles;
  String status;
  double wordCount;
  List<String> tags;
  bool isLimitedFree;

  Novel.fromJson(Map data) {
    id = data['bid'];
    firstArticleId = data['first_article_id'];
    name = data['bookname'];
    imgUrl = data['book_cover'];
    firstChapter = data['topic_first'];
    if (data['lastChapter'] != null) {
      lastChapter = Chapter.fromJson(data['lastChapter']);
    }
    score = data['score'];
    author = data['author_name'];
    price = double.parse(data['price'] ?? '0');
    type = data['class_name'];
    introduction = data['introduction'];
    chapterCount = int.parse(data['chapterNum'] ?? '0');
    recommendCount = int.parse(data['recommend_num'] ?? '0');
    commentCount = int.parse(data['comment_count'] ?? '0');

    status = data['stat_name'];
    wordCount = data['wordCount'];
    tags = data['tag']?.cast<String>()?.toList();

    isLimitedFree = data['is_free'] == 1;
  }

  String recommendCountStr() {
    if (recommendCount >= 10000) {
      return (recommendCount / 10000).toStringAsFixed(1) + '万人推荐';
    } else {
      return recommendCount.toString() + '人推荐';
    }
  }

  Color statusColor() {
    return status == '连载' ? SQColor.blue : SQColor.primary;
  }
}
