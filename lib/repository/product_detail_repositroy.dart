// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/model/product_detail_model.dart';

import 'package:http/http.dart' as http;
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/view/HomeView/product_detail_view.dart';

class ProductDetailRepository extends ChangeNotifier {
  Future<void> fetchProductDetails(BuildContext context, String id) async {
    final String url = 'http://103.117.180.187/product/$id/';
    final Map<String, String> headers = {
      'accept': 'application/json',
      'X-CSRFToken':
          'ggUEuomf5SLMCluLyTUTe1TcfnGAZLVoViIVEUEUNtjhGnRumUUHsEMQ3hM8ocJE',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final productDetail = ProductDetail.fromJson(jsonDecode(response.body));
        // Navigate to the next screen and pass the product detail
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(detail: productDetail),
          ),
        );
        notifyListeners();
      } else {
        throw Exception('Failed to load product detail');
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }
}
