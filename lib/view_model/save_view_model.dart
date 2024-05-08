import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rjfruits/repository/save_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveProductRepositoryProvider extends ChangeNotifier {
  SaveRepository _saveRepository = SaveRepository();

  SaveRepository get saveRepository => _saveRepository;
  void saveCartProducts(
    String productId,
    String name,
    String image,
    String price,
    int quantity,
  ) {
    _saveRepository.saveProductToSave(
      productId: productId,
      name: name,
      image: image,
      price: price,
    );
    notifyListeners();
  }

  Future<bool> isProductInCart(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> saveProducts = prefs.getStringList('SaveProducts') ?? [];

    return saveProducts.any((productJson) {
      Map<String, dynamic> existingProduct =
          json.decode(productJson) as Map<String, dynamic>;
      return existingProduct['productId'] == productId;
    });
  }

  Future<void> getCachedProducts() async {
    await _saveRepository.getCachedProducts();
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    await _saveRepository.deleteProduct(
      id,
    );
    notifyListeners();
  }
}
