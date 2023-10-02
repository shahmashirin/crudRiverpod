

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String? name;
  String? phone;
  bool? delete;
  int? age;
  String? uid;
  DocumentReference?reference;

  UserData({
    this.name,
    this.phone,
    this.delete,
    this.age,
    this.uid,
    this.reference,
  });

  UserData copyWith({
    String? name,
    String? phone,
    bool? delete,
    int? age,
    String? uid,
    DocumentReference?reference,
  }) =>
      UserData(
        name: name ?? this.name,
        phone: phone ?? this.phone,
        delete: delete ?? this.delete,
        age: age ?? this.age,
        uid: uid ?? this.uid,
        reference: reference ?? this.reference,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    name: json["name"],
    phone: json["phone"],
    delete: json["delete"],
    age: json["age"],
    uid: json["uid"],
    reference: json["reference"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "delete": delete,
    "age": age,
    "uid": uid,
    "reference": reference,
  };
}
