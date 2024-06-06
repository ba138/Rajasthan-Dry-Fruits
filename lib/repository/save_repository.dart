// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rjfruits/res/const/response_handler.dart';
// import 'package:rjfruits/utils/routes/utils.dart';
import 'package:http/http.dart' as http;
import 'package:rjfruits/utils/routes/utils.dart';

class SaveRepository extends ChangeNotifier {
  List<Map<String, dynamic>> saveList = [];
  bool? isLike;
  Future<void> saveProductToSave({
    required String productId,
    required String name,
    required String image,
    required String price,
    required BuildContext context,
    required String token,
  }) async {
    final url = Uri.parse('http://103.117.180.187/api/wish-list/');
    const csrfToken =
        'NGxAa947Y1IH8kL6Y0H28OV42wsR98ZvsIlRkFmMGCgccm8PM1HQmrOIQqypyzNL';

    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRFToken': csrfToken,
      'authorization': "Token $token",
    };

    final body = jsonEncode({
      'product': productId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        isLike = true;
        notifyListeners();

        Utils.toastMessage("Product added to wishlist successfully");
        print('thi is the succes of wishlist:${response.body}');
      } else {
        Utils.toastMessage("Unable to add product to wishlist");
        print('thi is the faild of wishlist:${response.body}');
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }

  Future<void> getCachedProducts(BuildContext context, String token) async {
    final url = Uri.parse('http://103.117.180.187/api/wish-list/');
    const csrfToken =
        'NGxAa947Y1IH8kL6Y0H28OV42wsR98ZvsIlRkFmMGCgccm8PM1HQmrOIQqypyzNL';

    final headers = {
      'accept': 'application/json',
      'X-CSRFToken': csrfToken,
      'authorization': "Token $token",
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<Map<String, dynamic>> saveList =
            (json.decode(response.body) as List<dynamic>)
                .map((item) => item as Map<String, dynamic>)
                .toList();
        // debugPrint("this is the savelist data=$saveList");
        // Assuming you have a variable called saveList defined in your class
        this.saveList = saveList;

        // Notify listeners if necessary
        notifyListeners();
      } else {
        // Utils.flushBarErrorMessage("Unable to get wishlist products", context);
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }

  Future<void> deleteProduct(
      String saveProductId, BuildContext context, String token) async {
    final url = Uri.parse(
        'http://103.117.180.187/api/wish-list/$saveProductId/delete/');
    const csrfToken =
        'NGxAa947Y1IH8kL6Y0H28OV42wsR98ZvsIlRkFmMGCgccm8PM1HQmrOIQqypyzNL';

    final headers = {
      'accept': 'application/json',
      'X-CSRFToken': csrfToken,
      'authorization': "Token $token",
    };

    try {
      final response = await http.delete(url, headers: headers);
      if (response.statusCode == 204) {
        // Utils.toastMessage('Save product deleted successfully');
        // isLike = false;
        // notifyListeners();
      } else {
        // Utils.toastMessage('Error deleting save product');
      }
    } catch (e) {
      handleApiError(e, context);
    }
  }

  Future<bool> isProductInCart(String productId) async {
    // Assuming cartList is a global variable or accessible within this scope
    for (var product in saveList) {
      if (product['product']['id'] == productId) {
        isLike = true;
        notifyListeners();

        debugPrint("this is product in the save list:$saveList");
        return true;
      }
    }
    return false;
  }
}
