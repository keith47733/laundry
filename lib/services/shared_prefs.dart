import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/controllers/c_user.dart';
import '../models/user.dart';

class SharedPrefs {
  static final _cUser = Get.put(CUser());

  static Future<bool> saveUser(User user) async {
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = jsonEncode(mapUser);
    bool success = await pref.setString('user', stringUser);
    if (success) {
      _cUser.data = user;
    }
    return success;
  }

  static Future<User> getUser() async {
    User user = User();
    //Timer(const Duration(seconds: 3), () {});
    final pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user = User.fromJson(mapUser);
    }
    _cUser.data = user;
    return user;
  }

  static Future<bool> clearUser() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('user');
    _cUser.data = User();
    return success;
  }
}
