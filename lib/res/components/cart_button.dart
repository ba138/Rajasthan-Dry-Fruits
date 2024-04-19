import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    required this.onTap,
    required this.text,
  });
  final Function onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27.0,
      width: 88.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: AppColor.primaryColor,
      ),
      child: Center(
        child: Text(
          'View All',
          style: GoogleFonts.getFont(
            "Roboto",
            color: AppColor.whiteColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
