import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:rjfruits/view_model/shop_view_model.dart';

class DeaultSearchSection extends StatelessWidget {
  const DeaultSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopRepositoryProvider>(
      builder: (context, shopRepositoryProvider, _) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: (180 / 245),
          mainAxisSpacing: 10.0, // Spacing between rows
          crossAxisSpacing: 10.0, // Spacing between columns
          children: List.generate(
            shopRepositoryProvider.shopRepository.shopProducts.length,
            (index) => HomeCard(
              isdiscount: false,
              title: shopRepositoryProvider
                  .shopRepository.shopProducts[index].title,
              image: shopRepositoryProvider
                  .shopRepository.shopProducts[index].thumbnailImage,
              discount: shopRepositoryProvider
                  .shopRepository.shopProducts[index].discountedPriceWithTax
                  .toStringAsFixed(0),
              proId:
                  shopRepositoryProvider.shopRepository.shopProducts[index].id,
              price: shopRepositoryProvider
                  .shopRepository.shopProducts[index].priceWithTax
                  .toStringAsFixed(0),
              averageReview: shopRepositoryProvider
                  .shopRepository.shopProducts[index].averageReview
                  .toString(),
              // Pass other data properties here
            ),
          ),
        );
      },
    );
  }
}
