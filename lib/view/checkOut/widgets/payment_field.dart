// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';

class PaymentField extends StatefulWidget {
  PaymentField({
    super.key,
    this.hintText,
    required int maxLines,
    required this.text,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.errorText,
  });

  final String text;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? Function(String?)? validator;
  String? errorText;
  @override
  State<PaymentField> createState() => _PaymentFieldState();
}

class _PaymentFieldState extends State<PaymentField> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: GoogleFonts.getFont(
              "Poppins",
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor.dashboardIconColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffEEEEEE),
            ),
            child: TextFormField(
              keyboardType: widget.keyboardType,
              obscureText: (widget.obscureText && hidden),
              style: const TextStyle(fontSize: 15),
              controller: widget.controller,
              decoration: InputDecoration(
                hintStyle: GoogleFonts.getFont(
                  "Roboto",
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColor.textColor1,
                  ),
                ),
                // prefixText:  widget.hintText,
                hintText: widget.hintText,
                filled: true,
                suffixIcon: widget.obscureText
                    ? GestureDetector(
                        onTap: () {
                          setState(() => hidden = !hidden);
                        },
                        child: Icon(
                          hidden ? Icons.visibility_off : Icons.visibility,
                          color: hidden ? null : AppColor.primaryColor,
                          size: 30,
                        ),
                      )
                    : null,
                fillColor: const Color(0xffEEEEEE),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: widget.errorText != null
                        ? Colors.red.withOpacity(1) // Set error border color
                        : Colors.transparent, // Default border color
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xfff1f1f1)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: widget.validator,
            ),
          ),
          if (widget.errorText != null)
            Text(
              widget.errorText.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }
}
