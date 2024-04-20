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
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 30.0,
        width: 104.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: AppColor.primaryColor,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0)
                    .withOpacity(0.25), // Shadow color
                blurRadius: 8.1, // Blur radius
                spreadRadius: 0, // Spread radius
                offset: const Offset(0, 4), // Offset
              ),
            ]),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.getFont(
              "Roboto",
              color: AppColor.whiteColor,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
