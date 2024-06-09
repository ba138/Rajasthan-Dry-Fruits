// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rjfruits/model/pending_review_model.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/utils/routes/utils.dart';

class RatingRepository extends ChangeNotifier {
  List<Order> orders = [];

  Future<void> postOrderRating(int rating, String prodId, String comment,
      BuildContext context, String token, int client, int order) async {
    try {
      final url = Uri.parse('http://103.117.180.187/api/order/add/rating/');
      const csrfToken =
          'b9pqcOKunanYdHklY0l2p337ishh9W0fFsuq6Ir8j5ecI1jiw1WLjH3leZH5nQ6P';

      final headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRFToken': csrfToken,
        'authorization': "Token $token",
      };

      final body = jsonEncode({
        "order": order,
        "product": prodId,
        "rate": rating,
        "comment": comment,
        "client": client
      });

      final response = await http.post(url, headers: headers, body: body);
      debugPrint(
          "this is the response code and body :${response.body}:${response.statusCode}");
      if (response.statusCode == 201) {
        Utils.flushBarErrorMessage("Rating added successfully.", context);
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.dashboard, (route) => false);
      } else if (response.statusCode == 400) {
        Utils.flushBarErrorMessage("Product already rated", context);
      } else {
        Utils.flushBarErrorMessage("Unexcepeted error occure", context);
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }

  Future<void> getPendingReviews(BuildContext context, String token) async {
    const url = 'http://103.117.180.187/api/pending/reviews/';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        "Content-Type": 'application/json',
        'X-CSRFToken':
            '8DreMzsm686oLm67ak3JGC6M2p4WvHu8CWweGt9023XCgG54IlEsAg60YWuKJBAI',
        'authorization': 'Token $token',
      },
    );

    try {
      if (response.statusCode == 200) {
        debugPrint("this is the rating:${response.body}");
        List<dynamic> jsonResponse = json.decode(response.body);
        orders = jsonResponse.map((json) => Order.fromJson(json)).toList();
        debugPrint("this is the orderid$orders");

        // Handle your orders here
        // e.g., set state, notify listeners, etc.

        // For demonstration, printing orders
      } else {
        debugPrint("this is response code after 200: ${response.statusCode}");
        if (response.statusCode == 404) {
          Utils.flushBarErrorMessage("Products not found", context);
        } else {
          debugPrint("this is response code after 200: ${response.statusCode}");

          Utils.flushBarErrorMessage("Unexpected error", context);
        }
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }
}
