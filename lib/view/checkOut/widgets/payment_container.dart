import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';

class PaymentContainer extends StatelessWidget {
  final Color bgColor;
  final Color textColor;
  final String img;
  final String name;
  const PaymentContainer(
      {super.key,
      required this.bgColor,
      required this.textColor,
      required this.img,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          6,
        ),
        color: bgColor,
        border: Border.all(
          color: AppColor.primaryColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            height: 30,
            width: 40,
          ),
          Text(
            name,
            style: GoogleFonts.getFont(
              "Poppins",
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
