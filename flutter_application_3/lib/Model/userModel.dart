class UserModel {
  String name;
  String email;
  String photo;
  String uid;
  UserModel(
      {required this.email,
      required this.name,
      required this.photo,
      required this.uid});
  factory UserModel.fromJson(Map json) {
    return UserModel(
      email: json["email"],
      name: json["name"],
      photo: json["photo"],
      uid: json["uid"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "photo": photo,
      "uid": uid,
    };
  }
}
