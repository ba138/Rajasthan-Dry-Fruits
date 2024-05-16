class OrdersModel {
  String fullName;
  String contact;
  num postalCode; // Change type to num to accept both int and double
  String address;
  String city;
  String state;
  String country;
  num total; // Change type to num to accept both int and double
  String paymentStatus;
  String shipmentType;
  bool isActive;
  DateTime createdOn;
  String shipmentId;
  bool isOnline;
  dynamic shiprocketShipmentId;

  OrdersModel({
    required this.fullName,
    required this.contact,
    required this.postalCode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.total,
    required this.paymentStatus,
    required this.shipmentType,
    required this.isActive,
    required this.createdOn,
    required this.shipmentId,
    required this.isOnline,
    required this.shiprocketShipmentId,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        fullName: json["full_name"],
        contact: json["contact"],
        postalCode: json["postal_code"], // Accepts both int and double
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        total: json["total"], // Accepts both int and double
        paymentStatus: json["payment_status"],
        shipmentType: json["shipment_type"],
        isActive: json["is_active"],
        createdOn: DateTime.parse(json["created_on"]),
        shipmentId: json["shipment_id"],
        isOnline: json["is_online"],
        shiprocketShipmentId: json["shiprocket_shipment_id"],
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
        "payment_status": paymentStatus,
        "shipment_type": shipmentType,
        "is_active": isActive,
        "created_on": createdOn.toIso8601String(),
        "shipment_id": shipmentId,
        "is_online": isOnline,
        "shiprocket_shipment_id": shiprocketShipmentId,
      };
}
