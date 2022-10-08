import 'package:flutter/material.dart';
import 'package:flutter_application_3/View/Widget/customText.dart';
import 'package:flutter_application_3/iconBroken.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Model/categoriesModel.dart';
import 'homeController.dart';

class AllCategories extends StatelessWidget {
  AllCategories({super.key, required this.model});
  CategoriesModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: customText(
            text: model.name, fontWeight: FontWeight.w600, fontSize: 18),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(IconBroken.Arrow___Left_2),
        ),
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => controller.allCategoriesList.isEmpty
            ? Center(
                child: SvgPicture.asset(
                  "assets/image/soon.svg",
                  width: 150,
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  maxCrossAxisExtent: 2,

                  // childAspectRatio: 1.5,
                ),
                itemBuilder: (context, i) {
                  return SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        customText(text: "Essa"),
                        Container(
                          width: 200,
                          height: 200,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 6,
              ),
      ),
    );
  }
}
