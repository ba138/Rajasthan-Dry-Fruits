import 'package:flutter/material.dart';
import 'package:rjfruits/repository/track_repository.dart';

class TrackOrderRepositoryProvider extends ChangeNotifier {
  final TrackOrderRepository _trackOrderRepositoryProvider =
      TrackOrderRepository();

  TrackOrderRepository get trackOrderRepositoryProvider =>
      _trackOrderRepositoryProvider;
  Future<void> fetchOrderDetails(
      BuildContext context, String id, String token) async {
    await _trackOrderRepositoryProvider.fetchOrderDetails(context, id, token);
    notifyListeners();
  }
}
