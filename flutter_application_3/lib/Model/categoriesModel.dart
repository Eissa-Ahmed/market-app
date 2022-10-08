class CategoriesModel {
  String name, image, type;
  CategoriesModel(
      {required this.image, required this.name, required this.type});
  factory CategoriesModel.fromJson(Map json) {
    return CategoriesModel(
        image: json["photo"], name: json["name"], type: json["type"]);
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "photo": image,
      "type": type,
    };
  }
}
