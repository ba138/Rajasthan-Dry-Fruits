// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/model/home_model.dart';
import 'package:rjfruits/res/app_url.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:http/http.dart' as http;

class HomeRepository extends ChangeNotifier {
  List<Product> newProducts = [];
  List<Category> productCategories = [];
  List<Product> productsFeature = [];
  List<Product> productsTopDiscount = [];
  List<Product> productsTopOrder = [];
  List<Product> productsTopRated = [];
  List<Product> searchResults = [];
  List<Product> categriousProduct = [];
  List<Product> filteredProducts = [];

  Future<void> getHomeProd(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.home),
        headers: {
          'accept': 'application/json',
          'X-CSRFToken':
              'umFU4LBxVgOwgYL6jgTynbGicCd47wKL9otbehTcDRm1k08P7hTmBOzW0wjCwXy1',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        ApiResponse apiResponse = ApiResponse.fromJson(jsonResponse);

        debugPrint("this is the repose of the home api:$jsonResponse");
        productCategories = apiResponse.categories;
        productsFeature = apiResponse.topDiscountedProducts;
        productsTopDiscount = apiResponse.topDiscountedProducts;
        productsTopOrder = apiResponse.newProducts;
        productsTopRated = apiResponse.mostSales;

        notifyListeners();
      } else {
        if (response.statusCode == 404) {
          Utils.flushBarErrorMessage("Products not found", context);
        } else {
          Utils.flushBarErrorMessage("Unexpected error", context);
        }
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }

  String calculateDiscountedPrice(
      double originalPrice, double discountPercentage) {
    double discountedPrice =
        originalPrice - (originalPrice * (discountPercentage / 100));
    return discountedPrice.toStringAsFixed(2);
  }
}
