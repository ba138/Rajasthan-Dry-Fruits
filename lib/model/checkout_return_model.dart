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
  String orderInvoiceNumber;
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
  String shipmentType;
  String paymentStatus;
  String serviceType;
  dynamic razorpayOrderId;
  String shipmentId;
  int shiprocketShipmentId;
  bool isActive;
  DateTime createdOn;
  List<OrderItem> orderItems;

  Data({
    required this.id,
    required this.orderInvoiceNumber,
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
    required this.shipmentType,
    required this.paymentStatus,
    required this.serviceType,
    this.razorpayOrderId,
    required this.shipmentId,
    required this.shiprocketShipmentId,
    required this.isActive,
    required this.createdOn,
    required this.orderItems,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        orderInvoiceNumber: json["order_invoice_number"],
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
        shipmentType: json["shipment_type"],
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
        "order_invoice_number": orderInvoiceNumber,
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
        "shipment_type": shipmentType,
        "payment_status": paymentStatus,
        "service_type": serviceType,
        "razorpay_order_id": razorpayOrderId,
        "shipment_id": shipmentId,
        "shiprocket_shipment_id": shiprocketShipmentId,
        "is_active": isActive,
        "created_on": createdOn.toIso8601String(),
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
      };
}

class OrderItem {
  Product product;
  ProductWeight productWeight;
  int qty;
  double price;
  double totalDiscount;
  double taxDiscountPercentage;
  double totalPrice;

  OrderItem({
    required this.product,
    required this.productWeight,
    required this.qty,
    required this.price,
    required this.totalDiscount,
    required this.taxDiscountPercentage,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        product: Product.fromJson(json["product"]),
        productWeight: ProductWeight.fromJson(json["product_weight"]),
        qty: json["qty"],
        price: json["price"].toDouble(),
        totalDiscount: json["total_discount"].toDouble(),
        taxDiscountPercentage: json["tax_discount_percentage"].toDouble(),
        totalPrice: json["total_price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "product_weight": productWeight.toJson(),
        "qty": qty,
        "price": price,
        "total_discount": totalDiscount,
        "tax_discount_percentage": taxDiscountPercentage,
        "total_price": totalPrice,
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

class Product {
  String id;
  String sku;
  String title;
  String slug;
  String? hsnCode;
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
    this.hsnCode,
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
