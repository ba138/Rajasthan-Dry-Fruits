import 'package:flutter/material.dart';
import 'package:rjfruits/repository/rating_repository.dart';

class RatingRepositoryProvider extends ChangeNotifier {
  final RatingRepository _ratingRepository = RatingRepository();

  RatingRepository get ratingRepository => _ratingRepository;
  void rating(int rating, String prodId, String comment, BuildContext context,
      String token) {
    _ratingRepository.postOrderRating(rating, prodId, comment, context, token);
  }
}
