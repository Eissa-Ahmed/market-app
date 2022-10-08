import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Model/cardModel.dart';
import 'package:flutter_application_3/View/Home/homeController.dart';
import 'package:flutter_application_3/constance.dart';
import 'package:flutter_application_3/iconBroken.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Widget/customText.dart';

class CardShop extends GetWidget<HomeController> {
  const CardShop({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => ConditionalBuilder(
        condition: controller.cardModelList.isNotEmpty,
        builder: (context) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.separated(
                    itemBuilder: (context, i) {
                      return ItemCard(model: controller.cardModelList[i], i: i);
                    },
                    separatorBuilder: (context, i) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.cardModelList.length,
                  ),
                ),
              ),
              GetBuilder<HomeController>(
                builder: (c) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          customText(text: "Price"),
                          customText(
                            text: "\$ ${controller.totalPrice}",
                            colorFont: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          width: 120,
                          height: 55,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: customText(
                              text: "CHECK OUT", colorFont: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        fallback: (context) {
          return Center(
              child: SvgPicture.asset(
            "assets/image/empty.svg",
            width: 150,
          ));
        },
      ),
    );
  }

  Widget ItemCard({required CardModel model, required int i}) {
    return GetBuilder<HomeController>(
      builder: (c) => Dismissible(
        key: UniqueKey(),
        background: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                color: Colors.amber[600],
                child: const Icon(
                  IconBroken.Star,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Icon(
                  IconBroken.Delete,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        onDismissed: (dir) async {
          if (dir == DismissDirection.endToStart) {
            controller.removeItemFromCard(model.title);
          } else {
            print("Favorite");
          }
        },
        child: SlideInDown(
          from: 0.0,
          delay: const Duration(milliseconds: 100),
          animate: false,
          duration: const Duration(milliseconds: 700),
          child: Container(
            width: double.infinity,
            height: 140,
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: model.image,
                  fit: BoxFit.fill,
                  width: 150,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  progressIndicatorBuilder: (context, url, progress) =>
                      const Center(child: CircularProgressIndicator()),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: model.title,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      customText(
                        text: "\$ ${model.price}",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        colorFont: primaryColor,
                      ),
                      GetBuilder<HomeController>(
                        builder: (c) => Container(
                          width: 140,
                          height: 45,
                          color: Colors.grey[300],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  controller.plus(model.idCard);
                                },
                                child: customText(text: "+"),
                              ),
                              customText(
                                  text: "${controller.cardModelList[i].count}",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              TextButton(
                                onPressed: () {
                                  controller.minus(model.idCard);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: customText(
                                      text: "_", fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
