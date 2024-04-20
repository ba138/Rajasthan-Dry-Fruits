import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:google_fonts/google_fonts.dart';

import '../onboardingViews/widgets/back_container.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

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
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const VerticalSpeacing(30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColor.appBarTxColor,
                        ),
                      ),
                      Text(
                        'Shop',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appBarTxColor,
                          ),
                        ),
                      ),
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
                              Icons.search,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const VerticalSpeacing(20.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10.0),
                      Text.rich(
                        textAlign: TextAlign.start,
                        TextSpan(
                          text: '23 Fund Items ',
                          style: TextStyle(
                              fontSize: 14.0,
                              color: AppColor.cardTxColor,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: 'Fresh Fruit Dry Fruit',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  GridView.count(
                    padding: const EdgeInsets.all(
                        10.0), // Add padding around the grid
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: (180 / 230),
                    mainAxisSpacing: 10.0, // Spacing between rows
                    crossAxisSpacing: 10.0, // Spacing between columns
                    children: List.generate(
                        10, (index) => const HomeCard(isdiscount: false)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
