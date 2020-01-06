# 高仿书旗小说 Flutter 版

[简书](https://www.jianshu.com/p/aed5e319b313)

## 加入我们

掌中云文化传媒有限公司，技术部招募精兵强将！！！

地址：

福州市软件园

岗位：

一、前端工程师

二、iOS工程师

三、Android工程师

四、PHP工程师

五、测试工程师

六、UI设计师

欢迎各位小伙伴加入，联系QQ：67111677

##  screen shot for iOS

<img src="https://github.com/huanxsd/flutter_shuqi/blob/master/screenshot/ios_0.png">

<img src="https://github.com/huanxsd/flutter_shuqi/blob/master/screenshot/ios_1.png">

<img src="https://github.com/huanxsd/flutter_shuqi/blob/master/screenshot/ios_2.png">

## screen shot for Android

<img src="https://github.com/huanxsd/flutter_shuqi/blob/master/screenshot/android_0.png">

<img src="https://github.com/huanxsd/flutter_shuqi/blob/master/screenshot/android_1.png">

<img src="https://github.com/huanxsd/flutter_shuqi/blob/master/screenshot/android_2.png">

## Setup

1. **Clone the repo**

```
$ git clone https://github.com/huanxsd/flutter_shuqi.git
$ cd flutter_shuqi
```

2. **Running:**

```
$ flutter run
```

## Dependency

* [carousel_slider](https://pub.flutter-io.cn/packages/carousel_slider)
* [cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image)
* [shared_preferences](https://pub.flutter-io.cn/packages/shared_preferences)
* [flutter_webview_plugin](https://pub.flutter-io.cn/packages/flutter_webview_plugin)
* [share](https://pub.flutter-io.cn/packages/share)

## Contact

If you have any suggestions, leave a message here
[简书](https://www.jianshu.com/p/aed5e319b313)


## 简介

这是一个用Flutter写的书旗小说客户端。

主要实现的功能有：
* 框架：App常用的Tab框架，UI根据系统字体设定自适应；
* 书城：3D轮播、菜单、五种通过API配置的卡片样式；
* 小说详情：导航栏样式切换动效、高斯模糊效果、文字伸缩；
* 书架：顶部云彩动效、导航栏样式切换动效、书籍展示；
* 我的：未登录/登录状态切换，菜单展示；
* 登录：获取验证码、用户登录、用户状态缓存、用户注销；
* 阅读：文章加载、横向翻页、菜单展示。

所有功能都是用Dart写的，iOS和Android的代码复用率达到了100%

我试着让这个Demo的结构尽量接近实际项目，同时使用比较简单方式去实现功能。这样可以让刚接触Flutter的人更够容易理解代码。

App中的网络请求均通过一个名为**Request**的工具类。在Request内部，通过**本地mock**方式，获取模拟数据。

[安卓版扫码下载](https://www.pgyer.com/shuqinovel)
![image.png](https://upload-images.jianshu.io/upload_images/5685774-a37c28262e46ba76.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 第三方依赖

* [carousel_slider](https://pub.flutter-io.cn/packages/carousel_slider)
* [cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image)
* [shared_preferences](https://pub.flutter-io.cn/packages/shared_preferences)
* [flutter_webview_plugin](https://pub.flutter-io.cn/packages/flutter_webview_plugin)
* [share](https://pub.flutter-io.cn/packages/share)

## 安装

1. **Clone the repo**

```
$ git clone https://github.com/huanxsd/flutter_shuqi.git
$ cd flutter_shuqi
```

2. **Running:**

```
$ flutter run
```

## License

MIT

## 最后

如果你喜欢这个项目，欢迎给我一个star。我将持续更新这个项目   :)

也欢迎在[Github主页](https://github.com/huanxsd)关注我的其他项目。
