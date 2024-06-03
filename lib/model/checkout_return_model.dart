import 'dart:convert';

CheckoutreturnModel checkoutreturnModelFromJson(String str) =>
    CheckoutreturnModel.fromJson(json.decode(str));

String checkoutreturnModelToJson(CheckoutreturnModel data) =>
    json.encode(data.toJson());

class CheckoutreturnModel {
  Data data;
  String? razorpayOrderId;

  CheckoutreturnModel({
    required this.data,
    this.razorpayOrderId,
  });

  factory CheckoutreturnModel.fromJson(Map<String, dynamic> json) =>
      CheckoutreturnModel(
        data: Data.fromJson(json["data"]),
        razorpayOrderId: json["razorpay_order_id"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "razorpay_order_id": razorpayOrderId,
      };
}

class Data {
  int id;
  String fullName;
  String contact;
  int postalCode;
  String address;
  String city;
  String state;
  String country;
  double total;
  double serviceCharges;
  double tax;
  double shippingCharges;
  double subTotal;
  String paymentType;
  String orderStatus;
  String paymentStatus;
  String serviceType;
  dynamic razorpayOrderId;
  String shipmentId;
  int shiprocketShipmentId;
  bool isActive;
  DateTime createdOn;
  List<OrderItem> orderItems;
  String order_invoice_number;

  Data({
    required this.id,
    required this.fullName,
    required this.contact,
    required this.postalCode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.total,
    required this.serviceCharges,
    required this.tax,
    required this.shippingCharges,
    required this.subTotal,
    required this.paymentType,
    required this.orderStatus,
    required this.paymentStatus,
    required this.serviceType,
    this.razorpayOrderId,
    required this.shipmentId,
    required this.shiprocketShipmentId,
    required this.isActive,
    required this.createdOn,
    required this.orderItems,
    required this.order_invoice_number,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        order_invoice_number: json["order_invoice_number"],
        id: json["id"],
        fullName: json["full_name"],
        contact: json["contact"],
        postalCode: json["postal_code"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        total: json["total"].toDouble(),
        serviceCharges: json["service_charges"].toDouble(),
        tax: json["tax"].toDouble(),
        shippingCharges: json["shipping_charges"].toDouble(),
        subTotal: json["sub_total"].toDouble(),
        paymentType: json["payment_type"],
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
        serviceType: json["service_type"],
        razorpayOrderId: json["razorpay_order_id"],
        shipmentId: json["shipment_id"],
        shiprocketShipmentId: json["shiprocket_shipment_id"],
        isActive: json["is_active"],
        createdOn: DateTime.parse(json["created_on"]),
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "contact": contact,
        "postal_code": postalCode,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "total": total,
        "service_charges": serviceCharges,
        "tax": tax,
        "shipping_charges": shippingCharges,
        "sub_total": subTotal,
        "payment_type": paymentType,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "service_type": serviceType,
        "razorpay_order_id": razorpayOrderId,
        "shipment_id": shipmentId,
        "shiprocket_shipment_id": shiprocketShipmentId,
        "is_active": isActive,
        "created_on": createdOn.toIso8601String(),
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "order_invoice_number": order_invoice_number,
      };
}

class OrderItem {
  Product product;
  dynamic productWeight;
  int qty;

  OrderItem({
    required this.product,
    this.productWeight,
    required this.qty,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        product: Product.fromJson(json["product"]),
        productWeight: json["product_weight"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "product_weight": productWeight,
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
    this.promotional,
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
