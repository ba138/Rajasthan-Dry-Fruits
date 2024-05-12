// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:rjfruits/repository/shop_repository.dart';

class ShopRepositoryProvider extends ChangeNotifier {
  ShopRepository _shopRepository = ShopRepository();

  ShopRepository get shopRepository => _shopRepository;

  Future<void> getShopProd(BuildContext context) async {
    await _shopRepository.getShopProd(context);
    notifyListeners();
  }

  void search(
    String searchTerm,
  ) {
    _shopRepository.search(
      searchTerm,
    );
    notifyListeners();
  }
}
