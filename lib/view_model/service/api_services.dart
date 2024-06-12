import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../model/review_history_model.dart';
import '../user_view_model.dart';

class ApiService {
  static const String apiUrl = 'http://103.117.180.187/api/rating/list/';

  Future<List<ReviewHistoryModel>> fetchReviewHistory(
      BuildContext context) async {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    final userModel = await userPreferences.getUser();
    final token = userModel.key;
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'accept': 'application/json',
        'X-CSRFToken':
            'Nd0ntDXEJQP2tUOLZW4KoSXoif67IuraeFgGZmi7I2OI9E2SgDCjVQuNt67w3K5S',
        'authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      debugPrint('Response of the api ${response.body}');
      return reviewHistoryModelFromJson(response.body);
    } else {
      throw Exception('Failed to load review history');
    }
  }
}
