import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:shuqi/utility/event_bus.dart';

const String EventUserLogin = 'EventUserLogin';
const String EventUserLogout = 'EventUserLogout';

class UserManager {

  static UserManager _instance;
  static UserManager get instance => _getInstance();
  static UserManager _getInstance() {
    if (_instance == null) {
      _instance = new UserManager();
    }
    return _instance;
  }

  User user;
  static User get currentUser {
    return _instance.user;
  }

  logout() async {
    this.user = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');

    eventBus.emit(EventUserLogout);
  }

  login(Map<String, dynamic> userJson) {
    var user = User.fromJson(userJson);
    this.user = user;
    saveUser();

    eventBus.emit(EventUserLogin);
  }

  bool get isLogin {
    return user != null;
  }

  Future<User> loadUserFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString('user');
    if (userJson != null) {
      user = User.fromJson(json.decode(userJson));
    }
    return user;
  }

  void saveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = json.encode(user);
    prefs.setString('user', data);
  }
}

class User {
  String token;
  int id;
  String nickname;
  String avatarUrl;
  bool isVip;
  double wealth;
  int coupon;
  int monthlyTicket;

  User.fromJson(Map json) {
    token = json['token'];
    id = json['id'];
    nickname = json['nickname'];
    avatarUrl = json['avatar'];
    isVip = json['is_vip'] == 1;
    wealth = json['wealth'];
    coupon = json['coupon'];
    monthlyTicket = json['ticket'];
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'nickname': nickname,
      'avatar': avatarUrl,
      'is_vip': isVip ? 1 : 0,
      'wealth': wealth,
      'coupon': coupon,
      'ticket': monthlyTicket,
    };
  }
}
