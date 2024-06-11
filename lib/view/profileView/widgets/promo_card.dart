import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:intl/intl.dart';

class PromoCard extends StatelessWidget {
  final String discount;
  final String code;
  final String validFrom;
  final String validTo;
  final bool isActive;
  final VoidCallback onpress;

  const PromoCard({
    super.key,
    required this.discount,
    required this.code,
    required this.validFrom,
    required this.validTo,
    required this.isActive,
    required this.onpress,
  });

  String _formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('d-MM-yyyy');
    return formatter.format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Discount",
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        fontSize: 16, // Adjusted font size
                        fontWeight: FontWeight.w400,
                        color: AppColor.textColor1,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "$discount%",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        fontSize: 16, // Adjusted font size
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(10),
            Text(
              "Valid From:  ${_formatDate(validFrom)}",
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                  fontSize: 14, // Adjusted font size
                  fontWeight: FontWeight.w400,
                  color: AppColor.textColor1,
                ),
              ),
            ),
            Text(
              "Valid To:  ${_formatDate(validTo)}",
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                  fontSize: 14, // Adjusted font size
                  fontWeight: FontWeight.w400,
                  color: AppColor.textColor1,
                ),
              ),
            ),
            const VerticalSpeacing(10),
            Text(
              isActive ? "Status: Active" : "Status: Inactive",
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: TextStyle(
                  fontSize: 14, // Adjusted font size
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColor.primaryColor : Colors.red,
                ),
              ),
            ),
            const VerticalSpeacing(20),
            InkWell(
              onTap: onpress,
              child: Container(
                height: MediaQuery.of(context).size.height / 20,
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Copy Code",
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
