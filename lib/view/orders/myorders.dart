// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/view/orders/widgets/my_order_card.dart';
import '../../model/orders_model.dart';
import '../../res/components/colors.dart';
import '../../utils/routes/routes_name.dart';
import 'package:http/http.dart' as http;

import '../../view_model/user_view_model.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    fetchOrders();
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose of the TabController when done
    super.dispose();
  }

  // Method to fetch orders from the API
  List<OrderDetailedModel> orders = [];
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
        // If the request is successful, parse the JSON response
        print('................responce: ${response.body}..............');
        print('...................full name: ${orders.length}');

        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<OrderDetailedModel> fetchedOrders = jsonResponse
            .map((item) => OrderDetailedModel.fromJson(item))
            .toList();

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
          'My Orders',
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
              tabs: <Widget>[
                Tab(
                  text:
                      'All(${orders.length})', // Display total count of orders
                ),
                Tab(
                  text:
                      'Pending(${orders.where((order) => order.orderStatus == 'Pending').length})',
                ),
                Tab(
                  text:
                      'Approved(${orders.where((order) => order.orderStatus == 'Approved').length})',
                ),
                Tab(
                  text:
                      'Completed(${orders.where((order) => order.orderStatus == 'Completed').length})',
                ),
                const Tab(
                  text: 'cancelled',
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
          children: <Widget>[
            // Content for the "All" tab
            ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(order);
              },
            ),

            // Content for the "Running" tab (show orders with status "Running")
            ListView.builder(
              itemCount: orders
                  .where((order) => order.orderStatus == 'Pending')
                  .length,
              itemBuilder: (context, index) {
                final order = orders[index];
                if (order.orderStatus == 'Pending') {
                  return _buildOrderCard(order);
                } else {
                  return const Center(
                    child: Text('Empty Pending Orders'),
                  );
                }
              },
            ),

            // Content for the "Previous" tab (show orders with status "Previous")
            ListView.builder(
              itemCount: orders
                  .where((order) => order.orderStatus == 'Approved')
                  .length,
              itemBuilder: (context, index) {
                final order = orders[index];
                if (order.orderStatus == 'Approved') {
                  return _buildOrderCard(order);
                } else {
                  return const Center(
                    child: Text('Empty Approved Orders'),
                  );
                }
              },
            ),

            // Content for the "Completed" tab (show orders with status "Completed")
            ListView.builder(
              itemCount: orders
                  .where((order) => order.orderStatus == 'Completed')
                  .length,
              itemBuilder: (context, index) {
                final order = orders[index];
                if (order.orderStatus == 'Completed') {
                  return _buildOrderCard(order);
                } else {
                  return const Center(
                    child: Text('Empty Completed Orders'),
                  );
                }
              },
            ),

            // Content for the "Canceled" tab (show orders with status "Canceled")
            ListView.builder(
              itemCount: orders
                  .where((order) => order.orderStatus == 'cancelled')
                  .length,
              itemBuilder: (context, index) {
                final order = orders[index];
                if (order.orderStatus == 'cancelled') {
                  return _buildOrderCard(order);
                } else {
                  return const Center(
                    child: Text('Empty cancelled Orders'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildOrderCard(OrderDetailedModel order) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: myOrderCard(
        ontap: () {
          Navigator.pushNamed(context, RoutesName.trackOrder);
        },
        orderId: order.id.toString(),
        status: order.orderStatus,
        cartImg:
            'https://i.pinimg.com/736x/4a/53/4e/4a534eba5808e7f207c421b9d9647401.jpg',
        cartTitle: order.fullName,
        quantity: order.city.toString(),
      ),
    );
  }
}
