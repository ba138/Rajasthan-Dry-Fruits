import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/cart_button.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:rjfruits/view_model/home_view_model.dart';

class DefaultSection extends StatefulWidget {
  const DefaultSection({super.key});

  @override
  State<DefaultSection> createState() => _DefaultSectionState();
}

class _DefaultSectionState extends State<DefaultSection> {
  @override
  void initState() {
    Provider.of<HomeRepositoryProvider>(context, listen: false).getHomeProd(
      context,
    );
    super.initState();
  }

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
                'Popular Categories',
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
                  text: 'View All'),
            ],
          ),
        ),
        const VerticalSpeacing(12.0),
        Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Consumer<HomeRepositoryProvider>(
                builder: (context, homeRepo, child) {
              if (homeRepo.homeRepository.productsTopOrder.isEmpty) {
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
                    (index) => Center(
                      child: Text(
                        'No Products to show',
                        style: GoogleFonts.getFont(
                          "Roboto",
                          color: AppColor.textColor1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
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
                    homeRepo.homeRepository.productsTopOrder.length > 2
                        ? 2
                        : homeRepo.homeRepository.productsTopOrder.length,
                    (index) => HomeCard(
                      isdiscount: false,
                      image: homeRepo.homeRepository.productsTopOrder[index]
                          .thumbnailImage,
                      discount: homeRepo.homeRepository.productsTopOrder[index]
                          .discountedPriceWithTax
                          .toStringAsFixed(0),
                      title:
                          homeRepo.homeRepository.productsTopOrder[index].title,
                      price: homeRepo
                          .homeRepository.productsTopOrder[index].priceWithTax
                          .toStringAsFixed(0),
                      proId: homeRepo.homeRepository.productsTopOrder[index].id
                          .toString(),
                      averageReview: homeRepo
                          .homeRepository.productsTopOrder[index].averageReview
                          .toString(),
                    ),
                  ),
                );
              }
            })),
        const VerticalSpeacing(16.0),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Sellers',
                style: GoogleFonts.getFont(
                  "Roboto",
                  color: AppColor.textColor1,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              CartButton(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.bestSellers);
                  },
                  text: 'View All'),
            ],
          ),
        ),
        const VerticalSpeacing(12.0),
        Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Consumer<HomeRepositoryProvider>(
                builder: (context, homeRepo, child) {
              if (homeRepo.homeRepository.productsTopRated.isEmpty) {
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
                    (index) => Center(
                      child: Text(
                        'No Products to show',
                        style: GoogleFonts.getFont(
                          "Roboto",
                          color: AppColor.textColor1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
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
                    homeRepo.homeRepository.productsTopRated.length > 2
                        ? 2
                        : homeRepo.homeRepository.productsTopRated.length,
                    (index) => HomeCard(
                      isdiscount: false,
                      image: homeRepo.homeRepository.productsTopRated[index]
                          .thumbnailImage,
                      discount: homeRepo.homeRepository.productsTopRated[index]
                          .discountedPriceWithTax
                          .toStringAsFixed(0),
                      title:
                          homeRepo.homeRepository.productsTopRated[index].title,
                      price: homeRepo
                          .homeRepository.productsTopRated[index].priceWithTax
                          .toStringAsFixed(0),
                      proId: homeRepo.homeRepository.productsTopRated[index].id
                          .toString(),
                      averageReview: homeRepo
                          .homeRepository.productsTopOrder[index].averageReview
                          .toString(),
                    ),
                  ),
                );
              }
            })),
        const VerticalSpeacing(16.0),
        //DisCount Cart
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Discount',
                style: GoogleFonts.getFont(
                  "Roboto",
                  color: AppColor.textColor1,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              CartButton(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.discountProd);
                  },
                  text: 'View All'),
            ],
          ),
        ),
        const VerticalSpeacing(12.0),
        Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Consumer<HomeRepositoryProvider>(
                builder: (context, homeRepo, child) {
              if (homeRepo.homeRepository.productsTopDiscount.isEmpty) {
                return GridView.count(
                  padding: const EdgeInsets.all(5.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: (180 / 260),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: List.generate(
                    2,
                    (index) => Center(
                      child: Text(
                        'No Products to show',
                        style: GoogleFonts.getFont(
                          "Roboto",
                          color: AppColor.textColor1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
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
                  childAspectRatio: (180 / 260),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: List.generate(
                    // Limit to only two items
                    homeRepo.homeRepository.productsTopDiscount.length > 2
                        ? 2
                        : homeRepo.homeRepository.productsTopDiscount.length,
                    (index) => HomeCard(
                      isdiscount: true,
                      image: homeRepo.homeRepository.productsTopDiscount[index]
                          .thumbnailImage,
                      discount: homeRepo.homeRepository
                          .productsTopDiscount[index].discountedPriceWithTax
                          .toStringAsFixed(0),
                      title: homeRepo
                          .homeRepository.productsTopDiscount[index].title,
                      price: homeRepo.homeRepository.productsTopDiscount[index]
                          .priceWithTax
                          .toStringAsFixed(0),
                      proId: homeRepo
                          .homeRepository.productsTopDiscount[index].id
                          .toString(),
                      averageReview: homeRepo
                          .homeRepository.productsTopOrder[index].averageReview
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
