// ignore_for_file: unnecessary_null_comparison, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartRepository extends ChangeNotifier {
  List<Map<String, dynamic>> cartList = [];
  // List<ProductCategory> cartList2 = [];
  List<ProductCategory> productCategories = [];

  List<Product> cartProducts = [];
  List<CartItem> cartItems = [];
  double totalPrice = 0;
  // Future<void> getCachedProducts() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();

  //     List<String> cachedProducts = prefs.getStringList('products') ?? [];

  //     cartList = cachedProducts.map((productJson) {
  //       return json.decode(productJson) as Map<String, dynamic>;
  //     }).toList();
  //     calculateTotalPrice();

  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint("Error getting cached products: $e");
  //   }
  // }
  Future<void> getCachedProducts() async {
    try {
      var url = Uri.parse('http://103.117.180.187/api/cart/items/');
      var headers = {
        'accept': 'application/json',
        'authorization': "Token 7233ff67ade230cfc7abe911657c331cfaf3fdff",
        'X-CSRFToken':
            '8ztwmgXx792DE5T8vL5kBl7KKbXArImwNBhNwMfcPKA8I7gRjM58PY0oy538Q9aM'
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List<dynamic>;
        productCategories = jsonResponse
            .map(
                (item) => ProductCategory.fromJson(item['product']['category']))
            .toList();
        cartProducts = jsonResponse
            .map((item) => Product.fromJson(item['product']))
            .toList();
        cartItems =
            jsonResponse.map((item) => CartItem.fromJson(item)).toList();
        // cartList = jsonResponse.cast<Map<String, dynamic>>().toList();
        debugPrint("this is the response=$jsonResponse");
        debugPrint("this is cartlist=$cartList");
        calculateTotalPrice();
        notifyListeners();
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      debugPrint("Error getting cart items: $e");
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      cartList.removeWhere((product) => product['productId'] == productId);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> updatedProducts =
          cartList.map((product) => json.encode(product)).toList();
      prefs.setStringList('products', updatedProducts);
      calculateTotalPrice();

      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting product: $e");
    }
  }

  void addQuantity(String productId) {
    Map<String, dynamic>? product = cartList.firstWhere(
      (item) => item['productId'] == productId,
      orElse: () => <String, dynamic>{},
    );

    if (product != null) {
      int currentQuantity = product['quantity'] ?? 1;
      int newQuantity = currentQuantity + 1;
      product['quantity'] = newQuantity;

      double price = double.tryParse(product['price'] ?? '0.0') ?? 0.0;
      double individualTotal = price * newQuantity;
      product['individualTotal'] = individualTotal.toString();
      calculateTotalPrice();

      notifyListeners();
    }
  }

  void removeQuantity(String productId) {
    Map<String, dynamic>? product = cartList.firstWhere(
      (item) => item['productId'] == productId,
      orElse: () => <String, dynamic>{},
    );

    if (product != null && (product['quantity'] ?? 1) > 1) {
      int quantity = (product['quantity'] ?? 1) - 1;
      product['quantity'] = quantity;

      double price = double.tryParse(product['price'] ?? '0.0') ?? 0.0;
      double individualTotal = price * quantity;
      product['individualTotal'] = individualTotal.toString();
      calculateTotalPrice();

      notifyListeners();
    }
  }

  void calculateTotalPrice() {
    double _totalPrice = 0.0;

    for (var product in cartList) {
      double price = product['individualTotal'] != null
          ? double.tryParse(product['individualTotal']) ?? 0.0
          : double.tryParse(product['price']) ?? 0.0;

      _totalPrice += price;
    }

    totalPrice = _totalPrice;

    notifyListeners();
  }
}
