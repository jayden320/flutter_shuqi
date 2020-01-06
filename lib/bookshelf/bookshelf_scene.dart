import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shuqi/public.dart';

import 'bookshelf_item_view.dart';
import 'bookshelf_header.dart';
// 书架场景
class BookshelfScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookshelfState();
}

class BookshelfState extends State<BookshelfScene> with RouteAware {
  List<Novel> favoriteNovels = [];
  ScrollController scrollController = ScrollController();
  double navAlpha = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
    // 滚动监听 设置状态栏显示或隐藏
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  Future<void> fetchData() async {
    try {
      List<Novel> favoriteNovels = [];
      List<dynamic> favoriteResponse = await Request.get(action: 'bookshelf');
      favoriteResponse.forEach((data) {
        favoriteNovels.add(Novel.fromJson(data));
      });

      setState(() {
        this.favoriteNovels = favoriteNovels;
      });
    } catch (e) {
      Toast.show(e.toString());
    }
  }
  // 顶部右侧按钮
  Widget buildActions(Color iconColor) {
    return Row(children: <Widget>[
      Container(
        height: kToolbarHeight,
        width: 44,
        child: Image.asset('img/actionbar_checkin.png', color: iconColor),
      ),
      Container(
        height: kToolbarHeight,
        width: 44,
        child: Image.asset('img/actionbar_search.png', color: iconColor),
      ),
      SizedBox(width: 15)
    ]);
  }
  // 顶部导航
  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            child: buildActions(SQColor.white),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            height: Screen.navigationBarHeight,
            color: SQColor.white,
            child: Row(
              children: <Widget>[
                SizedBox(width: 103),
                Expanded(
                  child: Text(
                    '书架',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                buildActions(SQColor.darkGray),
              ],
            ),
          ),
        )
      ],
    );
  }
  // 收藏view 
  Widget buildFavoriteView() {
    if (favoriteNovels.length <= 1) {
      return Container();
    }

    List<Widget> children = [];
    var novels = favoriteNovels.sublist(1);
    novels.forEach((novel) {
      children.add(BookshelfItemView(novel));
    });
    var width = (Screen.width - 15 * 2 - 24 * 2) / 3;
    children.add(GestureDetector(
      onTap: () {
        // 点击收藏会触发切换tabbar的事件
        eventBus.emit(EventToggleTabBarIndex, 1);
      },
      child: Container(
        color: SQColor.paper,
        width: width,
        height: width / 0.75,
        child: Image.asset('img/bookshelf_add.png'),
      ),
    ));
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
      child: Wrap(
        spacing: 23,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SQColor.white,
      body: AnnotatedRegion(
        value: navAlpha > 0.5 ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Stack(children: [
          RefreshIndicator(
            onRefresh: fetchData,
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              controller: scrollController,
              children: <Widget>[
                //构建顶部widget
                favoriteNovels.length > 0 ? BookshelfHeader(favoriteNovels[0]) : Container(),
                buildFavoriteView(),
              ],
            ),
          ),
          buildNavigationBar(),
        ]),
      ),
    );
  }
}
