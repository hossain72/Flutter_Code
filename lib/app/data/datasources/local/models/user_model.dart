import 'dart:convert';

UserModel userModeFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModeToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? status = false;
  String? message = "failed";
  List<User>? data;

  UserModel({this.status, this.message, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status:
        json[""
            "status"],
    message: json["message"],
    data:
        json["data"] == null
            ? []
            : List<User>.from(json["data"]!.map((x) => User.fromJson(x))),
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

  factory User.fromJson(Map<String, dynamic> json) =>  User(
    id: json['user_id'] as int?,
    name: json['user_name'] as String?,
    mobileNumber: json['user_mobile'] as String?,
    email: json['user_email'] as String?,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mobile_number": mobileNumber,
    "email": email,
  };
}
