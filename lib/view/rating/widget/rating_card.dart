import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.primaryColor, width: 1),
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "dry fruit of mix",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                Text(
                  "purchased on 22 nov 2023",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.nextColor,
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        image: AssetImage('images/cartImg.png'),
                        fit: BoxFit.contain),
                  ),
                  // child: Image.asset('images/cartImg.png'),
                ),
                Text(
                  "Dryfruit of mix fresh of new\n And organic   ",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.rating,
                    );
                  },
                  child: Container(
                    height: 32,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppColor.primaryColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Center(
                        child: Text(
                          'Reviews',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
