import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/repository/home_ui_repository.dart';
import 'package:rjfruits/res/components/cart_button.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:rjfruits/view_model/home_view_model.dart';
import 'package:shimmer/shimmer.dart';

class FilterProducts extends StatelessWidget {
  const FilterProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Products',
                style: GoogleFonts.getFont(
                  "Roboto",
                  color: AppColor.textColor1,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              CartButton(
                  onTap: () {
                    Provider.of<HomeUiSwithchRepository>(context, listen: false)
                        .switchToDefaultSection();
                  },
                  text: 'Clear'),
            ],
          ),
        ),
        const VerticalSpeacing(12.0),
        Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Consumer<HomeRepositoryProvider>(
                builder: (context, homeRepo, child) {
              if (homeRepo.homeRepository.filteredProducts.isEmpty) {
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
                      child: const HomeCard(
                        isdiscount: true,
                        averageReview: "4",
                      ),
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

                    homeRepo.homeRepository.filteredProducts.length,
                    (index) => HomeCard(
                      isdiscount: true,
                      image: homeRepo.homeRepository.filteredProducts[index]
                          .thumbnailImage,
                      discount: homeRepo
                          .homeRepository.filteredProducts[index].discount
                          .toString(),
                      title:
                          homeRepo.homeRepository.filteredProducts[index].title,
                      price: homeRepo
                          .homeRepository.filteredProducts[index].price
                          .toString(),
                      proId: homeRepo.homeRepository.filteredProducts[index].id
                          .toString(),
                      averageReview: homeRepo
                          .homeRepository.filteredProducts[index].averageReview
                          .toString(),
                    ),
                  ),
                );
              }
            })),
      ],
    );
  }
}
