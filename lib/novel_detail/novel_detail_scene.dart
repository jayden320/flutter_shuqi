import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:shuqi/public.dart';

import 'novel_detail_header.dart';
import 'novel_summary_view.dart';
import 'novel_detail_toolbar.dart';
import 'novel_detail_recommend_view.dart';
import 'novel_detail_cell.dart';
import 'novel_comment_cell.dart';

class NovelDetailScene extends StatefulWidget {
  final String novelId;

  NovelDetailScene(this.novelId);

  @override
  NovelDetailSceneState createState() => NovelDetailSceneState();
}

class NovelDetailSceneState extends State<NovelDetailScene> {
  Novel novel;
  List<Novel> recommendNovels = [];
  List<NovelComment> comments = [];
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  bool isSummaryUnfold = false;
  int commentCount = 0;
  int commentMemberCount = 0;

  @override
  void initState() {
    super.initState();
    fetchData();

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha == 1) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        }
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        if (navAlpha == 1) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        }
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  changeSummaryMaxLines() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }

  read() {}

  back() {
    Navigator.pop(context);
  }

  fetchData() async {
    var novelId = this.widget.novelId;

    var novelResponse = await Request.post(action: 'novel_detail', params: {'id': novelId});

    var commentsResponse = await Request.post(action: 'novel_comment', params: {'id': novelId});
    List<NovelComment> comments = [];
    commentsResponse.forEach((data) {
      comments.add(NovelComment.fromJson(data));
    });

    var recommendResponse = await Request.post(action: 'novel_recommend', params: {'id': novelId});
    List<Novel> recommendNovels = [];
    recommendResponse.forEach((data) {
      recommendNovels.add(Novel.fromJson(data));
    });

    Timer(Duration(milliseconds: 500), () {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    });

    setState(() {
      this.novel = Novel.fromJson(novelResponse);
      this.comments = comments;
      this.recommendNovels = recommendNovels;
    });
  }

  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Container(
          width: 44,
          margin: EdgeInsets.fromLTRB(5, Screen.statusBarHeight(context), 0, 0),
          child: GestureDetector(onTap: back, child: Image.asset('img/pub_back_white.png')),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, Screen.statusBarHeight(context), 0, 0),
            height: Screen.navigationBarHeight(context),
            color: SQColor.white,
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  child: GestureDetector(onTap: back, child: Image.asset('img/pub_back_gray.png')),
                ),
                Expanded(
                  child: Text(
                    novel.name,
                    style: TextStyle(fontSize: 17, color: SQColor.darkGray, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(width: 44),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildComment() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                Image.asset('img/home_tip.png'),
                SizedBox(width: 13),
                Text('书友评价', style: TextStyle(fontSize: 16, color: SQColor.darkGray)),
                Expanded(child: Container()),
                Image.asset('img/detail_write_comment.png'),
                Text('  写书评', style: TextStyle(fontSize: 14, color: SQColor.primary)),
                SizedBox(width: 15),
              ],
            ),
          ),
          Divider(height: 1),
          Column(
            children: comments.map((comment) => NovelCommentCell(comment)).toList(),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                '查看全部评论（${novel.commentCount}条）',
                style: TextStyle(fontSize: 14, color: SQColor.gray),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTags() {
    var colors = [Color(0xFFF9A19F), Color(0xFF59DDB9), Color(0xFF7EB3E7)];
    var i = 0;
    var tagWidgets = novel.tags.map((tag) {
      var color = colors[i % 3];
      var tagWidget = Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(99, color.red, color.green, color.blue), width: 0.5),
          borderRadius: BorderRadius.circular(3),
        ),
        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
        child: Text(tag, style: TextStyle(fontSize: 14, color: colors[i % 3])),
      );
      i++;
      return tagWidget;
    }).toList();
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      color: SQColor.white,
      child: Wrap(runSpacing: 10, spacing: 10, children: tagWidgets),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.novel == null) {
      return Scaffold(appBar: AppBar(elevation: 0, brightness: Brightness.dark));
    }
    return Scaffold(
      backgroundColor: SQColor.paper,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.only(top: 0),
                  children: <Widget>[
                    NovelDetailHeader(novel),
                    NovelSummaryView(novel.introduction, isSummaryUnfold, changeSummaryMaxLines),
                    NovelDetailCell(
                      'img/detail_latest.png',
                      '最新',
                      novel.lastChapter.name,
                      Text(novel.status, style: TextStyle(fontSize: 14, color: novel.statusColor())),
                    ),
                    NovelDetailCell(
                      'img/detail_chapter.png',
                      '目录',
                      '共${novel.chapterCount}章',
                      null,
                    ),
                    buildTags(),
                    Container(height: 10, color: SQColor.paper),
                    buildComment(),
                    Container(height: 10, color: SQColor.paper),
                    NovelDetailRecommendView(recommendNovels),
                  ],
                ),
              ),
              NovelDetailToolbar(),
            ],
          ),
          buildNavigationBar(),
        ],
      ),
    );
  }
}
