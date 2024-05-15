// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/home_model.dart';
import 'package:rjfruits/repository/home_ui_repository.dart';
import 'package:rjfruits/res/components/cart_button.dart';
import 'package:rjfruits/res/components/enums.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/HomeView/category_products.dart';
import 'package:rjfruits/view/HomeView/default_section.dart';
import 'package:rjfruits/view/HomeView/filter_products.dart';
import 'package:rjfruits/view/HomeView/search_section.dart';
import 'package:rjfruits/view_model/home_view_model.dart';
import '../../res/components/categorycard.dart';
import '../../res/components/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../view_model/user_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();
  Map userData = {};

  String token = "";

  Future<void> _getUserData() async {
    try {
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      final userModel = await userPreferences.getUser();
      // Await the Future<UserModel> result
      token = userModel.key;
      final userData =
          await Provider.of<HomeRepositoryProvider>(context, listen: false)
              .getUserData(token);
      setState(() {
        this.userData = userData;
      });
      debugPrint("this is the cliecnt details:$userData");
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  @override
  void initState() {
    _getUserData();

    super.initState();
  }

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
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpeacing(40.0),
                ListTile(
                  leading: const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                    ),
                  ),
                  title: Text(
                    'WellCome',
                    style: GoogleFonts.getFont(
                      "Roboto",
                      color: AppColor.textColor2,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: userData.isNotEmpty
                      ? Text(
                          '${userData['first_name']} ${userData['last_name']}',
                          style: GoogleFonts.getFont(
                            "Roboto",
                            color: AppColor.textColor1,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Text(
                            '${userData['first_name']} ${userData['last_name']}',
                            style: GoogleFonts.getFont(
                              "Roboto",
                              color: AppColor.textColor1,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                  trailing: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.notificationView);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: AppColor.boxColor,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.notifications,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalSpeacing(16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: SearchBar(
                    searchController: searchController,
                  ),
                ),
                const VerticalSpeacing(14.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    height: 159.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff000000)
                              .withOpacity(0.25), // color of the shadow
                          spreadRadius: 0, // spread radius
                          blurRadius: 4, // blur radius
                          offset: const Offset(0, 4),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage('images/banner.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, bottom: 30.0),
                          child: CartButton(onTap: () {}, text: 'Order Now'),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpeacing(16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
                    'Categories',
                    style: GoogleFonts.getFont(
                      "Roboto",
                      color: AppColor.textColor1,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const VerticalSpeacing(9.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 0),
                  child: SizedBox(
                    height: 70,
                    child: Consumer<HomeRepositoryProvider>(
                      builder: (context, homeRepo, child) {
                        if (homeRepo.homeRepository.productCategories.isEmpty) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemExtent: MediaQuery.of(context).size.width / 3.6,
                            itemBuilder: (BuildContext context, int index) {
                              // Category category = homeRepo
                              //     .homeRepository.productCategories[index];

                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: const CategoryCart(
                                  text: "category.name",
                                ),
                              );
                            },
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeRepo
                                .homeRepository.productCategories.length,
                            itemExtent: MediaQuery.of(context).size.width / 3.6,
                            itemBuilder: (BuildContext context, int index) {
                              Category category = homeRepo
                                  .homeRepository.productCategories[index];

                              return CategoryCart(
                                text: category.name,
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                const VerticalSpeacing(16.0),
                Consumer<HomeUiSwithchRepository>(
                  builder: (context, uiState, _) {
                    Widget selectedWidget;

                    switch (uiState.selectedType) {
                      case UIType.SearchSection:
                        selectedWidget = const SearchSection();
                        break;
                      case UIType.FilterSection:
                        selectedWidget = const FilterProducts();
                        break;
                      case UIType.CategoriesSection:
                        selectedWidget = const CategoriesSection();
                        break;
                      case UIType.DefaultSection:
                        selectedWidget = const DefaultSection();
                        break;
                    }

                    return selectedWidget;
                  },
                ),
                const VerticalSpeacing(40.0)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 46,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColor.boxColor,
        ),
        child: Consumer<HomeRepositoryProvider>(
          builder: (context, viewModel, _) {
            return TextField(
              controller: searchController,
              onChanged: (value) {
                if (searchController.text.isNotEmpty) {
                  viewModel.search(
                    value,
                    viewModel.homeRepository.productsTopRated,
                    viewModel.homeRepository.productsTopOrder,
                    viewModel.homeRepository.productsTopDiscount,
                  );
                  Provider.of<HomeUiSwithchRepository>(context, listen: false)
                      .switchToType(UIType.SearchSection);
                } else {
                  Provider.of<HomeUiSwithchRepository>(context, listen: false)
                      .switchToType(UIType.DefaultSection);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColor.textColor1,
                ),
                suffixIcon: Container(
                  height: 47.0,
                  width: 47.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColor.primaryColor),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.filter,
                        );
                      },
                      icon: const ImageIcon(
                        AssetImage("images/filter.png"),
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
                hintStyle: GoogleFonts.getFont(
                  "Roboto",
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor2,
                  ),
                ),
                border: InputBorder.none,
              ),
            );
          },
        ));
  }
}
