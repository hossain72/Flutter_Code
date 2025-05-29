import 'dart:convert';

import 'package:flutter_code/app/core/utils/safe_parse.dart';

UserModel userModeFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModeToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? status = false;
  String? message = "failed";
  List<User>? data;

  UserModel({this.status, this.message, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: safeParse<bool>(json['status'], 'status'),
    message: safeParse<String>(json['message'], 'message'),
    data:
    json["data"] == null
        ? []
        : List<User>.from(json["data"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data":
    data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobileNumber;

  User({this.id, this.name, this.email, this.mobileNumber});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: safeParse<int>(json['user_id'], 'user_id'),
    name: safeParse<String>(json['user_name'], 'user_name'),
    mobileNumber: safeParse<String>(json['user_mobile'], 'user_mobile'),
    email: safeParse<String>(json['user_email'], 'user_email'),
  );

  Map<String, dynamic> toJson() => {
    "user_id": id,
    "name": name,
    "mobile_number": mobileNumber,
    "email": email,
  };
}
