class ShipmentTrackResponse {
  int trackStatus;
  int shipmentStatus;
  List<ShipmentTrack> shipmentTrack;
  List<dynamic>?
      shipmentTrackActivities; // Assuming activities could be a list of dynamic items
  String trackUrl;
  String qcResponse;
  bool isReturn;
  String error;

  ShipmentTrackResponse({
    required this.trackStatus,
    required this.shipmentStatus,
    required this.shipmentTrack,
    this.shipmentTrackActivities,
    required this.trackUrl,
    required this.qcResponse,
    required this.isReturn,
    required this.error,
  });

  factory ShipmentTrackResponse.fromJson(Map<String, dynamic> json) {
    return ShipmentTrackResponse(
      trackStatus: json['track_status'],
      shipmentStatus: json['shipment_status'],
      shipmentTrack: List<ShipmentTrack>.from(
        json['shipment_track'].map((item) => ShipmentTrack.fromJson(item)),
      ),
      shipmentTrackActivities: json['shipment_track_activities'],
      trackUrl: json['track_url'],
      qcResponse: json['qc_response'],
      isReturn: json['is_return'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'track_status': trackStatus,
      'shipment_status': shipmentStatus,
      'shipment_track':
          List<dynamic>.from(shipmentTrack.map((item) => item.toJson())),
      'shipment_track_activities': shipmentTrackActivities,
      'track_url': trackUrl,
      'qc_response': qcResponse,
      'is_return': isReturn,
      'error': error,
    };
  }
}

class ShipmentTrack {
  int id;
  String awbCode;
  int? courierCompanyId;
  int shipmentId;
  int orderId;
  String pickupDate;
  String deliveredDate;
  String weight;
  int packages;
  String currentStatus;
  String deliveredTo;
  String destination;
  String consigneeName;
  String origin;
  dynamic courierAgentDetails; // Can be a Map<String, dynamic> or null
  String courierName;
  String? edd;
  String pod;
  String podStatus;
  String rtoDeliveredDate;

  ShipmentTrack({
    required this.id,
    required this.awbCode,
    this.courierCompanyId,
    required this.shipmentId,
    required this.orderId,
    required this.pickupDate,
    required this.deliveredDate,
    required this.weight,
    required this.packages,
    required this.currentStatus,
    required this.deliveredTo,
    required this.destination,
    required this.consigneeName,
    required this.origin,
    this.courierAgentDetails,
    required this.courierName,
    this.edd,
    required this.pod,
    required this.podStatus,
    required this.rtoDeliveredDate,
  });

  factory ShipmentTrack.fromJson(Map<String, dynamic> json) {
    return ShipmentTrack(
      id: json['id'],
      awbCode: json['awb_code'],
      courierCompanyId: json['courier_company_id'],
      shipmentId: json['shipment_id'],
      orderId: json['order_id'],
      pickupDate: json['pickup_date'],
      deliveredDate: json['delivered_date'],
      weight: json['weight'],
      packages: json['packages'],
      currentStatus: json['current_status'],
      deliveredTo: json['delivered_to'],
      destination: json['destination'],
      consigneeName: json['consignee_name'],
      origin: json['origin'],
      courierAgentDetails: json['courier_agent_details'],
      courierName: json['courier_name'],
      edd: json['edd'],
      pod: json['pod'],
      podStatus: json['pod_status'],
      rtoDeliveredDate: json['rto_delivered_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'awb_code': awbCode,
      'courier_company_id': courierCompanyId,
      'shipment_id': shipmentId,
      'order_id': orderId,
      'pickup_date': pickupDate,
      'delivered_date': deliveredDate,
      'weight': weight,
      'packages': packages,
      'current_status': currentStatus,
      'delivered_to': deliveredTo,
      'destination': destination,
      'consignee_name': consigneeName,
      'origin': origin,
      'courier_agent_details': courierAgentDetails,
      'courier_name': courierName,
      'edd': edd,
      'pod': pod,
      'pod_status': podStatus,
      'rto_delivered_date': rtoDeliveredDate,
    };
  }
}
