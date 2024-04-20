import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/orders/widgets/my_order_card.dart';
import '../../res/components/colors.dart';
import '../../utils/routes/routes_name.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

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
              tabs: const <Widget>[
                Tab(
                  text: 'All(12)',
                ),
                Tab(
                  text: 'Running(10)',
                ),
                Tab(
                  text: 'Previous(2)',
                ),
                Tab(
                  text: 'Completed(2)',
                ),
                Tab(
                  text: 'Canceled',
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: myOrderCard(
                    ontap: () {
                      Navigator.pushNamed(context, RoutesName.trackOrder);
                    },
                  ),
                )
              ],
            ),
            // Content for the "Running" tab
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: myOrderCard(
                    ontap: () {
                      // Navigator.pushNamed(context, RoutesName.OrderTrackingScreen);
                    },
                  ),
                )
              ],
            ),
            // Content for the "Previous" tab
            Column(
              children: [
                const VerticalSpeacing(20.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: myOrderCard(
                    ontap: () {
                      // Navigator.pushNamed(context, RoutesName.myOrderHistory);
                    },
                  ),
                )
              ],
            ),
            // Content for the "Completed" tab
            Column(
              children: [
                const VerticalSpeacing(20.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: myOrderCard(
                    ontap: () {
                      // Navigator.pushNamed(context, RoutesName.myOrderHistory);
                    },
                  ),
                ),
              ],
            ),
            // Content for the "Canceled" tab
            Column(
              children: [
                const VerticalSpeacing(20.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: myOrderCard(
                    ontap: () {
                      // Navigator.pushNamed(context, RoutesName.myOrderHistory);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
