import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color primaryColor = Color.fromRGBO(0, 197, 105, 1);

class CachHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveData({required String key, required dynamic value}) async {
    if (value is String) {
      await sharedPreferences!.setString(key, value);
    } else if (value is int) {
      await sharedPreferences!.setInt(key, value);
    } else {
      await sharedPreferences!.setBool(key, value);
    }
  }
}

var uid = CachHelper.sharedPreferences!.get("uid") ?? "";

MaterialColor swatchColor = const MaterialColor(
  0xFF00C569,
  {
    50: Color(0xFF00C569),
    100: Color(0xFF00C569),
    200: Color(0xFF00C569),
    300: Color(0xFF00C569),
    400: Color(0xFF00C569),
    500: Color(0xFF00C569),
    600: Color(0xFF00C569),
    700: Color(0xFF00C569),
    800: Color(0xFF00C569),
    900: Color(0xFF00C569),
  },
);
