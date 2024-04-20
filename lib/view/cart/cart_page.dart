import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/view/cart/widgets/cart_widget.dart';

import '../../res/components/colors.dart';
import '../../res/components/rounded_button.dart';
import '../../res/components/vertical_spacing.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

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
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.west,
                          color: AppColor.appBarTxColor,
                        ),
                      ),
                      const SizedBox(width: 80.0),
                      Text(
                        'Cart Page',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appBarTxColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // CartWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.5, // Half the screen height
                    width: double.infinity,
                    child: SingleChildScrollView(
                      // Make the entire area scrollable
                      child: GridView.count(
                        padding: const EdgeInsets.all(5.0),
                        shrinkWrap: true, // Adjust based on content size
                        physics:
                            const ClampingScrollPhysics(), // Enable scrolling with clamping behavior
                        crossAxisCount: 1, // One card per row
                        childAspectRatio: (MediaQuery.of(context).size.width /
                            140), // Adjust width based on screen size
                        mainAxisSpacing: 16.0, // Spacing between rows
                        crossAxisSpacing: 0.0, // Spacing between columns
                        children: List.generate(
                            10,
                            (index) => Container(
                                height: 120.0, child: const CartWidget())),
                      ),
                    ),
                  ),
                  const VerticalSpeacing(10.0),
                  Container(
                    height: 357,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 1),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          VerticalSpeacing(10.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "SUMMARY",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpeacing(16.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SuB ToTAL",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              Text(
                                '\$1250',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpeacing(16.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "DISCOUNT",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              Text(
                                '\$250',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpeacing(16.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "DELIVERY CHARGE",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              Text(
                                'FREE',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const VerticalSpeacing(16.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "TOTAL",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              Text(
                                '\$1200',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpeacing(30.0),
                          SizedBox(
                            height: 55.0,
                            width: double.infinity,
                            child: RoundedButton(
                                title: 'continue to checkout-323\$',
                                onpress: () {}),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const VerticalSpeacing(60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
