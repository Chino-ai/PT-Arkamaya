// To parse this JSON data, do
//
//     final singleUser = singleUserFromJson(jsonString);

import 'dart:convert';

import 'package:pt_arkamaya/model/support.dart';

SingleUser singleUserFromJson(String str) => SingleUser.fromJson(json.decode(str));

String singleUserToJson(SingleUser data) => json.encode(data.toJson());

class SingleUser {
  SingleUser({
    required this.data,
    required this.support,
  });

  Data data;
  Support support;

  factory SingleUser.fromJson(Map<String, dynamic> json) => SingleUser(
    data: Data.fromJson(json["data"]),
    support: Support.fromJson(json["support"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "support": support.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };
}


