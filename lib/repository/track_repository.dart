// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rjfruits/model/order_detailed_model.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view/orders/widgets/track_order.dart';

class TrackOrderRepository extends ChangeNotifier {
  Future<void> fetchOrderDetails(
      BuildContext context, String orderId, String token) async {
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
        Uri.parse("http://103.117.180.187/api/order/3/"),
        headers: {
          'accept': 'application/json',
          'X-CSRFToken':
              'XITMQkr5pQsag0M81aHHGNPIoaCGlYbfwwqJhkab7uzOG9XZvHpDYqf0sckwPRmU',
          'authorization': "Token d9455fc2a211e2798420ffa341807ea709d8cd33",
        },
      );

      Navigator.of(context).pop(); // Dismiss the progress indicator

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        debugPrint("this is the response code: ${response.statusCode}");
        debugPrint("this is the response body: $jsonResponse");

        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          final orderDetailMap = jsonResponse[0] as Map<String, dynamic>;

          final orderDetail = OrderDetailedModel.fromJson(orderDetailMap);

          // Navigate to the next screen with order details
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TrackOrder(orderDetailModel: orderDetail)),
          );
        } else {
          debugPrint("Failed to parse order details from response");
          Utils.flushBarErrorMessage(
              "Failed to parse order details from response", context);
        }
      } else {
        debugPrint(
            "Failed to fetch order details. Status code: ${response.statusCode}");
        // Show error message based on status code
        if (response.statusCode == 404) {
          Utils.flushBarErrorMessage("Order not found", context);
        } else {
          Utils.flushBarErrorMessage("Unexpected error", context);
        }
      }
    } catch (e) {
      debugPrint("Error fetching order details: $e");
      handleApiError(e, context);
    }
  }
}
