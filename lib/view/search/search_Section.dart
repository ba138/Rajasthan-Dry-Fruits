// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:rjfruits/view_model/shop_view_model.dart';

class SearchSectionUi extends StatelessWidget {
  const SearchSectionUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopRepositoryProvider>(
        builder: (context, homeRepo, child) {
      if (homeRepo.shopRepository.searchResults.isEmpty) {
        return GridView.count(
          padding: const EdgeInsets.all(5.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: (180 / 250),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          children: List.generate(
            2,
            (index) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const HomeCard(isdiscount: true, averageReview: "4"),
            ),
          ),
        );
      } else {
        return GridView.count(
          padding: const EdgeInsets.all(5.0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: (180 / 250),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          children: List.generate(
            // Limit to only two items
            homeRepo.shopRepository.searchResults.length,
            (index) => HomeCard(
              isdiscount: false,
              image:
                  homeRepo.shopRepository.searchResults[index].thumbnailImage,
              discount: homeRepo.shopRepository.searchResults[index].discount
                  .toString(),
              title: homeRepo.shopRepository.searchResults[index].title,
              price:
                  homeRepo.shopRepository.searchResults[index].price.toString(),
              proId: homeRepo.shopRepository.searchResults[index].id.toString(),
              averageReview: homeRepo
                  .shopRepository.searchResults[index].averageReview
                  .toString(),
            ),
          ),
        );
      }
    });
  }
}
