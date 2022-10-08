import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Model/categoriesModel.dart';
import 'package:flutter_application_3/Model/sellingModel.dart';
import 'package:flutter_application_3/View/Home/categories.dart';
import 'package:flutter_application_3/View/Home/details.dart';
import 'package:flutter_application_3/View/Home/homeController.dart';
import 'package:flutter_application_3/View/Widget/customText.dart';
import 'package:flutter_application_3/constance.dart';
import 'package:flutter_application_3/iconBroken.dart';
import 'package:get/get.dart';

class Explore extends GetWidget<HomeController> {
  Explore({super.key});
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              customSearch(),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                child: customText(
                  text: "Categories",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return itemCategories(model: controller.categoriesModel[i]);
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(
                      width: 15,
                    );
                  },
                  itemCount: controller.categoriesModel.length,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    text: "Best Selling",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.left,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: customText(text: "See All"),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 370,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return itemSellong(
                        model: controller.sellingModel[i], context: context);
                  },
                  separatorBuilder: (context, i) {
                    return const SizedBox(
                      width: 15,
                    );
                  },
                  itemCount: controller.sellingModel.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container customSearch() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          hintText: "Search",
          border: InputBorder.none,
          prefixIcon: Icon(IconBroken.Search),
        ),
      ),
    );
  }

  Widget itemCategories({required CategoriesModel model}) {
    return InkWell(
      onTap: () {
        Get.to(() => AllCategories(
              model: model,
            ));
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: CachedNetworkImage(
              imageUrl: model.image,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              progressIndicatorBuilder: (context, url, progress) =>
                  const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          customText(
            text: model.name,
            fontSize: 14,
          ),
        ],
      ),
    );
  }

  Widget itemSellong({required SellingModel model, required context}) {
    return GetBuilder<HomeController>(
      builder: (c) => InkWell(
        onTap: () {
          Get.to(
            () => Details(model: model),
          );
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: model.title,
                child: CachedNetworkImage(
                  imageUrl: model.image,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 250,
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                  progressIndicatorBuilder: (context, url, progress) =>
                      const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              customText(text: model.title),
              const SizedBox(
                height: 10,
              ),
              Text(
                model.dec,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 15,
              ),
              customText(
                text: "\$ ${model.price}",
                colorFont: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
