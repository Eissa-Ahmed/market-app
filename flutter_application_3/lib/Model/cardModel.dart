class CardModel {
  String image, title, idCard;
  int price;
  int count;
  CardModel(
      {this.count = 1,
      required this.image,
      required this.price,
      required this.idCard,
      required this.title});
  factory CardModel.fromJson(Map json) {
    return CardModel(
      count: json["count"],
      image: json["image"],
      idCard: json["idcard"],
      price: json["price"],
      title: json["title"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "image": image,
      "price": price,
      "count": count,
      "idCard": idCard,
    };
  }
}
