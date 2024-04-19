import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/cart_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import '../../res/components/categorycard.dart';
import '../../res/components/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isSelected = false;
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
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpeacing(40.0),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 40.0,
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
                    trailing: Container(
                      height: 34,
                      width: 34,
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
                  const VerticalSpeacing(16.0),
                  const SearchBar(),
                  const VerticalSpeacing(14.0),
                  Container(
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
                  ),
                  const VerticalSpeacing(16.0),
                  Text(
                    'Categories',
                    style: GoogleFonts.getFont(
                      "Roboto",
                      color: AppColor.textColor1,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const VerticalSpeacing(9.0),
                  SizedBox(
                    height: 50,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CategoryCart(
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
                            text: 'All',
                          ),
                          const SizedBox(width: 10.0),
                          CategoryCart(
                            bgColor: AppColor.boxColor,
                            textColor: AppColor.textColor1,
                            onTap: () {},
                            text: 'Penut',
                          ),
                          const SizedBox(width: 10.0),
                          CategoryCart(
                            bgColor: AppColor.boxColor,
                            textColor: AppColor.textColor1,
                            onTap: () {},
                            text: 'Apricot',
                          ),
                          const SizedBox(width: 10.0),
                          CategoryCart(
                            bgColor: AppColor.boxColor,
                            textColor: AppColor.textColor1,
                            onTap: () {},
                            text: 'peach',
                          ),
                          const SizedBox(width: 10.0),
                          CategoryCart(
                            bgColor: AppColor.boxColor,
                            textColor: AppColor.textColor1,
                            onTap: () {},
                            text: 'figs',
                          ),
                          const SizedBox(width: 10.0),
                          CategoryCart(
                            bgColor: AppColor.boxColor,
                            textColor: AppColor.textColor1,
                            onTap: () {},
                            text: 'Penut',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpeacing(16.0),
                  Row(
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
                      CartButton(onTap: () {}, text: 'View All'),
                    ],
                  ),
                  const VerticalSpeacing(12.0),
                  Container(
                    height: 240,
                    width: 192,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 2),
                      color: const Color.fromRGBO(
                          255, 255, 255, 0.2), // Background color with opacity
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5), // Shadow color
                          blurRadius: 2, // Blur radius
                          spreadRadius: 0, // Spread radius
                          offset: const Offset(0, 0), // Offset
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 24,
                                width: 74,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColor.primaryColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0,
                                          0.25), // Shadow color (black with 25% opacity)
                                      blurRadius: 8.1, // Blur radius
                                      offset:
                                          Offset(0, 4), // Offset (Y direction)
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: AppColor.whiteColor,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.remove,
                                            size: 16,
                                            color: AppColor.iconColor,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '2KG',
                                        style: TextStyle(
                                            color: AppColor.whiteColor),
                                      ),
                                      Container(
                                        height: 18,
                                        width: 18,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: AppColor.whiteColor,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 16,
                                            color: AppColor.iconColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 85,
                            width: 145,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/cartImg.png'),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dried Figs',
                                style: GoogleFonts.getFont(
                                  "Roboto",
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.cardTxColor,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppColor.primaryColor,
                                    size: 20,
                                  ),
                                  Text(
                                    '4.5',
                                    style: GoogleFonts.getFont(
                                      "Roboto",
                                      textStyle: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '\$50 ',
                                style: GoogleFonts.getFont(
                                  "Roboto",
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.cardTxColor,
                                  ),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Text(
                                '\$20 ',
                                style: GoogleFonts.getFont(
                                  "Roboto",
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.textColor1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpeacing(6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 37,
                                width: 37,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19),
                                  color: AppColor.primaryColor,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset('images/cart.png'),
                                  ),
                                ),
                              ),
                              CartButton(onTap: () {}, text: 'View'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpeacing(40.0)
                ],
              ),
            ],
          ),
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
                onPressed: () {},
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
