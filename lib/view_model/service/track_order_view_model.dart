import 'package:flutter/material.dart';
import 'package:rjfruits/repository/track_repository.dart';

class TrackOrderRepositoryProvider extends ChangeNotifier {
  final TrackOrderRepository _trackOrderRepositoryProvider =
      TrackOrderRepository();

  TrackOrderRepository get trackOrderRepositoryProvider =>
      _trackOrderRepositoryProvider;
  Future<void> fetchOrderDetails(BuildContext context, String id, String token,
      String shopRocketId) async {
    await _trackOrderRepositoryProvider.fetchOrderDetails(
        context, id, token, shopRocketId);
    notifyListeners();
  }

  Future<void> fetchShipData(
    String id,
    String token,
  ) async {
    await _trackOrderRepositoryProvider.fetchShipmentDetail(
      id,
      token,
    );
    notifyListeners();
  }
}
