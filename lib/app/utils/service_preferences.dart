import 'dart:convert';
import 'dart:developer';

import 'package:apps_consultation_pregnant/app/modules/home/models/my_profile/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServicePreferences extends GetxService {
  static late SharedPreferences preferences;

  static final keyToken = 'token';
  static final keyMyProfile = 'myProfile';

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static Future clear() async {
    preferences.clear();
  }

  static Future setToken(String token) async {
    await preferences.setString(keyToken, token);
  }

  static String? getToken() {
    final data = preferences.getString(keyToken);

    if (data != null) return data;
    return null;
  }

  static Future setMyProfile(Map data) async {
    String dataEncode = jsonEncode(data);
    await preferences.setString(keyMyProfile, dataEncode);
  }

  static User? getMyProfile() {
    final data = preferences.getString(keyMyProfile);
    if (data != null) return User.fromJson(data);
    return null;
  }
}
