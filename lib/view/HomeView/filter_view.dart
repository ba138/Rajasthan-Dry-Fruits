import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/home_model.dart';
import 'package:rjfruits/repository/home_ui_repository.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/enums.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/HomeView/widgets/filter_container.dart';
import 'package:rjfruits/view_model/home_view_model.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _values = const RangeValues(5, 100000);
  String? catergioes;
  List<int> dicountPercantage = [
    10,
    20,
    30,
    40,
    50,
    60,
    70,
  ];
  int? percantage;
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
          padding: const EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpeacing(20),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
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
                ),
                const VerticalSpeacing(50),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
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
                ),
                const VerticalSpeacing(16),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  child: Consumer<HomeRepositoryProvider>(
                    builder: (context, homeRepo, child) {
                      if (homeRepo.homeRepository.productCategories.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              homeRepo.homeRepository.productCategories.length,
                          itemExtent: MediaQuery.of(context).size.width / 3.6,
                          itemBuilder: (BuildContext context, int index) {
                            Category category = homeRepo
                                .homeRepository.productCategories[index];

                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    // Toggle selection on tap
                                    catergioes = catergioes == category.name
                                        ? null
                                        : category.name;
                                  });
                                },
                                child: Container(
                                  height: 56,
                                  width: 220,
                                  decoration: BoxDecoration(
                                    color: catergioes == category.name
                                        ? AppColor
                                            .primaryColor // Change the color for the selected category
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: catergioes == category.name
                                          ? AppColor
                                              .primaryColor // Change the color for the selected category
                                          : AppColor.primaryColor,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: catergioes == category.name
                                            ? AppColor
                                                .whiteColor // Change the color for the selected category
                                            : AppColor.textColor1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                const VerticalSpeacing(30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    height: 75, // Adjust the height as needed
                    width: double.infinity,
                    color:
                        Colors.transparent, // Set the desired background color
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price Range: ₹${_values.start.toInt()} - ₹${_values.end.toInt()}',
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: AppColor.blackColor,
                          ),
                        ),
                        RangeSlider(
                          activeColor: AppColor.primaryColor,
                          inactiveColor: Colors.grey.shade300,
                          values: _values,
                          min: 5,
                          max: 100000,
                          divisions: 100,
                          labels: RangeLabels(
                            _values.start.round().toString(),
                            _values.end.round().toString(),
                          ),
                          onChanged: (values) {
                            setState(() {
                              _values = values;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpeacing(14),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
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
                ),
                const VerticalSpeacing(16),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dicountPercantage.length,
                    itemExtent: MediaQuery.of(context).size.width / 3.6,
                    itemBuilder: (BuildContext context, int index) {
                      final currentPercentage = dicountPercantage[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              // Toggle selection on tap
                              percantage = percantage == currentPercentage
                                  ? null
                                  : currentPercentage;
                            });
                          },
                          child: Container(
                            height: 56,
                            width: 220,
                            decoration: BoxDecoration(
                              color: percantage == currentPercentage
                                  ? AppColor.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: percantage == currentPercentage
                                    ? AppColor.primaryColor
                                    : AppColor.primaryColor,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$currentPercentage%', // Display current percentage
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: percantage == currentPercentage
                                      ? AppColor.whiteColor
                                      : AppColor.textColor1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const VerticalSpeacing(80),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: RoundedButton(
                      title: "Apple Filter",
                      onpress: () {
                        Provider.of<HomeRepositoryProvider>(context,
                                listen: false)
                            .filterProducts(
                          catergioes,
                          0,
                          _values.start,
                          _values.end,
                          percantage,
                        );
                        Provider.of<HomeUiSwithchRepository>(context,
                                listen: false)
                            .switchToType(UIType.FilterSection);
                        Navigator.pop(context);
                      }),
                ),
                const VerticalSpeacing(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
