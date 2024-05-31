// To parse this JSON data, do
//
//     final googleKeyModel = googleKeyModelFromJson(jsonString);

import 'dart:convert';

GoogleKeyModel googleKeyModelFromJson(String str) =>
    GoogleKeyModel.fromJson(json.decode(str));

String googleKeyModelToJson(GoogleKeyModel data) => json.encode(data.toJson());

class GoogleKeyModel {
  String key;

  GoogleKeyModel({
    required this.key,
  });

  factory GoogleKeyModel.fromJson(Map<String, dynamic> json) => GoogleKeyModel(
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
      };
}
