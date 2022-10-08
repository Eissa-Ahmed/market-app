import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/Home/homeController.dart';
import 'package:flutter_application_3/iconBroken.dart';
import 'package:get/get.dart';

import '../../constance.dart';

class Home extends GetWidget<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => ConditionalBuilder(
        condition: !controller.isLoading,
        builder: (context) {
          return Scaffold(
            bottomNavigationBar: customBottomNavigationBer(),
            body: SafeArea(
              child: controller.screens[controller.currentIndex],
            ),
          );
        },
        fallback: (context) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }

  customBottomNavigationBer() {
    return GetBuilder<HomeController>(
      builder: (controller) => BottomNavigationBar(
        selectedItemColor: primaryColor,
        currentIndex: controller.currentIndex,
        elevation: 0.0,
        backgroundColor: Colors.white,
        onTap: (index) => controller.changeIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(IconBroken.Home),
            ),
            label: "",
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Explore"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(IconBroken.Buy),
            ),
            label: "",
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Card"),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(IconBroken.Profile),
            ),
            label: "",
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Account"),
            ),
          ),
        ],
      ),
    );
  }
}
