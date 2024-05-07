import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
  RangeValues _values = const RangeValues(5, 1000);

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
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SingleChildScrollView(
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
                      ],
                    ),
                  ),
                ),
                const VerticalSpeacing(30),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Row(
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
                        ),
                      )
                    ],
                  ),
                ),
                const VerticalSpeacing(24),
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
                          'Price Range: \$${_values.start.toInt()} - \$${_values.end.toInt()}',
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
                          max: 1000,
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
                ),
                const VerticalSpeacing(16),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: SingleChildScrollView(
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
                ),
                const VerticalSpeacing(14),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
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
                ),
                const VerticalSpeacing(16),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: SingleChildScrollView(
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
                ),
                const VerticalSpeacing(16),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  child: FilterContainer(
                    textColor: AppColor.nextColor,
                    bgColor: Colors.transparent,
                    text: "See All",
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
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  child: SingleChildScrollView(
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
                ),
                const VerticalSpeacing(14),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Text(
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
                ),
                const VerticalSpeacing(16),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  child: SingleChildScrollView(
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
                ),
                const VerticalSpeacing(40),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: RoundedButton(
                      title: "Apple Filter",
                      onpress: () {
                        Provider.of<HomeRepositoryProvider>(context,
                                listen: false)
                            .filterProducts(
                          "catergioes",
                          0,
                          _values.start,
                          _values.end,
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
