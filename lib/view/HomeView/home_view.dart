import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          child: Column(
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
                  fontWeight: FontWeight.w600,
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
              )
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
