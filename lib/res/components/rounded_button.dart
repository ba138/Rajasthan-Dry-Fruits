import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  const RoundedButton({
    super.key,
    required this.title,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
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
            title,
            style: GoogleFonts.getFont(
              "Poppins",
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
