import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/repository/product_detail_repositroy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepositoryProvider extends ChangeNotifier {
  ProductDetailRepository _productRepository = ProductDetailRepository();

  ProductDetailRepository get productRepository => _productRepository;

  Future<void> fetchProductDetails(BuildContext context, String id) async {
    await _productRepository.fetchProductDetails(context, id);
    notifyListeners();
  }

  void saveCartProducts(
    String productId,
    String name,
    String image,
    String price,
    int quantity,
  ) {
    _productRepository.saveProductToCache(
      productId: productId,
      name: name,
      image: image,
      price: price,
      quantity: quantity,
    );
    notifyListeners();
  }

  Future<bool> isProductInCart(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cachedProducts = prefs.getStringList('products') ?? [];

    // Check if the product is in the list
    return cachedProducts.any((productJson) {
      Map<String, dynamic> existingProduct =
          json.decode(productJson) as Map<String, dynamic>;
      return existingProduct['productId'] == productId;
    });
  }
}
