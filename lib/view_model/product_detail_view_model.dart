import 'package:flutter/material.dart';
import 'package:rjfruits/repository/product_detail_repositroy.dart';

class ProductRepositoryProvider extends ChangeNotifier {
  ProductDetailRepository _productRepository = ProductDetailRepository();

  ProductDetailRepository get productRepository => _productRepository;

  Future<void> fetchProductDetails(BuildContext context, String id) async {
    await _productRepository.fetchProductDetails(context, id);
    notifyListeners();
  }
}
