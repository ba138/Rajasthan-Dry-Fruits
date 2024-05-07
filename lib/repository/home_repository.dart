// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/model/home_model.dart';
import 'package:rjfruits/res/app_url.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:http/http.dart' as http;

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

  void filterProducts(
    String? category,
    double? minRating,
    double? minPrice,
    double? maxPrice,
  ) {
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

          return categoryFilter && priceFilter;
          //  && ratingFilter
        }));
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error in the filterProducts: ${e.toString()}");
    }
  }
}
