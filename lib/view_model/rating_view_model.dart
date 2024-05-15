import 'package:flutter/material.dart';
import 'package:rjfruits/repository/rating_repository.dart';

class RatingRepositoryProvider extends ChangeNotifier {
  final RatingRepository _ratingRepository = RatingRepository();

  RatingRepository get ratingRepository => _ratingRepository;
  void rating(int rating, String prodId, String comment, BuildContext context,
      String token, int client, int order) {
    _ratingRepository.postOrderRating(
        rating, prodId, comment, context, token, client, order);
  }

  void pedingReview(
    String token,
    BuildContext context,
  ) {
    _ratingRepository.getPendingReviews(context, token);
  }
}
