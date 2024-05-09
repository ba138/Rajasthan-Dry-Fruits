// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/model/shop_model.dart';
import 'package:http/http.dart' as http;
import 'package:rjfruits/res/app_url.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';

class ShopRepository extends ChangeNotifier {
  List<Shop> shopProducts = [];
  Future<void> getShopProd(BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(AppUrl.shop),
        headers: {
          'accept': 'application/json',
          'X-CSRFToken':
              'umFU4LBxVgOwgYL6jgTynbGicCd47wKL9otbehTcDRm1k08P7hTmBOzW0wjCwXy1',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final List<Shop> shops =
            jsonResponse.map((e) => Shop.fromJson(e)).toList();

        shopProducts.clear(); // Clear the existing list
        shopProducts.addAll(shops); // Add the new items

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
}
