// To parse this JSON data, do
//
//     final orderDetailedModel = orderDetailedModelFromJson(jsonString);

import 'dart:convert';

List<OrderDetailedModel> orderDetailedModelFromJson(String str) =>
    List<OrderDetailedModel>.from(
        json.decode(str).map((x) => OrderDetailedModel.fromJson(x)));

String orderDetailedModelToJson(List<OrderDetailedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetailedModel {
  String fullName;
  String contact;
  String postalCode;
  String address;
  String city;
  String state;
  String country;
  int total;
  double serviceCharges;
  int shippingCharges;
  int subTotal;
  String paymentType;
  String orderStatus;
  String paymentStatus;
  bool isActive;
  DateTime createdOn;
  List<OrderItem> orderItems;

  OrderDetailedModel({
    required this.fullName,
    required this.contact,
    required this.postalCode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.total,
    required this.serviceCharges,
    required this.shippingCharges,
    required this.subTotal,
    required this.paymentType,
    required this.orderStatus,
    required this.paymentStatus,
    required this.isActive,
    required this.createdOn,
    required this.orderItems,
  });

  factory OrderDetailedModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailedModel(
        fullName: json["full_name"],
        contact: json["contact"],
        postalCode: json["postal_code"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        total: json["total"],
        serviceCharges: json["service_charges"]?.toDouble(),
        shippingCharges: json["shipping_charges"],
        subTotal: json["sub_total"],
        paymentType: json["payment_type"],
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
        isActive: json["is_active"],
        createdOn: DateTime.parse(json["created_on"]),
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "contact": contact,
        "postal_code": postalCode,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "total": total,
        "service_charges": serviceCharges,
        "shipping_charges": shippingCharges,
        "sub_total": subTotal,
        "payment_type": paymentType,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "is_active": isActive,
        "created_on": createdOn.toIso8601String(),
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class OrderItem {
  Product product;
  ProductWeight productWeight;
  int qty;

  OrderItem({
    required this.product,
    required this.productWeight,
    required this.qty,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        product: Product.fromJson(json["product"]),
        productWeight: ProductWeight.fromJson(json["product_weight"]),
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "product_weight": productWeight.toJson(),
        "qty": qty,
      };
}

class Product {
  String id;
  String sku;
  String title;
  String slug;
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
        "description": description,
        "thumbnail_image": thumbnailImage,
        "price": price,
        "discount": discount,
        "promotional": promotional,
        "total_reviews": totalReviews,
        "average_review": averageReview,
      };
}

class ProductWeight {
  int id;
  String price;
  Weight weight;

  ProductWeight({
    required this.id,
    required this.price,
    required this.weight,
  });

  factory ProductWeight.fromJson(Map<String, dynamic> json) => ProductWeight(
        id: json["id"],
        price: json["price"],
        weight: Weight.fromJson(json["weight"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "weight": weight.toJson(),
      };
}

class Weight {
  int id;
  String name;

  Weight({
    required this.id,
    required this.name,
  });

  factory Weight.fromJson(Map<String, dynamic> json) => Weight(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
