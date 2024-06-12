// To parse this JSON data, do
//
//     final reviewHistoryModel = reviewHistoryModelFromJson(jsonString);

import 'dart:convert';

List<ReviewHistoryModel> reviewHistoryModelFromJson(String str) =>
    List<ReviewHistoryModel>.from(
        json.decode(str).map((x) => ReviewHistoryModel.fromJson(x)));

String reviewHistoryModelToJson(List<ReviewHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewHistoryModel {
  Product product;
  int rate;
  String comment;
  int order;
  int client;

  ReviewHistoryModel({
    required this.product,
    required this.rate,
    required this.comment,
    required this.order,
    required this.client,
  });

  factory ReviewHistoryModel.fromJson(Map<String, dynamic> json) =>
      ReviewHistoryModel(
        product: Product.fromJson(json["product"]),
        rate: json["rate"],
        comment: json["comment"],
        order: json["order"],
        client: json["client"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "rate": rate,
        "comment": comment,
        "order": order,
        "client": client,
      };
}

class Product {
  String id;
  String sku;
  String title;
  String slug;
  dynamic hsnCode;
  String description;
  String thumbnailImage;
  String price;
  int discount;
  dynamic promotional;
  int totalReviews;
  int averageReview;

  Product({
    required this.id,
    required this.sku,
    required this.title,
    required this.slug,
    required this.hsnCode,
    required this.description,
    required this.thumbnailImage,
    required this.price,
    required this.discount,
    required this.promotional,
    required this.totalReviews,
    required this.averageReview,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        sku: json["sku"],
        title: json["title"],
        slug: json["slug"],
        hsnCode: json["hsn_code"],
        description: json["description"],
        thumbnailImage: json["thumbnail_image"],
        price: json["price"],
        discount: json["discount"],
        promotional: json["promotional"],
        totalReviews: json["total_reviews"],
        averageReview: json["average_review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "title": title,
        "slug": slug,
        "hsn_code": hsnCode,
        "description": description,
        "thumbnail_image": thumbnailImage,
        "price": price,
        "discount": discount,
        "promotional": promotional,
        "total_reviews": totalReviews,
        "average_review": averageReview,
      };
}
