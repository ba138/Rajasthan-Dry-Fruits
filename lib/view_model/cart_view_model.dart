import 'package:flutter/material.dart';
import 'package:rjfruits/repository/cart_repository.dart';

class CartRepositoryProvider extends ChangeNotifier {
  CartRepository _cartRepositoryProvider = CartRepository();

  CartRepository get cartRepositoryProvider => _cartRepositoryProvider;

  Future<void> getCachedProducts() async {
    await _cartRepositoryProvider.getCachedProducts();
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    await _cartRepositoryProvider.deleteProduct(
      id,
    );
    notifyListeners();
  }

  void addQuantity(String id) {
    _cartRepositoryProvider.addQuantity(id);
    notifyListeners();
  }

  void removeQuantity(String id) {
    _cartRepositoryProvider.removeQuantity(id);
    notifyListeners();
  }

  void calculateTotalPrice() {
    _cartRepositoryProvider.calculateTotalPrice();
  }
}
