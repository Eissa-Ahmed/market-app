import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Model/sellingModel.dart';
import 'package:flutter_application_3/View/Home/homeController.dart';
import 'package:flutter_application_3/View/Widget/customText.dart';
import 'package:flutter_application_3/constance.dart';
import 'package:flutter_application_3/iconBroken.dart';
import 'package:get/get.dart';

class Details extends GetWidget<HomeController> {
  Details({super.key, required this.model});

  SellingModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Hero(
                  tag: model.title,
                  child: CachedNetworkImage(
                    imageUrl: model.image,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder: (context, url, progress) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        IconBroken.Star,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 15,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      IconBroken.Arrow___Left_2,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: model.title,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customText(text: "Size"),
                                  customText(
                                      text: model.size,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customText(text: "Color"),
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: model.color,
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      customText(
                        text: "Details",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      customText(
                        text: model.dec,
                        colorFont: Colors.grey[500]!,
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(text: "Price", colorFont: Colors.grey),
                      const SizedBox(
                        height: 5,
                      ),
                      customText(
                          text: "\$ ${model.price}",
                          colorFont: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                  GetBuilder<HomeController>(
                    builder: (c) => InkWell(
                      onTap: () async {
                        await controller.addCard(
                          image: model.image,
                          price: model.price,
                          title: model.title,
                          id: model.id,
                        );
                        controller.loadDataCard();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 700),
                        alignment: Alignment.center,
                        width: 100,
                        height: 55,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: controller.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : SlideInLeft(
                                animate: true,
                                child: customText(
                                    text: controller.btnAddCard,
                                    colorFont: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
