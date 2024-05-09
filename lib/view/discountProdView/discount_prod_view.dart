import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/view_model/home_view_model.dart';
import 'package:shimmer/shimmer.dart';

class DisCountProd extends StatelessWidget {
  const DisCountProd({super.key});

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
                        'Discount Products',
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
                  const VerticalSpeacing(10.0),
                  Consumer<HomeRepositoryProvider>(
                      builder: (context, homeRepo, child) {
                    if (homeRepo.homeRepository.productsTopDiscount.isEmpty) {
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
                            child: const HomeCard(isdiscount: true),
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
                          homeRepo.homeRepository.productsTopDiscount.length,
                          (index) => HomeCard(
                            isdiscount: true,
                            image: homeRepo.homeRepository
                                .productsTopDiscount[index].thumbnailImage,
                            discount: homeRepo.homeRepository
                                .productsTopDiscount[index].discount
                                .toString(),
                            title: homeRepo.homeRepository
                                .productsTopDiscount[index].title,
                            price: homeRepo
                                .homeRepository.productsTopDiscount[index].price
                                .toString(),
                            proId: homeRepo
                                .homeRepository.productsTopDiscount[index].id
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
