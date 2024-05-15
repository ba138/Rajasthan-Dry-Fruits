// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/view/orders/widgets/my_order_card.dart';
import 'package:rjfruits/view/orders/widgets/track_order.dart';
import 'package:rjfruits/view_model/service/track_order_view_model.dart';
import '../../model/orders_model.dart';
import '../../res/components/colors.dart';
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
              controller: _tabController,
              indicatorColor: AppColor.primaryColor,
              labelColor: AppColor.primaryColor,
              unselectedLabelColor: AppColor.textColor1,
              tabs: <Widget>[
                Tab(
                  text: 'All(${orders.length})',
                ),
                Tab(
                  text:
                      'pending(${orders.where((order) => order.orderStatus == 'pending').length})',
                ),
                Tab(
                  text:
                      'approved(${orders.where((order) => order.orderStatus == 'approved').length})',
                ),
                Tab(
                  text:
                      'completed(${orders.where((order) => order.orderStatus == 'completed').length})',
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
                if (orders.isEmpty) {
                  return const Center(
                    child: Text('Empty All Orders'),
                  );
                } else {
                  final order = orders[index];
                  return _buildOrderCard(order);
                }
              },
            ),

            // Content for the "Running" tab (show orders with status "Running")
            ListView.builder(
              itemCount: orders
                  .where((order) => order.orderStatus == 'pending')
                  .length,
              itemBuilder: (context, index) {
                final pendingOrders = orders
                    .where((order) => order.orderStatus == 'pending')
                    .toList();

                if (pendingOrders.isEmpty) {
                  return const Center(
                    child: Text('No pending orders found.'),
                  );
                }

                final order = pendingOrders[index];
                return _buildOrderCard(order);
              },
            ),

            // Content for the "Previous" tab (show orders with status "Previous")
            ListView.builder(
              itemCount: orders
                  .where((order) => order.orderStatus == 'approved')
                  .length,
              itemBuilder: (context, index) {
                final approvedOrders = orders
                    .where((order) => order.orderStatus == 'approved')
                    .toList();

                if (approvedOrders.isEmpty) {
                  return const Center(
                    child: Text('No approved orders found.'),
                  );
                }

                final order = approvedOrders[index];
                return _buildOrderCard(order);
              },
            ),

            // Content for the "Completed" tab (show orders with status "Completed")
            ListView.builder(
              itemCount: orders
                  .where((order) => order.orderStatus == 'completed')
                  .length,
              itemBuilder: (context, index) {
                final completedOrders = orders
                    .where((order) => order.orderStatus == 'completed')
                    .toList();

                if (completedOrders.isEmpty) {
                  return const Center(
                    child: Text('No completed orders found.'),
                  );
                }

                final order = completedOrders[index];
                return _buildOrderCard(order);
              },
            ),

            // Content for the "Canceled" tab (show orders with status "Canceled")
            ListView.builder(
              itemCount: orders
                  .where((order) => order.orderStatus == 'cancelled')
                  .length,
              itemBuilder: (context, index) {
                final cancelledOrders = orders
                    .where((order) => order.orderStatus == 'cancelled')
                    .toList();

                if (cancelledOrders.isEmpty) {
                  return const Center(
                    child: Text('No cancelled orders found.'),
                  );
                }

                final order = cancelledOrders[index];
                return _buildOrderCard(order);
              },
            ),
          ],
        ),
      ),
    );
  }

  getAllTheData({required String orderId}) async {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    final userModel =
        await userPreferences.getUser(); // Await the Future<UserModel> result
    final token = userModel.key;
    Provider.of<TrackOrderRepositoryProvider>(context, listen: false)
        .fetchOrderDetails(context, orderId, token);
  }

  _buildOrderCard(OrdersModel order) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: myOrderCard(
        ontap: () {
          getAllTheData(orderId: order.id.toString());
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
