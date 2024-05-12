import 'package:flutter/material.dart';
import 'package:rjfruits/repository/cart_repository.dart';

class CartRepositoryProvider extends ChangeNotifier {
  final CartRepository _cartRepositoryProvider = CartRepository();

  CartRepository get cartRepositoryProvider => _cartRepositoryProvider;

  Future<void> getCachedProducts(BuildContext context) async {
    await _cartRepositoryProvider.getCachedProducts(context);
    notifyListeners();
  }

  Future<void> deleteProduct(int id, BuildContext context) async {
    _cartRepositoryProvider.deleteProduct(id, context);
    notifyListeners();
  }

  void addQuantity(
      int id, String productId, int quantity, BuildContext context) {
    _cartRepositoryProvider.addQuantity(id, productId, quantity, context);
    notifyListeners();
  }

  void removeQuantity(
      int id, String productId, int quantity, BuildContext context) {
    _cartRepositoryProvider.removeQuantity(id, productId, quantity, context);
    notifyListeners();
  }

  String calculateTotalPrice() {
    String totalPrice = _cartRepositoryProvider.calculateTotalPrice();

    // Notify listeners
    notifyListeners();

    // Return the total price
    return totalPrice;
  }
}
