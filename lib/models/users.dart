// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  int id;
  String name;
  String email;
  DateTime? emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
