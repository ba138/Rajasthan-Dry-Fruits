import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/search_enums.dart';

class SearchUiSwithchRepository extends ChangeNotifier {
  SearchUIType _selectedType = SearchUIType.DeaultSearchSection;

  SearchUIType get selectedType => _selectedType;

  void switchToType(SearchUIType type) {
    _selectedType = type;
    notifyListeners();
  }

  void switchToDefaultSection() {
    switchToType(SearchUIType.DeaultSearchSection);
    notifyListeners();
  }
}
