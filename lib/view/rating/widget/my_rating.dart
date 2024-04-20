import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';

import 'package:rjfruits/view/rating/widget/complete_review_card.dart';
import 'package:rjfruits/view/rating/widget/rating_card.dart';

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
    _tabController.dispose(); // Dispose of the TabController when done
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
                  text: 'To reviews(12)',
                ),
                Tab(
                  text: 'History(10)',
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
          controller: _tabController,
          children: const <Widget>[
            // Content for the "All" tab
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RatingCard(),
                )
              ],
            ),
            // Content for the "Running" tab
            Column(
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
