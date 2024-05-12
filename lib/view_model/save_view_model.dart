import 'package:flutter/material.dart';
import 'package:rjfruits/repository/save_repository.dart';

class SaveProductRepositoryProvider extends ChangeNotifier {
  final SaveRepository _saveRepository = SaveRepository();

  SaveRepository get saveRepository => _saveRepository;
  void saveCartProducts(String productId, String name, String image,
      String price, int quantity, BuildContext context, String token) {
    _saveRepository.saveProductToSave(
      productId: productId,
      name: name,
      image: image,
      price: price,
      context: context,
      token: token,
    );
    notifyListeners();
  }

  Future<bool> isProductInCart(String productId) async {
    return _saveRepository.isProductInCart(productId);
  }

  Future<void> getCachedProducts(BuildContext context, String token) async {
    await _saveRepository.getCachedProducts(context, token);
    notifyListeners();
  }

  Future<void> deleteProduct(
      String id, BuildContext context, String token) async {
    await _saveRepository.deleteProduct(id, context, token);
    notifyListeners();
  }
}
