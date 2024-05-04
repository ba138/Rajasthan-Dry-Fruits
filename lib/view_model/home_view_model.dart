import 'package:flutter/material.dart';
import 'package:rjfruits/repository/home_repository.dart';

class HomeRepositoryProvider extends ChangeNotifier {
  HomeRepository _homeRepository = HomeRepository();

  HomeRepository get homeRepository => _homeRepository;

  Future<void> getHomeProd(BuildContext context) async {
    await _homeRepository.getHomeProd(context);
    notifyListeners();
  }
}
