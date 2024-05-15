// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:rjfruits/view_model/home_view_model.dart';

class PopularItems extends StatelessWidget {
  const PopularItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const VerticalSpeacing(30.0),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColor.appBarTxColor,
                        ),
                      ),
                      const SizedBox(width: 80.0),
                      Text(
                        'Popular Items',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appBarTxColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(20.0),
                  Consumer<HomeRepositoryProvider>(
                      builder: (context, homeRepo, child) {
                    if (homeRepo.homeRepository.productsTopOrder.isEmpty) {
                      return GridView.count(
                        padding: const EdgeInsets.all(5.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: (180 / 250),
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        children: List.generate(
                          10,
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
                          homeRepo.homeRepository.productsTopOrder.length,
                          (index) => HomeCard(
                            isdiscount: false,
                            image: homeRepo.homeRepository
                                .productsTopOrder[index].thumbnailImage,
                            discount: homeRepo
                                .homeRepository.productsTopOrder[index].discount
                                .toString(),
                            title: homeRepo
                                .homeRepository.productsTopOrder[index].title,
                            price: homeRepo
                                .homeRepository.productsTopOrder[index].price
                                .toString(),
                            proId: homeRepo
                                .homeRepository.productsTopOrder[index].id
                                .toString(),
                            averageReview: homeRepo.homeRepository
                                .productsTopOrder[index].averageReview
                                .toString(),
                          ),
                        ),
                      );
                    }
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
