// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/model/home_model.dart';
import 'package:rjfruits/res/app_url.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:http/http.dart' as http;
import 'package:rjfruits/view/dashBoard/dashboard.dart';

class HomeRepository extends ChangeNotifier {
  List<Category> productCategories = [];
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

        productCategories = apiResponse.categories;
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

  void search(
    String searchTerm,
    List<Product> productsNew,
    List<Product> productsTopDiscount,
    List<Product> productsTopOrder,
  ) {
    searchResults.clear();

    for (var product in productsTopRated) {
      if (product.title.toLowerCase().contains(searchTerm.toLowerCase())) {
        searchResults.add(product);
      }
    }

    for (var product in productsTopDiscount) {
      if (product.title.toLowerCase().contains(searchTerm.toLowerCase())) {
        searchResults.add(product);
      }
    }

    for (var product in productsTopOrder) {
      if (product.title.toLowerCase().contains(searchTerm.toLowerCase())) {
        searchResults.add(product);
      }
    }

    if (searchResults.isNotEmpty) {
      notifyListeners();
    }
  }

  void categoryFilter(String category) {
    categriousProduct.clear();

    for (var product in productsTopDiscount) {
      if (product.category.name.toLowerCase().contains(
            category.toLowerCase(),
          )) {
        categriousProduct.add(product);
      }
    }

    for (var product in productsTopRated) {
      if (product.category.name.toLowerCase().contains(
            category.toLowerCase(),
          )) {
        categriousProduct.add(product);
      }
    }
    for (var product in productsTopOrder) {
      if (product.category.name.toLowerCase().contains(
            category.toLowerCase(),
          )) {
        categriousProduct.add(product);
      }
    }

    if (categriousProduct.isNotEmpty) {
      notifyListeners();
    }
  }

  void filterProducts(String? category, double? minRating, double? minPrice,
      double? maxPrice, int? discountPer) {
    try {
      filteredProducts.clear();

      List<List<Product>> productLists = [
        productsTopRated,
        productsTopDiscount,
        productsTopOrder,
      ];

      for (var productList in productLists) {
        filteredProducts.addAll(productList.where((product) {
          bool categoryFilter = category == null ||
              product.category.name
                  .toLowerCase()
                  .contains(category.toLowerCase());

          // bool ratingFilter =
          //     minRating == null || product.averageReview >= minRating;

          bool priceFilter = (minPrice == null || product.price >= minPrice) &&
              (maxPrice == null || product.price <= maxPrice);
          bool discount =
              discountPer == null || product.discount >= discountPer;

          return categoryFilter && discount && priceFilter;
          //  && ratingFilter
        }));
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error in the filterProducts: ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> getUserData(String token) async {
    final url = Uri.parse('http://103.117.180.187/rest-auth/user/');
    const csrfToken =
        'XITMQkr5pQsag0M81aHHGNPIoaCGlYbfwwqJhkab7uzOG9XZvHpDYqf0sckwPRmU';

    final headers = {
      'accept': 'application/json',
      'X-CSRFToken': csrfToken,
      'authorization': "Token $token",
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final userData = json.decode(response.body) as Map<String, dynamic>;
        notifyListeners();

        return userData;
      } else {
        // Handle HTTP error response
        debugPrint(
            'Failed to get user data. Status code: ${response.statusCode}');
        return {}; // Return empty map in case of failure
      }
    } catch (e) {
      // Handle network error
      debugPrint('Error fetching user data: $e');
      return {}; // Return empty map in case of error
    }
  }

  Future<void> updateUserProfile(String token, String firstName,
      String lastName, BuildContext context) async {
    bool isStoringData = true;

    // Show circular indicator
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

    final url = Uri.parse('http://103.117.180.187/rest-auth/user/');
    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRFToken':
          "XITMQkr5pQsag0M81aHHGNPIoaCGlYbfwwqJhkab7uzOG9XZvHpDYqf0sckwPRmU",
      'authorization': "Token $token",
    };

    final body = jsonEncode({
      'first_name': firstName,
      'last_name': lastName,
    });

    try {
      final response = await http.patch(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        Navigator.of(context).pop();

        isStoringData = false;
        Navigator.push(context,
            MaterialPageRoute(builder: (c) => const DashBoardScreen()));
      } else {
        Navigator.of(context).pop();

        // Toggle the flag to indicate that data storage is complete
        isStoringData = false;
        debugPrint(
            'Failed to update user profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      Navigator.of(context).pop();

      // Toggle the flag to indicate that data storage is complete
      isStoringData = false;
      debugPrint('Error updating user profile: $e');
    }
  }
}
