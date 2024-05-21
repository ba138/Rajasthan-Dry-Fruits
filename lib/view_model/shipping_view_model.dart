import 'package:flutter/material.dart';

class ShippingProvider with ChangeNotifier {
  int _selectedContainerIndex = 0;
  final List<String> _shippingTypes = ["not-selected", "custom", "ship_rocket"];

  int get selectedContainerIndex => _selectedContainerIndex;

  String get selectedShippingType => _shippingTypes[_selectedContainerIndex];

  void updateSelection(int index) {
    _selectedContainerIndex = index;

    notifyListeners();
  }
}
