import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';

class FilterContainer extends StatelessWidget {
  final Color textColor;
  final Color bgColor;
  final String text;

  const FilterContainer({
    super.key,
    required this.textColor,
    required this.bgColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 116,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColor.primaryColor,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
