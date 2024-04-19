import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rjfruits/res/components/colors.dart';

class OnButton extends StatelessWidget {
  final double progress;
  final Function()? onTap;
  const OnButton({super.key, required this.progress, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.whiteColor,
      child: CircularPercentIndicator(
        radius: 45,
        percent: progress,
        progressColor: AppColor.primaryColor,
        backgroundColor: const Color(0xffCFD8DC),
        center: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffFBBD53).withOpacity(0.3),
                  blurRadius: 11,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
