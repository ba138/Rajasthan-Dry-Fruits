// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCart extends StatefulWidget {
  const CategoryCart(
      {super.key,
      required this.bgColor,
      required this.textColor,
      required this.onTap,
      required this.text});

  final Color bgColor;
  final Color textColor;
  final String text;
  final Function onTap;

  @override
  _CategoryCartState createState() => _CategoryCartState();
}

class _CategoryCartState extends State<CategoryCart> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: 44,
        width: 75,
        decoration: BoxDecoration(
            color: widget.bgColor, borderRadius: BorderRadius.circular(30.0)),
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.getFont(
              "Poppins",
              color: widget.textColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
