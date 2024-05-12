import 'package:flutter/material.dart';
import 'package:rjfruits/repository/cart_repository.dart';

class CartRepositoryProvider extends ChangeNotifier {
  final CartRepository _cartRepositoryProvider = CartRepository();

  CartRepository get cartRepositoryProvider => _cartRepositoryProvider;

  Future<void> getCachedProducts(BuildContext context, String token) async {
    await _cartRepositoryProvider.getCachedProducts(context, token);
    notifyListeners();
  }

  Future<void> deleteProduct(int id, BuildContext context, String token) async {
    _cartRepositoryProvider.deleteProduct(id, context, token);
    notifyListeners();
  }

  void addQuantity(int id, String productId, int quantity, BuildContext context,
      String token) {
    _cartRepositoryProvider.addQuantity(
        id, productId, quantity, context, token);
    notifyListeners();
  }

  void removeQuantity(int id, String productId, int quantity,
      BuildContext context, String token) {
    _cartRepositoryProvider.removeQuantity(
        id, productId, quantity, context, token);
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
