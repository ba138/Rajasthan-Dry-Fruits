// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';

import 'package:rjfruits/view/rating/widget/complete_review_card.dart';
import 'package:rjfruits/view/rating/widget/rating_card.dart';

import '../../../model/orders_model.dart';
import '../../../view_model/user_view_model.dart';
import 'package:http/http.dart' as http;

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

  // Method to fetch orders from the API
  List<OrdersModel> orders = [];
  void fetchOrders() async {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    final userModel = await userPreferences.getUser();
    final token = userModel.key;
    try {
      final response = await http.get(
        Uri.parse('http://103.117.180.187/api/order/'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Token $token',
          'X-CSRFToken':
              'kRWqrSSxl1EedHHJNQuWBmGofniQ1XU0uwnaLZbEf3RnSEO6y7nKl4NuQADOpUgw',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<OrdersModel> fetchedOrders =
            jsonResponse.map((item) => OrdersModel.fromJson(item)).toList();

        setState(() {
          orders = fetchedOrders; // Update the orders list with fetched data
        });
      } else {
        // Handle API request failure
        print('Failed to fetch orders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions during API request
      print('Error occurred while fetching  orders: $e');
    }
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
