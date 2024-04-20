// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rjfruits/view/HomeView/home_view.dart';

import '../../res/components/colors.dart';
import '../profileView/profile_view.dart';
import '../saveView/save_view.dart';
import '../shopView/shop_view.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectIndex = 0;
  onItemClick(int index) {
    setState(() {
      selectIndex = index;
      tabController!.index = selectIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [HomeView(), ShopView(), SaveView(), ProfileView()],
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/homeIcon.png')),
                label: ('Home'),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('images/shop.png')),
                label: ('Shop'),
              ),
              // BottomNavigationBarItem(
              //     icon: Icon(
              //       Icons.abc,
              //       color: Colors.transparent,
              //     ),
              //     label: ''),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark_outline_rounded,
                ),
                label: ('Save'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                ),
                label: ('Profile'),
              ),
            ],
            unselectedItemColor: AppColor.dashboardIconColor,
            selectedItemColor: AppColor.primaryColor,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            currentIndex: selectIndex,
            onTap: onItemClick,
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 60.0,
        height: 60.0,
        decoration: const BoxDecoration(
          color: AppColor.primaryColor, // Background color
          shape: BoxShape.circle, // Circular shape
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(
                  0, 0, 0, 0.25), // Shadow color (black with 25% opacity)
              blurRadius: 8.1, // Blur radius
              offset: Offset(0, 4), // Offset (Y direction)
            ),
          ],
        ),
        child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors
                .transparent, // Transparent background for inner FloatingActionButton
            elevation: 0, // No shadow
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset('images/cart.png'),
            ))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
