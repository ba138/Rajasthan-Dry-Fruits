import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/HomeView/widgets/homeCard.dart';
import 'package:google_fonts/google_fonts.dart';

class DisCountProd extends StatelessWidget {
  const DisCountProd({super.key});

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
                      const SizedBox(width: 80.0),
                      Text(
                        'Discount Products',
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
                  const VerticalSpeacing(10.0),
                  GridView.count(
                    padding: const EdgeInsets.all(
                        0.0), // Add padding around the grid
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: (180 / 230),
                    mainAxisSpacing: 10.0, // Spacing between rows
                    crossAxisSpacing: 10.0, // Spacing between columns
                    children: List.generate(
                        10, (index) => const HomeCard(isdiscount: true)),
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
