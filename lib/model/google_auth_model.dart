// To parse this JSON data, do
//
//     final googleAuthModel = googleAuthModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GoogleAuthModel googleAuthModelFromJson(String str) =>
    GoogleAuthModel.fromJson(json.decode(str));

String googleAuthModelToJson(GoogleAuthModel data) =>
    json.encode(data.toJson());

class GoogleAuthModel {
  String accessToken;
  String code;
  String idToken;

  GoogleAuthModel({
    required this.accessToken,
    required this.code,
    required this.idToken,
  });

  factory GoogleAuthModel.fromJson(Map<String, dynamic> json) =>
      GoogleAuthModel(
        accessToken: json["access_token"],
        code: json["code"],
        idToken: json["id_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "code": code,
        "id_token": idToken,
      };
}
