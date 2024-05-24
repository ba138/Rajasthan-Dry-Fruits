import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/cart_button.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:rjfruits/view_model/home_view_model.dart';
import 'package:shimmer/shimmer.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Products',
                style: GoogleFonts.getFont(
                  "Roboto",
                  color: AppColor.textColor1,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              CartButton(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.popularItems);
                  },
                  text: 'Remove'),
            ],
          ),
        ),
        const VerticalSpeacing(12.0),
        Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Consumer<HomeRepositoryProvider>(
                builder: (context, homeRepo, child) {
              if (homeRepo.homeRepository.searchResults.isEmpty) {
                return GridView.count(
                  padding: const EdgeInsets.all(5.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: (180 / 255),
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
                  childAspectRatio: (180 / 255),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: List.generate(
                    // Limit to only two items
                    homeRepo.homeRepository.searchResults.length,
                    (index) => HomeCard(
                      isdiscount: false,
                      image: homeRepo
                          .homeRepository.searchResults[index].thumbnailImage,
                      discount: homeRepo
                          .homeRepository.searchResults[index].discount
                          .toString(),
                      title: homeRepo.homeRepository.searchResults[index].title,
                      price: homeRepo.homeRepository.searchResults[index].price
                          .toString(),
                      averageReview: homeRepo
                          .homeRepository.searchResults[index].averageReview
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
