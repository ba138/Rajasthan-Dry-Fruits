// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';

class RatingRepository extends ChangeNotifier {
  Future<void> postOrderRating(int rating, String prodId, String comment,
      BuildContext context, String token) async {
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
    final url = Uri.parse('http://103.117.180.187/api/order/add/rating/');
    const csrfToken =
        'b9pqcOKunanYdHklY0l2p337ishh9W0fFsuq6Ir8j5ecI1jiw1WLjH3leZH5nQ6P';

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRFToken': csrfToken,
      'authorization': "Token $token",
    };

    final body = jsonEncode(
        {"product": prodId, "rate": rating, "comment": comment, "client": 0});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
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
}
