import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constance.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (CachHelper.sharedPreferences!.get("uid") != null) {
      return RouteSettings(name: "/home");
    } else {
      return null;
    }
  }
}
