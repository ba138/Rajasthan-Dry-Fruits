// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rjfruits/model/pending_review_model.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';

class RatingRepository extends ChangeNotifier {
  List<Order> orders = [];
  Future<void> postOrderRating(int rating, String prodId, String comment,
      BuildContext context, String token, int client, int order) async {
    try {
      print(("this is the start"));
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
      print(("this is the after indicater"));

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
      print(("this is the after body"));

      final response = await http.post(url, headers: headers, body: body);
      print(("this is the after response"));
      print(("this is the  response:${response.statusCode}"));

      if (response.statusCode == 200) {
        print(("this is the after respose code 200"));

        Utils.flushBarErrorMessage("Rating added successfully.", context);
        Navigator.of(context).pop();
      } else {
        Utils.flushBarErrorMessage("Unexpected error", context);
        Navigator.of(context).pop();
      }
    } catch (e) {
      handleApiError(e, context);
      Navigator.of(context).pop();
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
        List<dynamic> jsonResponse = json.decode(response.body);
        orders = jsonResponse.map((json) => Order.fromJson(json)).toList();
        debugPrint("this is the orderid$jsonResponse");

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
