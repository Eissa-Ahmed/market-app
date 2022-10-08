import 'package:flutter/material.dart';
import 'package:flutter_application_3/Core/hexColor.dart';

class SellingModel {
  String title, dec, image, size, id;
  int price;
  Color color;

  SellingModel({
    required this.dec,
    required this.image,
    required this.price,
    required this.size,
    required this.title,
    required this.color,
    required this.id,
  });
  factory SellingModel.fromJson(Map json) {
    return SellingModel(
      dec: json["dec"],
      image: json["image"],
      price: json["price"],
      size: json["size"],
      title: json["title"],
      id: json["id"],
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
    };
  }
}
