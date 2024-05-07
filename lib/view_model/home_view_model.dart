import 'package:flutter/material.dart';
import 'package:rjfruits/model/home_model.dart';
import 'package:rjfruits/repository/home_repository.dart';

class HomeRepositoryProvider extends ChangeNotifier {
  HomeRepository _homeRepository = HomeRepository();

  HomeRepository get homeRepository => _homeRepository;

  Future<void> getHomeProd(BuildContext context) async {
    await _homeRepository.getHomeProd(context);
    notifyListeners();
  }

  String calculateDiscountedPrice(double originalPrice, double discount) {
    String discountedPrice =
        _homeRepository.calculateDiscountedPrice(originalPrice, discount);
    notifyListeners();
    return discountedPrice;
  }

  void search(
    String searchTerm,
    List<Product> produtTopRated,
    List<Product> productsFeature,
    List<Product> productsTopDiscount,
  ) {
    _homeRepository.search(
      searchTerm,
      produtTopRated,
      productsTopDiscount,
      productsFeature,
    );
    notifyListeners();
  }
}
