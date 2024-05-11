// ignore_for_file: use_build_context_synchronously

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
    final String url = 'http://103.117.180.187/api/product/$id/';
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

  Future<void> saveProductToCache(
      {required String productId,
      required String name,
      required String productWeight,
      required String price,
      required int quantity,
      required String token}) async {
    try {
      debugPrint("function has been called");
      final url = Uri.parse('http://103.117.180.187/cart/items/');
      dynamic we;

      if (productWeight == "null") {
        we = null;
      } else {
        we = int.parse(productWeight);
      }
      debugPrint("function has been called2");

      final response = await http.post(
        url,
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRFToken':
              'kktm3pokcNxKVGEeXSiJrkLrmWNgCL4fZmhDdVGZUo5fZI1XLTixFXE5aQTO1cSv',
        },
        body: jsonEncode(<String, dynamic>{
          'product': productId,
          'quantity': quantity,
          'product_weight': we,
        }),
      );
      debugPrint("function has been called3${response.statusCode}");

      if (response.statusCode == 200) {
        debugPrint("function has been called4");

        // Data sent successfully
        Utils.toastMessage("Product has been added to cart");
        notifyListeners();
        debugPrint("function has been called4");

        print('Failed to send cart data to server: ${response.statusCode}');
      } else {
        Utils.toastMessage("Unable to Add to cart");
      }
    } catch (e) {
      debugPrint("function has been called5");

      print('Error sending cart data to server: $e');
    }
  }

  // Future<void> saveProductToCache({
  //   required String productId,
  //   required String name,
  //   required String image,
  //   required String price,
  //   required int quantity,
  // }) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();

  //     Map<String, dynamic> newProduct = {
  //       'productId': productId,
  //       'name': name,
  //       'image': image,
  //       'price': price,
  //       'quantity': quantity,
  //     };

  //     String newProductJson = json.encode(newProduct);

  //     List<String> cachedProducts = prefs.getStringList('products') ?? [];

  //     cachedProducts.add(newProductJson);

  //     prefs.setStringList('products', cachedProducts);
  //     Utils.toastMessage("Product has been added to cart");
  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint("Error saving product to cache: $e");
  //   }
  // }

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
