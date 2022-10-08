import 'package:flutter/material.dart';
import 'package:flutter_application_3/Core/hexColor.dart';

class AllCategoriesModel {
  String title, dec, image, size, id, type;
  int price;
  Color color;

  AllCategoriesModel({
    required this.dec,
    required this.image,
    required this.price,
    required this.size,
    required this.title,
    required this.color,
    required this.id,
    required this.type,
  });
  factory AllCategoriesModel.fromJson(Map json) {
    return AllCategoriesModel(
      dec: json["dec"],
      image: json["image"],
      price: json["price"],
      size: json["size"],
      title: json["title"],
      id: json["id"],
      type: json["type"],
      color: HexColor.fromHex(json["color"]),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "dec": dec,
      "image": image,
      "price": price,
      "size": size,
      "color": color,
      "id": id,
      "type": type,
    };
  }
}
