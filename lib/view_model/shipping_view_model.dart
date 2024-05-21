import 'package:flutter/material.dart';

// class ShippingProvider extends ChangeNotifier {
//   int selectedContainerIndex = 0;

//   void updateSelection(int index) {
//     selectedContainerIndex = index;
//     notifyListeners();
//   }
// }
class ShippingProvider with ChangeNotifier {
  int _selectedContainerIndex = 0; // Default to not-selected
  final List<String> _shippingTypes = ["not-selected", "custom", "ship_rocket"];

  int get selectedContainerIndex => _selectedContainerIndex;

  String get selectedShippingType =>
      _shippingTypes[_selectedContainerIndex + 1];

  void updateSelection(int index) {
    _selectedContainerIndex = index;
    notifyListeners();
  }
}
