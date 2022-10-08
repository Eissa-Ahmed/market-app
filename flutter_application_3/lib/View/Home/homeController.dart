import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Model/allCategoriesModel.dart';
import 'package:flutter_application_3/Model/cardModel.dart';
import 'package:flutter_application_3/Model/categoriesModel.dart';
import 'package:flutter_application_3/Model/sellingModel.dart';
import 'package:flutter_application_3/Model/userModel.dart';
import 'package:flutter_application_3/View/Home/account.dart';
import 'package:flutter_application_3/View/Home/cardShop.dart';
import 'package:flutter_application_3/View/Home/explore.dart';
import 'package:flutter_application_3/constance.dart';
import 'package:get/get.dart';

import '../../Core/dataBaseLocal.dart';

// enum Type { men, games, women, gadgets, devices }

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //var
  UserModel? userInfo;
  bool isLoading = false;
  int currentIndex = 0;
  String btnAddCard = "ADD";
  double totalPrice = 0;
  //Lists
  List<CategoriesModel> categoriesModel = [];
  List<SellingModel> sellingModel = [];
  List<CardModel> cardModelList = [];
  List<AllCategoriesModel> allCategoriesList = [];
  List<Widget> screens = [
    Explore(),
    CardShop(),
    Account(),
  ];

  @override
  void onInit() async {
    await loadDataUser();
    await loadCategories();
    await loadSeliing();
    await allCategories();
    await loadDataCard();
    await changeTotalPrice();
    super.onInit();
  }

  //Change Index
  changeIndex(index) {
    currentIndex = index;
    update();
  }

// Load Data User
  loadDataUser() async {
    print(uid);
    isLoading = true;
    update();
    await firestore.collection("users").doc(uid.toString()).get().then((value) {
      userInfo = UserModel.fromJson(value.data()!);
      isLoading = false;
      update();
    }).catchError((onError) {
      print(onError.toString());
    });
  }

//Load Categories
  loadCategories() async {
    isLoading = true;
    update();
    firestore.collection("Categories").get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        categoriesModel.add(
          CategoriesModel.fromJson(value.docs[i].data()),
        );
      }
    }).catchError((onError) {
      print(onError.toString());
    });
    isLoading = false;
    update();
  }

// Load Selling
  loadSeliing() async {
    isLoading = true;
    update();
    await firestore.collection("selling").get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        sellingModel.add(
          SellingModel.fromJson(
            value.docs[i].data(),
          ),
        );
      }
      isLoading = false;
      update();
    }).catchError((onError) {
      print("XXXXXXXXXXXXXXXXXXXXXXXXXXX");
      print(onError.toString());
    });
  }

//Add Card
  addCard(
      {required String image,
      required String title,
      required String id,
      required int price}) async {
    isLoading = true;
    update();
    CardModel model =
        CardModel(image: image, price: price, title: title, idCard: id);
    await SqlDb()
        .insertData(
            'INSERT INTO card (image , price , title , count , idcard) VALUES ("${model.image}" , "${model.price}" ,"${model.title}" , "${model.count}"  , "${model.idCard}")')
        .then((value) async {
      isLoading = false;
      btnAddCard = "Done";
      update();
      await Future.delayed(
          const Duration(seconds: 1), () => btnAddCard = "ADD");
      update();
    }).catchError((onError) {
      print(onError.toString());
    });
  }

//Load Data From DataBase Local Card
  loadDataCard() async {
    cardModelList = [];
    await SqlDb().readData("SELECT * FROM card ").then((value) async {
      for (var i = 0; i < value.length; i++) {
        cardModelList.add(CardModel.fromJson(value[i]));
      }
      await changeTotalPrice();
      update();
    }).catchError((onError) {
      print("Not Done ===========");
      print(onError.toString());
    });
  }

//Remove Item From Card
  removeItemFromCard(String title) async {
    await SqlDb()
        .deleteData("DELETE FROM card WHERE title = '$title' ")
        .then((value) async {
      await loadDataCard();
      await changeTotalPrice();
      update();
      print("Done Delete");
    }).catchError((onError) {
      print(onError.toString());
    });
  }

// Plus & minus

  plus(String id) async {
    for (var i = 0; i < cardModelList.length; i++) {
      if (id == cardModelList[i].idCard && cardModelList[i].count >= 1) {
        cardModelList[i].count += 1;
        await SqlDb()
            .updateData(
                'UPDATE card SET count = ${cardModelList[i].count} WHERE idcard = "$id" ')
            .then((value) {
          changeTotalPrice();
          update();
        }).catchError((onError) {});
      }
      update();
    }
  }

  minus(String id) async {
    for (var i = 0; i < cardModelList.length; i++) {
      if (id == cardModelList[i].idCard && cardModelList[i].count > 1) {
        cardModelList[i].count -= 1;
        await SqlDb()
            .updateData(
                'UPDATE card SET count = ${cardModelList[i].count} WHERE idcard = "$id" ')
            .then((value) {
          changeTotalPrice();
          update();
        }).catchError((onError) {});
      }
      update();
    }
  }

// Total Price
  changeTotalPrice() {
    totalPrice = 0;
    for (var i = 0; i < cardModelList.length; i++) {
      totalPrice += (cardModelList[i].price) * cardModelList[i].count;
    }
    update();
  }

//All Categories
  allCategories() async {
    await firestore.collection("allCategories").get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        allCategoriesList.add(
          AllCategoriesModel.fromJson(
            value.docs[i].data(),
          ),
        );
      }
      print(allCategoriesList.length);
      update();
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}
