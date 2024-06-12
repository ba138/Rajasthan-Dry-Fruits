import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';

class CompleteReviewCards extends StatelessWidget {
  const CompleteReviewCards(
      {super.key,
      required this.priductImage,
      required this.productTitle,
      required this.productRating,
      required this.productDescribtion});
  final String priductImage;
  final String productTitle;
  final int productRating;
  final String productDescribtion;

  @override
  Widget build(BuildContext context) {
    double intodouble = double.parse(productRating.toString());
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
                      image: DecorationImage(
                          image: NetworkImage(priductImage),
                          fit: BoxFit.contain),
                    ),
                    // child: Image.asset('images/cartImg.png'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    productTitle,
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
            RatingBar.builder(
              ignoreGestures: true,
              initialRating: intodouble,
              minRating: 1,
              unratedColor: AppColor.boxColor,
              allowHalfRating: true,
              glowColor: Colors.amber,
              itemCount: 5,
              itemSize: 20,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0),
              itemBuilder: (context, _) => const Icon(
                Icons.star_rate_rounded,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            Text(
              '',
              // productDescribtion,
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
