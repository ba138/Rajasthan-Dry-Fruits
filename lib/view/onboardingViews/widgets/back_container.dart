import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';

class BackContainer extends StatelessWidget {
  final Function()? onTap;

  const BackContainer({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 31,
        width: 35,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.whiteColor,
          ),
        ),
      ),
    );
  }
}
