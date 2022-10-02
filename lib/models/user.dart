// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// import 'dart:convert';

// User userFromJson(String str) => User.fromJson(json.decode(str));

// String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? username;
  String? password;
  String? name;

  User({
    this.id,
    this.username,
    this.password,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "name": name,
      };
}
