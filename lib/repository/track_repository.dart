// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:order_tracker/order_tracker.dart';
import 'package:rjfruits/model/order_detailed_model.dart';
import 'package:rjfruits/model/ship_rocket_model.dart';
import 'package:rjfruits/model/custom_shipment.dart';

import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view/orders/widgets/track_order.dart';

class TrackOrderRepository extends ChangeNotifier {
  List<ShipmentTrackResponse> shipList = [];
  List<TextDto> outOfDeliveryList = [];
  List<TextDto> shippedList = [];
  List<TextDto> deliveredList = [];
  String trackingId = "";
  String deliveryCompany = "";
  String destination = "";
  String shipmentCharges = "";
  Future<void> fetchOrderDetails(BuildContext context, String orderId,
      String token, String shopRocketId, String customId) async {
    bool isStoringData = true;
    try {
      // Show circular indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        },
      );

      final response = await http.get(
        Uri.parse("http://103.117.180.187/api/order/$orderId/"),
        headers: {
          'accept': 'application/json',
          'X-CSRFToken':
              'XITMQkr5pQsag0M81aHHGNPIoaCGlYbfwwqJhkab7uzOG9XZvHpDYqf0sckwPRmU',
          'authorization': "Token $token",
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        debugPrint("this is the response code: ${response.statusCode}");
        debugPrint("this is the response body: $jsonResponse");

        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          final orderDetailMap = jsonResponse[0] as Map<String, dynamic>;

          final orderDetail = OrderDetailedModel.fromJson(orderDetailMap);
          debugPrint("this is the response code: ${response.statusCode}");
          debugPrint("this is the response body: $jsonResponse");
          Navigator.of(context).pop();

          // Toggle the flag to indicate that data storage is complete
          isStoringData = false;
          // Navigate to the next screen with order details
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TrackOrder(
                      orderDetailModel: orderDetail,
                      shipRocketId: shopRocketId,
                      customShipId: customId,
                    )),
          );
        } else {
          debugPrint("Failed to parse order details from response");
          Navigator.of(context).pop();

          // Toggle the flag to indicate that data storage is complete
          isStoringData = false;
          Utils.flushBarErrorMessage(
              "Failed to parse order details from response", context);
        }
      } else {
        Navigator.of(context).pop();

        // Toggle the flag to indicate that data storage is complete
        isStoringData = false;
        debugPrint(
            "Failed to fetch order details. Status code: ${response.statusCode}");
        // Show error message based on status code
        if (response.statusCode == 404) {
          Navigator.of(context).pop();

          // Toggle the flag to indicate that data storage is complete
          isStoringData = false;
          Utils.flushBarErrorMessage("Order not found", context);
        } else {
          Navigator.of(context).pop();

          // Toggle the flag to indicate that data storage is complete
          isStoringData = false;
          Utils.flushBarErrorMessage("Unexpected error", context);
        }
      }
    } catch (e) {
      Navigator.of(context).pop();

      // Toggle the flag to indicate that data storage is complete
      isStoringData = false;
      handleApiError(e, context);
    }
  }

  Future<void> fetchShipmentDetail(String id, String token) async {
    // Define the URL
    final String url =
        'http://103.117.180.187/api/shiprocket/shipment-detail/$id/';

    // Define the headers
    final Map<String, String> headers = {
      'accept': 'application/json',
      'X-CSRFToken':
          'haUKPWH6GvjdUzMFi9qJlwDzeK9gRDmyLtZKJQoKCqarpTLCQa1sfaDNahz45xs8',
      'authorization': "Token $token",
    };

    try {
      // Send GET request
      final response = await http.get(Uri.parse(url), headers: headers);

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response JSON
        final ShipmentTrackResponse shipmentDetail =
            ShipmentTrackResponse.fromJson(jsonDecode(response.body));
        debugPrint("this is delivery response:${response.body}");
        outOfDeliveryList.clear();
        outOfDeliveryList.add(TextDto("Your order has been Picked",
            shipmentDetail.shipmentTrack[0].pickupDate));
        shippedList.clear();

        shippedList.add(
          TextDto(
            "Your order has been ",
            shipmentDetail.shipmentTrack[0].currentStatus,
          ),
        );
        deliveredList.clear();
        deliveredList.add(
          TextDto(
            "Your order has been delivered",
            shipmentDetail.shipmentTrack[0].deliveredDate,
          ),
        );
        trackingId = shipmentDetail.shipmentTrack[0].shipmentId.toString();
        destination = shipmentDetail.shipmentTrack[0].destination;
        deliveryCompany = shipmentDetail.shipmentTrack[0].courierName;

// TextDto("Your order is out for delivery", ""),
        notifyListeners();
      } else {
        // If the request was not successful, print the error status code
        debugPrint('Failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      // If an error occurs during the request, print the error
      debugPrint('Error: $error');
    }
  }

  Future<void> fetchCustomDetailData(String id, String token) async {
    // Define the URL
    final String url = 'http://103.117.180.187/api/shipment-detail/$id/';

    // Define the headers
    final Map<String, String> headers = {
      'accept': 'application/json',
      'X-CSRFToken':
          'haUKPWH6GvjdUzMFi9qJlwDzeK9gRDmyLtZKJQoKCqarpTLCQa1sfaDNahz45xs8',
      'authorization': "Token $token",
    };

    try {
      // Send GET request
      final response = await http.get(Uri.parse(url), headers: headers);

      // Log headers and URL
      debugPrint("Request URL: $url");
      debugPrint("Request headers: $headers");
      debugPrint("Response status code: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response JSON
        final shipmentDetail = Shipment.fromJson(jsonDecode(response.body));
        debugPrint("Parsed shipment detail: ${shipmentDetail}");

        outOfDeliveryList.clear();
        outOfDeliveryList.add(TextDto(
            "Your order has been Picked", shipmentDetail.started?.toString()));
        shippedList.clear();
        shippedList.add(
            TextDto("Your order has been ", shipmentDetail.shipmentStatus));
        deliveredList.clear();
        deliveredList.add(TextDto("Your order has been delivered",
            shipmentDetail.reached?.toString()));

        trackingId = shipmentDetail.id;
        destination = shipmentDetail.provider ??
            ""; // Assuming 'provider' means 'destination'
        deliveryCompany = shipmentDetail.provider ??
            ""; // Assuming 'trackingUrl' is used here for 'deliveryCompany'
        // Call notifyListeners() if using ChangeNotifier to update UI
        notifyListeners();
      } else {
        // If the request was not successful, print the error status code
        debugPrint('Failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      // If an error occurs during the request, print the error
      debugPrint('Error: $error');
    }
  }
}
