import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/home_model.dart';
import 'package:rjfruits/res/components/cart_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:rjfruits/view_model/home_view_model.dart';
import '../../res/components/categorycard.dart';
import '../../res/components/colors.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isSelected = false;
  @override
  void initState() {
    Provider.of<HomeRepositoryProvider>(context, listen: false).getHomeProd(
      context,
    );
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
                  subtitle: Text(
                    'Hiren user',
                    style: GoogleFonts.getFont(
                      "Roboto",
                      color: AppColor.textColor1,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
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
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  child: SearchBar(),
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
                    height: 50,
                    child: Consumer<HomeRepositoryProvider>(
                      builder: (context, homeRepo, child) {
                        if (homeRepo.homeRepository.productCategories.isEmpty) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeRepo
                                .homeRepository.productCategories.length,
                            itemExtent: MediaQuery.of(context).size.width / 3.6,
                            itemBuilder: (BuildContext context, int index) {
                              Category category = homeRepo
                                  .homeRepository.productCategories[index];

                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: CategoryCart(
                                  bgColor: _isSelected
                                      ? AppColor.primaryColor
                                      : AppColor.boxColor,
                                  textColor: _isSelected
                                      ? AppColor.whiteColor
                                      : AppColor.textColor1,
                                  onTap: () {
                                    setState(() {
                                      _isSelected = !_isSelected;
                                    });
                                  },
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
                                bgColor: _isSelected
                                    ? AppColor.primaryColor
                                    : AppColor.boxColor,
                                textColor: _isSelected
                                    ? AppColor.whiteColor
                                    : AppColor.textColor1,
                                onTap: () {
                                  setState(() {
                                    _isSelected = !_isSelected;
                                  });
                                },
                                text: category.name,
                              );
                            },
                          );
                        }
                      },
                    ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       CategoryCart(
                    //         bgColor: _isSelected
                    //             ? AppColor.primaryColor
                    //             : AppColor.boxColor,
                    //         textColor: _isSelected
                    //             ? AppColor.whiteColor
                    //             : AppColor.textColor1,
                    //         onTap: () {
                    //           setState(() {
                    //             _isSelected = !_isSelected;
                    //           });
                    //         },
                    //         text: 'All',
                    //       ),
                    //       const SizedBox(width: 10.0),
                    //       CategoryCart(
                    //         bgColor: AppColor.boxColor,
                    //         textColor: AppColor.textColor1,
                    //         onTap: () {},
                    //         text: 'Penut',
                    //       ),
                    //       const SizedBox(width: 10.0),
                    //       CategoryCart(
                    //         bgColor: AppColor.boxColor,
                    //         textColor: AppColor.textColor1,
                    //         onTap: () {},
                    //         text: 'Apricot',
                    //       ),
                    //       const SizedBox(width: 10.0),
                    //       CategoryCart(
                    //         bgColor: AppColor.boxColor,
                    //         textColor: AppColor.textColor1,
                    //         onTap: () {},
                    //         text: 'peach',
                    //       ),
                    //       const SizedBox(width: 10.0),
                    //       CategoryCart(
                    //         bgColor: AppColor.boxColor,
                    //         textColor: AppColor.textColor1,
                    //         onTap: () {},
                    //         text: 'figs',
                    //       ),
                    //       const SizedBox(width: 10.0),
                    //       CategoryCart(
                    //         bgColor: AppColor.boxColor,
                    //         textColor: AppColor.textColor1,
                    //         onTap: () {},
                    //         text: 'Penut',
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                ),
                const VerticalSpeacing(16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Categories',
                        style: GoogleFonts.getFont(
                          "Roboto",
                          color: AppColor.textColor1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CartButton(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.popularItems);
                          },
                          text: 'View All'),
                    ],
                  ),
                ),
                const VerticalSpeacing(12.0),
                Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Consumer<HomeRepositoryProvider>(
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
                            homeRepo.homeRepository.productsTopOrder.length > 2
                                ? 2
                                : homeRepo
                                    .homeRepository.productsTopOrder.length,
                            (index) => HomeCard(
                              isdiscount: false,
                              image: homeRepo.homeRepository
                                  .productsTopOrder[index].thumbnailImage,
                              discount: homeRepo.homeRepository
                                  .productsTopOrder[index].discount
                                  .toString(),
                              title: homeRepo
                                  .homeRepository.productsTopOrder[index].title,
                              price: homeRepo
                                  .homeRepository.productsTopOrder[index].price
                                  .toString(),
                              proId: homeRepo
                                  .homeRepository.productsTopOrder[index].id
                                  .toString(),
                            ),
                          ),
                        );
                      }
                    })),
                const VerticalSpeacing(16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Best Sellers',
                        style: GoogleFonts.getFont(
                          "Roboto",
                          color: AppColor.textColor1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CartButton(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.bestSellers);
                          },
                          text: 'View All'),
                    ],
                  ),
                ),
                const VerticalSpeacing(12.0),
                Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Consumer<HomeRepositoryProvider>(
                        builder: (context, homeRepo, child) {
                      if (homeRepo.homeRepository.productsTopRated.isEmpty) {
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
                            homeRepo.homeRepository.productsTopRated.length > 2
                                ? 2
                                : homeRepo
                                    .homeRepository.productsTopRated.length,
                            (index) => HomeCard(
                              isdiscount: false,
                              image: homeRepo.homeRepository
                                  .productsTopRated[index].thumbnailImage,
                              discount: homeRepo.homeRepository
                                  .productsTopRated[index].discount
                                  .toString(),
                              title: homeRepo
                                  .homeRepository.productsTopRated[index].title,
                              price: homeRepo
                                  .homeRepository.productsTopRated[index].price
                                  .toString(),
                              proId: homeRepo
                                  .homeRepository.productsTopRated[index].id
                                  .toString(),
                            ),
                          ),
                        );
                      }
                    })),
                const VerticalSpeacing(16.0),
                //DisCount Cart
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Discount',
                        style: GoogleFonts.getFont(
                          "Roboto",
                          color: AppColor.textColor1,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CartButton(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.discountProd);
                          },
                          text: 'View All'),
                    ],
                  ),
                ),
                const VerticalSpeacing(12.0),
                Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Consumer<HomeRepositoryProvider>(
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
                            homeRepo.homeRepository.productsTopDiscount.length >
                                    2
                                ? 2
                                : homeRepo
                                    .homeRepository.productsTopDiscount.length,
                            (index) => HomeCard(
                              isdiscount: true,
                              image: homeRepo.homeRepository
                                  .productsTopDiscount[index].thumbnailImage,
                              discount: homeRepo.homeRepository
                                  .productsTopDiscount[index].discount
                                  .toString(),
                              title: homeRepo.homeRepository
                                  .productsTopDiscount[index].title,
                              price: homeRepo.homeRepository
                                  .productsTopDiscount[index].price
                                  .toString(),
                              proId: homeRepo
                                  .homeRepository.productsTopDiscount[index].id
                                  .toString(),
                            ),
                          ),
                        );
                      }
                    })),
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
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColor.boxColor,
      ),
      child: TextField(
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
      ),
    );
  }
}
