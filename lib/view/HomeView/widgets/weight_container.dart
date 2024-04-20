import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';

class WeightContainer extends StatefulWidget {
  const WeightContainer(
      {super.key,
      required this.conColor,
      required this.gmColor,
      required this.numbColor});
  final Color conColor;
  final Color gmColor;
  final Color numbColor;

  @override
  State<WeightContainer> createState() => _WeightContainerState();
}

class _WeightContainerState extends State<WeightContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: widget.conColor,
        border: Border.all(
          color: AppColor.primaryColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "250GM",
            style: GoogleFonts.getFont(
              "Poppins",
              textStyle: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: widget.gmColor,
              ),
            ),
          ),
          Text(
            "12455\$",
            style: GoogleFonts.getFont(
              "Poppins",
              textStyle: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w400,
                color: widget.numbColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
