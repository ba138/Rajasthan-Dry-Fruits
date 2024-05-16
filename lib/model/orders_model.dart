import 'dart:convert';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(
    json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
  int id;
  String fullName;
  String contact;
  dynamic postalCode;
  String address;
  String city;
  String state;
  String country;
  int total;
  double serviceCharges;
  double shippingCharges; // Change type to double
  int subTotal;
  String paymentType;
  String orderStatus;
  String paymentStatus;
  String? razorpayOrderId;
  String shipmentId;
  dynamic shiprocketShipmentId;
  bool isActive;
  DateTime createdOn;

  OrdersModel({
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
    required this.shippingCharges,
    required this.subTotal,
    required this.paymentType,
    required this.orderStatus,
    required this.paymentStatus,
    required this.razorpayOrderId,
    required this.shipmentId,
    required this.shiprocketShipmentId,
    required this.isActive,
    required this.createdOn,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        id: json["id"],
        fullName: json["full_name"],
        contact: json["contact"],
        postalCode: json["postal_code"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        total:
            (json["total"] as num).toInt(), // Ensure 'total' is parsed as int
        serviceCharges: json["service_charges"]
            .toDouble(), // Parse 'service_charges' as double
        shippingCharges: json["shipping_charges"]
            .toDouble(), // Parse 'shipping_charges' as double
        subTotal: (json["sub_total"] as num)
            .toInt(), // Ensure 'sub_total' is parsed as int
        paymentType: json["payment_type"],
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
        razorpayOrderId: json["razorpay_order_id"],
        shipmentId: json["shipment_id"],
        shiprocketShipmentId: json["shiprocket_shipment_id"],
        isActive: json["is_active"],
        createdOn: DateTime.parse(json["created_on"]),
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
        "shipping_charges": shippingCharges,
        "sub_total": subTotal,
        "payment_type": paymentType,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "razorpay_order_id": razorpayOrderId,
        "shipment_id": shipmentId,
        "shiprocket_shipment_id": shiprocketShipmentId,
        "is_active": isActive,
        "created_on": createdOn.toIso8601String(),
      };
}
