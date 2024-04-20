import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/HomeView/widgets/filter_container.dart';
import 'package:rjfruits/view/HomeView/widgets/price_slider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
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
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpeacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 31,
                        width: 35,
                        decoration: BoxDecoration(
                          color: AppColor.boxColor,
                          borderRadius: BorderRadius.circular(
                            4,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: AppColor.textColor1,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Filter",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                    Text(
                      "Reset",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(50),
                Text(
                  "Categories",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                const VerticalSpeacing(16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterContainer(
                        textColor: AppColor.whiteColor,
                        bgColor: AppColor.primaryColor,
                        text: "Categories",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.textColor1,
                        bgColor: Colors.transparent,
                        text: "Categories",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.textColor1,
                        bgColor: AppColor.primaryColor,
                        text: "Categories",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.textColor1,
                        bgColor: Colors.transparent,
                        text: "Categories",
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(16),
                const FilterContainer(
                  textColor: AppColor.nextColor,
                  bgColor: Colors.transparent,
                  text: "See All",
                ),
                const VerticalSpeacing(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sort By",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Popularity",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.expand_more,
                          color: AppColor.primaryColor,
                        ),
                      ],
                    )
                  ],
                ),
                const VerticalSpeacing(24),
                const PriceRangeSlider(),
                const VerticalSpeacing(14),
                Text(
                  "Product",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                const VerticalSpeacing(16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterContainer(
                        textColor: AppColor.whiteColor,
                        bgColor: AppColor.primaryColor,
                        text: "Peanut",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.textColor1,
                        bgColor: Colors.transparent,
                        text: "Walnut",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.whiteColor,
                        bgColor: AppColor.primaryColor,
                        text: "dried fig",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.textColor1,
                        bgColor: Colors.transparent,
                        text: "Categories",
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(16),
                const FilterContainer(
                  textColor: AppColor.nextColor,
                  bgColor: Colors.transparent,
                  text: "See All",
                ),
                const VerticalSpeacing(14),
                Text(
                  "Default Sorting",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                const VerticalSpeacing(16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterContainer(
                        textColor: AppColor.whiteColor,
                        bgColor: AppColor.primaryColor,
                        text: "Polularty",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.textColor1,
                        bgColor: Colors.transparent,
                        text: "Best sellar",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.whiteColor,
                        bgColor: AppColor.primaryColor,
                        text: "Trending",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.textColor1,
                        bgColor: Colors.transparent,
                        text: "Categories",
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(16),
                const FilterContainer(
                  textColor: AppColor.nextColor,
                  bgColor: Colors.transparent,
                  text: "See All",
                ),
                const VerticalSpeacing(14),
                Text(
                  "Discount",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                const VerticalSpeacing(16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterContainer(
                        textColor: AppColor.whiteColor,
                        bgColor: AppColor.primaryColor,
                        text: "10% discount",
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(14),
                Text(
                  "Appliance Price",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                const VerticalSpeacing(16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterContainer(
                        textColor: AppColor.whiteColor,
                        bgColor: AppColor.primaryColor,
                        text: "high to low",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        textColor: AppColor.textColor1,
                        bgColor: Colors.transparent,
                        text: "low to high",
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(40),
                RoundedButton(title: "Apple Filter", onpress: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
