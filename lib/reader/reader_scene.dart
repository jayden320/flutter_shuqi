import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:shuqi/public.dart';

import 'article_provider.dart';
import 'reader_utils.dart';
import 'reader_config.dart';

import 'reader_page_agent.dart';
import 'battery_view.dart';
import 'reader_menu.dart';

class ReaderScene extends StatefulWidget {
  final int articleId;

  ReaderScene({this.articleId});

  @override
  ReaderSceneState createState() => ReaderSceneState();
}

class ReaderSceneState extends State<ReaderScene> {
  int articleId;
  int pageIndex = 0;
  bool isMenuVisiable = false;
  Article article;
  PageController pageController = PageController(keepPage: false);
  bool isLoading = false;

  double topSafeHeight = 0;

  @override
  void initState() {
    super.initState();
    articleId = this.widget.articleId;
    pageController.addListener(() {
      var offset = pageController.offset;
      var pageCount = article.pageOffsets.length;
      var contentWidth = Screen.width;

      if (offset < 0 && !isLoading && article.preArticleId > 0) {
        isLoading = true;
        previousPage();
      }
      if (offset / contentWidth > pageCount - 1  && !isLoading) {
        isLoading = true;
        nextPage();
      }
    });

    setup();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void setup() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    // 不延迟的话，安卓获取到的topSafeHeight是错的。
    await Future.delayed(const Duration(milliseconds: 100), () {});
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    topSafeHeight = Screen.topSafeHeight;
    var article = await fetchArticle(articleId);

    setState(() {
      this.article = article;
    });
  }

  Future<Article> fetchArticle(int articleId) async {
    var article = await ArticleProvider.fetchArticle(articleId);
    var contentHeight = Screen.height - topSafeHeight - ReaderUtils.topOffset - Screen.bottomSafeHeight - ReaderUtils.bottomOffset - 20;
    var contentWidth = Screen.width - 15 - 10;
    article.pageOffsets = ReaderPageAgent.getPageOffsets(article.content, contentHeight, contentWidth, ReaderConfig.instance.fontSize);

    return article;
  }

  onTap(Offset position) async {
    double xRate = position.dx / Screen.width;
    if (xRate > 0.33 && xRate < 0.66) {
      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
      setState(() {
        isMenuVisiable = true;
      });
    } else if (xRate >= 0.66) {
      nextPage();
    } else {
      previousPage();
    }
  }

  previousPage() async {
    if (pageIndex == 0 && article.preArticleId == 0) {
      Toast.show('已经是第一页了');
      return;
    }

    if (pageIndex == 0) {
      Article preArticle = await fetchArticle(article.preArticleId);
      pageIndex = preArticle.pageOffsets.length - 1;
      pageController.jumpToPage(pageIndex);
      setState(() {
        isLoading = false;
        article = preArticle;
      });
    } else {
      pageController.previousPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  nextPage() async {
    if (pageIndex >= article.pageOffsets.length - 1 && article.nextArticleId == 0) {
      Toast.show('已经是最后一页了');
      return;
    }
    if (pageIndex >= article.pageOffsets.length - 1) {
      Article nextArticle = await fetchArticle(article.nextArticleId);
      pageIndex = 0;
      pageController.jumpToPage(pageIndex);
      setState(() {
        isLoading = false;
        article = nextArticle;
      });
    } else {
      pageController.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  buildOverlayer() {
    var format = DateFormat('HH:mm');
    var time = format.format(DateTime.now());

    return Container(
      padding: EdgeInsets.fromLTRB(15, 10 + topSafeHeight, 15, 10 + Screen.bottomSafeHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.title, style: TextStyle(fontSize: fixedFontSize(14), color: SQColor.gray)),
          Expanded(child: Container()),
          Row(
            children: <Widget>[
              BatteryView(),
              SizedBox(width: 10),
              Text(time, style: TextStyle(fontSize: fixedFontSize(11), color: SQColor.gray)),
              Expanded(child: Container()),
              Text('第${pageIndex + 1}页', style: TextStyle(fontSize: fixedFontSize(11), color: SQColor.gray)),
            ],
          ),
        ],
      ),
    );
  }

  buildContent() {
    if (article == null) {
      return Container();
    }

    return Container(
      child: PageView.builder(
        controller: pageController,
        itemCount: article != null ? article.pageOffsets.length : 0,
        itemBuilder: (BuildContext context, int index) {
          var content = article.stringAtPageIndex(index);
          return GestureDetector(
            onTapUp: (TapUpDetails details) {
              onTap(details.globalPosition);
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.fromLTRB(15, topSafeHeight + ReaderUtils.topOffset, 10, Screen.bottomSafeHeight + ReaderUtils.bottomOffset),
              child: Text.rich(
                TextSpan(children: [TextSpan(text: content, style: TextStyle(fontSize: fixedFontSize(ReaderConfig.instance.fontSize)))]),
                textAlign: TextAlign.justify,
              ),
            ),
          );
        },
        onPageChanged: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }

  buildMenu() {
    if (!isMenuVisiable) {
      return Container();
    }
    return ReaderMenu(onTap: () {
      setState(() {
        SystemChrome.setEnabledSystemUIOverlays([]);
        this.isMenuVisiable = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (article == null) {
      return Scaffold();
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildOverlayer(),
          buildContent(),
          buildMenu(),
        ],
      ),
    );
  }
}
