import 'dart:convert';

import 'package:shuqi/utility/event_bus.dart';
import 'package:shuqi/global.dart';

const String EventUserLogin = 'EventUserLogin';
const String EventUserLogout = 'EventUserLogout';

class UserManager {
  static UserManager instance = UserManager();

  User? user;
  static User? get currentUser {
    return UserManager.instance.user;
  }

  logout() {
    this.user = null;
    preferences.remove('user');
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

  loadUserFromLocal() {
    String? userJson = preferences.getString('user');
    if (userJson != null) {
      user = User.fromJson(json.decode(userJson));
    }
  }

  void saveUser() async {
    var data = json.encode(user);
    preferences.setString('user', data);
  }
}

class User {
  late String token;
  late int id;
  late String nickname;
  late String avatarUrl;
  late bool isVip;
  late double wealth;
  late int coupon;
  late int monthlyTicket;

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
