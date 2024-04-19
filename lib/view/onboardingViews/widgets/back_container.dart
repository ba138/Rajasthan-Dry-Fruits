import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';

class BackContainer extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final Color iconColor;

  const BackContainer(
      {super.key, this.onTap, required this.color, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 31,
        width: 35,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
