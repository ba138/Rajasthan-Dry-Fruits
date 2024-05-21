class Shipment {
  final String id;
  final String? provider; // Nullable
  final String? trackingId; // Nullable
  final String? trackingUrl; // Nullable
  final String? trackingNumber; // Nullable
  final String description;
  final String shipmentStatus;
  final DateTime? started; // Nullable
  final DateTime? reached; // Nullable
  final bool shipmentAdded;
  final bool isActive;
  final DateTime createdOn;
  final int order;

  Shipment({
    required this.id,
    this.provider,
    this.trackingId,
    this.trackingUrl,
    this.trackingNumber,
    required this.description,
    required this.shipmentStatus,
    this.started,
    this.reached,
    required this.shipmentAdded,
    required this.isActive,
    required this.createdOn,
    required this.order,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id'],
      provider: json['provider'],
      trackingId: json['tracking_id'],
      trackingUrl: json['tracking_url'],
      trackingNumber: json['tracking_number'],
      description: json['description'],
      shipmentStatus: json['shipment_status'],
      started: json['started'] != null ? DateTime.parse(json['started']) : null,
      reached: json['reached'] != null ? DateTime.parse(json['reached']) : null,
      shipmentAdded: json['shipment_added'],
      isActive: json['is_active'],
      createdOn: DateTime.parse(json['created_on']),
      order: json['order'],
    );
  }
}
