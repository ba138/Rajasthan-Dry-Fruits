import 'package:flutter/material.dart';

class ShippingProvider with ChangeNotifier {
  int _selectedContainerIndex = 0;
  final String _shipRocket = "ship_rocket";
  final String _customShipping = "custom";

  int get selectedContainerIndex => _selectedContainerIndex;

  String get selectedShippingType {
    if (_selectedContainerIndex == 0) {
      return _shipRocket;
    } else {
      return _customShipping;
    }
  }

  void updateSelection(int index) {
    _selectedContainerIndex = index;
    notifyListeners();
  }
}
