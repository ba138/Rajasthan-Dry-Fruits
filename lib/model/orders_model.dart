class OrderDetailedModel {
  int id;
  String fullName;
  String contact;
  String postalCode;
  String address;
  String city;
  String state;
  String country;
  String? razorpayOrderId; // Nullable razorpayOrderId
  double total;
  double serviceCharges;
  double shippingCharges; // Changed to double
  double subTotal; // Changed to double
  String paymentType;
  String orderStatus;
  String paymentStatus;
  bool isActive;
  DateTime createdOn;
  int client;

  OrderDetailedModel({
    required this.id,
    required this.fullName,
    required this.contact,
    required this.postalCode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.razorpayOrderId,
    required this.total,
    required this.serviceCharges,
    required this.shippingCharges,
    required this.subTotal,
    required this.paymentType,
    required this.orderStatus,
    required this.paymentStatus,
    required this.isActive,
    required this.createdOn,
    required this.client,
  });

  factory OrderDetailedModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailedModel(
      id: json["id"],
      fullName: json["full_name"],
      contact: json["contact"],
      postalCode: json["postal_code"],
      address: json["address"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      razorpayOrderId: json["razorpay_order_id"],
      total: (json["total"] ?? 0.0).toDouble(),
      serviceCharges: (json["service_charges"] ?? 0.0).toDouble(),
      shippingCharges:
          (json["shipping_charges"] ?? 0.0).toDouble(), // Parse as double
      subTotal: (json["sub_total"] ?? 0.0).toDouble(), // Parse as double
      paymentType: json["payment_type"],
      orderStatus: json["order_status"],
      paymentStatus: json["payment_status"],
      isActive: json["is_active"],
      createdOn: DateTime.parse(json["created_on"]),
      client: json["client"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "full_name": fullName,
      "contact": contact,
      "postal_code": postalCode,
      "address": address,
      "city": city,
      "state": state,
      "country": country,
      "razorpay_order_id": razorpayOrderId,
      "total": total,
      "service_charges": serviceCharges,
      "shipping_charges": shippingCharges,
      "sub_total": subTotal,
      "payment_type": paymentType,
      "order_status": orderStatus,
      "payment_status": paymentStatus,
      "is_active": isActive,
      "created_on": createdOn.toIso8601String(),
      "client": client,
    };
  }
}
