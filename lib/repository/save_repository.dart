// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SaveRepository extends ChangeNotifier {
  List<Map<String, dynamic>> saveList = [];
  Future<void> saveProductToSave({
    required String productId,
    required String name,
    required String image,
    required String price,
    required BuildContext context,
  }) async {
    final url = Uri.parse('http://103.117.180.187/api/wish-list/');
    const csrfToken =
        'NGxAa947Y1IH8kL6Y0H28OV42wsR98ZvsIlRkFmMGCgccm8PM1HQmrOIQqypyzNL';

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRFToken': csrfToken,
      'authorization': "Token 7233ff67ade230cfc7abe911657c331cfaf3fdff",
    };

    final body = jsonEncode({
      'product': productId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        Utils.toastMessage("Product added to wishlist successfully");
        // print('');
      } else {
        Utils.toastMessage("Unable to add product to wishlist");
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }

  Future<void> getCachedProducts(BuildContext context) async {
    final url = Uri.parse('http://103.117.180.187/api/wish-list/');
    const csrfToken =
        'NGxAa947Y1IH8kL6Y0H28OV42wsR98ZvsIlRkFmMGCgccm8PM1HQmrOIQqypyzNL';

    final headers = {
      'accept': 'application/json',
      'X-CSRFToken': csrfToken,
      'authorization': "Token 7233ff67ade230cfc7abe911657c331cfaf3fdff",
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> saveList =
            (json.decode(response.body) as List<dynamic>)
                .map((item) => item as Map<String, dynamic>)
                .toList();
        debugPrint("this is the savelist data=$saveList");
        // Assuming you have a variable called saveList defined in your class
        this.saveList = saveList;

        // Notify listeners if necessary
        notifyListeners();
      } else {
        Utils.flushBarErrorMessage("Unable to get wishlist products", context);
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }

  Future<void> deleteProduct(String saveProductId, BuildContext context) async {
    final url = Uri.parse(
        'http://103.117.180.187/api/wish-list/$saveProductId/delete/');
    const csrfToken =
        'NGxAa947Y1IH8kL6Y0H28OV42wsR98ZvsIlRkFmMGCgccm8PM1HQmrOIQqypyzNL';

    final headers = {
      'accept': 'application/json',
      'X-CSRFToken': csrfToken,
      'authorization': "Token 7233ff67ade230cfc7abe911657c331cfaf3fdff",
    };

    try {
      final response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        Utils.toastMessage('Save product deleted successfully');
      } else {
        Utils.toastMessage('Error deleting save product');
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }

  Future<bool> isProductInCart(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> saveProducts = prefs.getStringList('SaveProducts') ?? [];

    for (String productJson in saveProducts) {
      Map<String, dynamic> productMap = json.decode(productJson);
      if (productMap['productId'] == productId) {
        return true;
      }
    }
    return false;
  }
}
