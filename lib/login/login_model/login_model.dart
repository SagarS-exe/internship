// To parse this JSON data, do
//
//     final loginUserData = loginUserDataFromJson(jsonString);

import 'dart:convert';

LoginUserData loginUserDataFromJson(String str) => LoginUserData.fromJson(json.decode(str));

String loginUserDataToJson(LoginUserData data) => json.encode(data.toJson());

class LoginUserData {
  String message;
  User user;

  LoginUserData({
    required this.message,
    required this.user,
  });

  factory LoginUserData.fromJson(Map<String, dynamic> json) => LoginUserData(
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  int id;
  String name;
  int age;
  String username;
  String password;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    age: json["age"],
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "age": age,
    "username": username,
    "password": password,
  };
}
