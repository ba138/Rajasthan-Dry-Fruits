// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/model/product_detail_model.dart';

import 'package:http/http.dart' as http;
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view/HomeView/product_detail_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailRepository extends ChangeNotifier {
  Future<void> fetchProductDetails(BuildContext context, String id) async {
    debugPrint("this is the detail response product Id:${id}");

    final String url = 'http://103.117.180.187/api/product/$id/';
    final Map<String, String> headers = {
      'accept': 'application/json',
      'X-CSRFToken':
          'ggUEuomf5SLMCluLyTUTe1TcfnGAZLVoViIVEUEUNtjhGnRumUUHsEMQ3hM8ocJE',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      debugPrint(
          "this is the detail response product code:${response.statusCode}");

      if (response.statusCode == 200) {
        final productDetail = ProductDetail.fromJson(jsonDecode(response.body));
        // Navigate to the next screen and pass the product detail
        debugPrint("this is the detail response:${response.body}");
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

  Future<void> saveProductToCache({
    required String productId,
    required String name,
    required String productWeight,
    required String price,
    required int quantity,
    required String token,
    required BuildContext context,
  }) async {
    try {
      debugPrint("function has been called");
      final url = Uri.parse('http://103.117.180.187/api/cart/items/');
      dynamic we;

      if (productWeight == "null") {
        we = null;
      } else {
        we = int.parse(productWeight);
      }
      debugPrint("function has been called2");
      debugPrint("this is the token of the user= $token");
      final response = await http.post(
        url,
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRFToken':
              'kktm3pokcNxKVGEeXSiJrkLrmWNgCL4fZmhDdVGZUo5fZI1XLTixFXE5aQTO1cSv',
          'authorization': "Token $token"
        },
        body: jsonEncode(<String, dynamic>{
          'product': productId,
          'quantity': quantity,
          'product_weight': we,
        }),
      );

      if (response.statusCode == 201) {
        // Data sent successfully
        Utils.toastMessage("Product has been added to cart");
        notifyListeners();
      } else {
        Utils.toastMessage("Unable to Add to cart");
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }

  Future<bool> isProductInCart(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cachedProducts = prefs.getStringList('products') ?? [];

    for (String productJson in cachedProducts) {
      Map<String, dynamic> productMap = json.decode(productJson);
      if (productMap['productId'] == productId) {
        return true;
      }
    }

    return false;
  }
}
