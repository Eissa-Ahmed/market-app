import 'package:flutter_application_3/View/Auth/controller.dart';
import 'package:flutter_application_3/View/Home/homeController.dart';
import 'package:flutter_application_3/View/Home/userController.dart';
import 'package:get/get.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => UserController());
  }
}
