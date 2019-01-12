import 'package:shuqi/model/novel.dart';

class HomeModule {
  String id;
  String name;
  int style;
  List content;

  List<CarouselInfo> carousels;
  List<MenuInfo> menus;
  List<Novel> books;

  HomeModule.fromJson(Map data) {
    id = data['id'];
    name = data['m_s_name'];
    content = data['content'];

    if (name == '顶部banner') {
      carousels = [];
      content.forEach((data) {
        carousels.add(CarouselInfo.fromJson(data));
      });
    }

    if (name == '顶部导航') {
      menus = [];
      content.forEach((data) {
        menus.add(MenuInfo.fromJson(data));
      });
    }

    if (data['m_s_style'] != null) {
      style = data['m_s_style'];
      books = [];
      content.forEach((data) {
        books.add(Novel.fromJson(data));
      });
    }
  }
}

class MenuInfo {
  String title;
  String icon;

  MenuInfo.fromJson(Map data) {
    title = data['toTitle'];
    icon = data['icon'];
  }
}

class CarouselInfo {
  String imageUrl;
  String link;

  CarouselInfo.fromJson(Map data) {
    imageUrl = data['image_url'];
    link = data['link_url'];
  }
}
