import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/enums.dart';

class HomeUiSwithchRepository extends ChangeNotifier {
  UIType _selectedType = UIType.DefaultSection;

  UIType get selectedType => _selectedType;

  void switchToType(UIType type) {
    _selectedType = type;
    notifyListeners();
  }
}
