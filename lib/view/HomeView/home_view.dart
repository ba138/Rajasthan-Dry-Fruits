import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import '../../res/components/colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
            children: [
              const VerticalSpeacing(40.0),
              ListTile(
                leading: const CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                    'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg',
                  ),
                ),
                title: const Text(
                  'WellCome',
                  style: TextStyle(
                    color: AppColor.textColor2,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                subtitle: const Text(
                  'Hiren user',
                  style: TextStyle(
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
              SearchBar(),
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
