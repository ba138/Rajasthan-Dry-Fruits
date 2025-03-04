// ignore_for_file: unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rjfruits/model/cart_model.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:http/http.dart' as http;

class CartRepository extends ChangeNotifier {
  List<ProductCategory> productCategories = [];
  List<Product> cartProducts = [];
  List<CartItem> cartItems = [];
  double totalPrice = 0;
  double discountPrice = 0;
  double shipRocketCharges = 0;
  double customShippingCharges = 0;

  double subTotal = 0;

  Future<void> getCachedProducts(BuildContext context, String token) async {
    try {
      var url = Uri.parse('http://103.117.180.187/api/cart/items/');
      var headers = {
        'accept': 'application/json',
        'authorization': "Token $token",
        'X-CSRFToken':
            '8ztwmgXx792DE5T8vL5kBl7KKbXArImwNBhNwMfcPKA8I7gRjM58PY0oy538Q9aM'
      };

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var cartItemsJson = jsonResponse['cart_items'] as List<dynamic>;

        productCategories = cartItemsJson
            .map(
                (item) => ProductCategory.fromJson(item['product']['category']))
            .toList();
        cartProducts = cartItemsJson
            .map((item) => Product.fromJson(item['product']))
            .toList();
        cartItems =
            cartItemsJson.map((item) => CartItem.fromJson(item)).toList();

        totalPrice = jsonResponse['total_price'].toDouble();
        discountPrice = jsonResponse['discount_price'].toDouble();
        shipRocketCharges =
            jsonResponse['shiprocket_shipping_charges'].toDouble();
        subTotal = jsonResponse['sub_total'].toDouble();
        customShippingCharges =
            jsonResponse['custom_shipping_charges'].toDouble();

        notifyListeners();
      } else {
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      Utils.flushBarErrorMessage("$e", context);
      debugPrint("this is the error $e");
    }
  }

  Future<void> deleteProduct(
      int productId, BuildContext context, String token) async {
    try {
      final url = 'http://103.117.180.187/api/cart/$productId/';
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'X-CSRFToken':
              'eG9gGWbYQxkNMKGGvw4XSUDJ7PN27N8mTIXxQstDy8SiQM3pjx4L6xwnVJTAweWC',
          'authorization': "Token $token",
        },
      );

      if (response.statusCode == 204) {
        cartItems.removeWhere((item) => item.id == productId);

        notifyListeners();
        // Successful deletion
        Utils.toastMessage("Product has been Delete");
      } else {
        // Handle other status codes
      }
    } catch (e) {
      Utils.flushBarErrorMessage("Problem in removeing product", context);
    }
  }

  Future<void> addQuantity(int itemId, String product, int quantity,
      BuildContext context, String token) async {
    final updatedQuantity = quantity + 1;
    final url = 'http://103.117.180.187/api/cart/$itemId/';

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRFToken':
              "2yZ0t55418A2ce1TyGaKD5RmNUsFAwe6HANhDBnJJJ8xggoCmHayRIK0BOydZX2m",
          'authorization': "Token $token",
        },
        body: jsonEncode({
          'product': product,
          'quantity': updatedQuantity,
        }),
      );

      if (response.statusCode == 200) {
        // Successful update
      } else {
        // Handle other status codes
      }
    } catch (e) {
      Utils.flushBarErrorMessage("problem in updating product", context);
    }
  }

  Future<void> removeQuantity(int itemId, String product, int quantity,
      BuildContext context, String token) async {
    final updatedQuantity = quantity - 1;
    final url = 'http://103.117.180.187/api/cart/$itemId/';

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRFToken':
              "2yZ0t55418A2ce1TyGaKD5RmNUsFAwe6HANhDBnJJJ8xggoCmHayRIK0BOydZX2m",
          'authorization': "Token $token",
        },
        body: jsonEncode({
          'product': product,
          'quantity': updatedQuantity,
        }),
      );

      if (response.statusCode == 200) {
        // Successful update
      } else {
        // Handle other status codes
      }
    } catch (e) {
      Utils.flushBarErrorMessage("Check your internet connection", context);
    }
  }

  String calculateTotalPrice() {
    double totalPrice = 0.0;

    for (var cartItem in cartItems) {
      double productPrice = double.tryParse(cartItem.product.price) ?? 0.0;
      totalPrice += (productPrice * cartItem.quantity);
    }

    this.totalPrice = totalPrice;
    notifyListeners();

    return totalPrice.toString();
  }
}
