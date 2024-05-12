import 'package:flutter/material.dart';
import 'package:rjfruits/repository/cart_repository.dart';

class CartRepositoryProvider extends ChangeNotifier {
  CartRepository _cartRepositoryProvider = CartRepository();

  CartRepository get cartRepositoryProvider => _cartRepositoryProvider;

  Future<void> getCachedProducts() async {
    await _cartRepositoryProvider.getCachedProducts();
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    _cartRepositoryProvider.deleteProduct(
      id,
    );
    notifyListeners();
  }

  void addQuantity(int id, String productId, int quantity) {
    _cartRepositoryProvider.addQuantity(id, productId, quantity);
    notifyListeners();
  }

  void removeQuantity(int id, String productId, int quantity) {
    _cartRepositoryProvider.removeQuantity(id, productId, quantity);
    notifyListeners();
  }

  void calculateTotalPrice() {
    _cartRepositoryProvider.calculateTotalPrice();
  }
}
