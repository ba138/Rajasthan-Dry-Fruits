import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';

class FbAuth extends StatelessWidget {
  const FbAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: AppColor.dividerColor.withOpacity(0.5), width: 3),
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
      child: Image.asset(
        "images/fb.png",
        height: 24,
        width: 24,
      ),
    );
  }
}
