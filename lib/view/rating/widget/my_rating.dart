// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';

import 'package:rjfruits/view/rating/widget/complete_review_card.dart';
import 'package:rjfruits/view/rating/widget/rating_card.dart';
import 'package:rjfruits/view_model/rating_view_model.dart';

class MyRating extends StatefulWidget {
  const MyRating({super.key});

  @override
  _MyRatingState createState() => _MyRatingState();
}

class _MyRatingState extends State<MyRating>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.west,
            color: AppColor.appBarTxColor,
          ),
        ),
        title: Text(
          'My Rating',
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColor.appBarTxColor,
            ),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: SafeArea(
            child: TabBar(
              controller: _tabController, // Provide the TabController here
              indicatorColor: AppColor.primaryColor,
              labelColor: AppColor.primaryColor,
              unselectedLabelColor: AppColor.textColor1,
              tabs: const <Widget>[
                Tab(
                  text: 'Give Review',
                ),
                Tab(
                  text: 'History',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[
            // Content for the "All" tab

            // Content for the "Running" tab
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<RatingRepositoryProvider>(
                builder: (context, homeRepo, child) {
                  if (homeRepo.ratingRepository.orders.isEmpty) {
                    return Center(
                      child: Text(
                        'No products to rate',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appBarTxColor,
                          ),
                        ),
                      ),
                    );

                  } else {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemCount: homeRepo.ratingRepository.orders.length,
                        separatorBuilder: (context, index) => const SizedBox(
                            height: 10.0), // Spacing between cards
                        itemBuilder: (context, index) {
                          return RatingCard(
                            id: homeRepo
                                .ratingRepository.orders[index].product.id,
                            title: homeRepo
                                .ratingRepository.orders[index].product.title,
                            image: homeRepo.ratingRepository.orders[index]
                                .product.thumbnailImage,
                            order:
                                homeRepo.ratingRepository.orders[index].order,
                          );
                        });
                  }
                },
              ),
            ),

            const Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(10.0), child: CompleteReviewCards())
              ],
            ),
          ],
        ),
      ),
    );
  }
}
