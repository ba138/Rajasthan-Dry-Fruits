import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';

class CompleteReviewCards extends StatelessWidget {
  const CompleteReviewCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
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
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20,
          top: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const VerticalSpeacing(8),
            Container(
              height: 66,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.dividerColor),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
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
                  const SizedBox(
                    width: 12,
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
                ]),
              ),
            ),
            const VerticalSpeacing(8),
            const Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                ),
              ],
            ),
            Text(
              "good Nice",
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
