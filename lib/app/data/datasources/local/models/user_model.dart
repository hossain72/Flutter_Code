import 'dart:convert';

UserMode userModeFromJson(String str) => UserMode.fromJson(json.decode(str));

String userModeToJson(UserMode data) => json.encode(data.toJson());

class UserMode {
  bool? status = false;
  String? message = "failed";
  List<User>? data;

  UserMode({this.status, this.message, this.data});

  factory UserMode.fromJson(Map<String, dynamic> json) => UserMode(
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
  String? gender;
  String? email;
  String? mobileNumber;

  User({this.id, this.name, this.gender, this.email, this.mobileNumber});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    gender: json["gender"],
    mobileNumber: json["mobile_number"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "gender": gender,
    "mobile_number": mobileNumber,
    "email": email,
  };
}
