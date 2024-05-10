import 'package:flutter/material.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';

class AddressCheckOutWidget extends StatefulWidget {
  const AddressCheckOutWidget({
    super.key,
    required this.bgColor,
    required this.borderColor,
    required this.titleColor,
    required this.title,
    required this.phNo,
    required this.address,
    required this.onpress,
  });
  final Color bgColor;
  final Color borderColor;
  final Color titleColor;
  final String title;
  final String phNo;
  final String address;
  final Function onpress;

  @override
  State<AddressCheckOutWidget> createState() => _AddressCheckOutWidgetState();
}

class _AddressCheckOutWidgetState extends State<AddressCheckOutWidget> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.2),
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(width: 2, color: widget.borderColor),
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
        padding: const EdgeInsets.only(top: 15.0, left: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const VerticalSpeacing(7),
                InkWell(
                  onTap: () {
                    setState(() {
                      isPressed = !isPressed;
                      if (isPressed && widget.onpress != null) {
                        widget.onpress();
                      }
                    });
                  },
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primaryColor),
                      color: isPressed
                          ? AppColor.primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            // const MyCheckBox(),
            const SizedBox(width: 15.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: widget.title.length > 20
                        ? '${widget.title.substring(0, 20)}...\n'
                        : widget.title,
                    style: TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.titleColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n(${widget.phNo}\n',
                        style: const TextStyle(
                          color: AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                      TextSpan(
                        text: widget.address,
                        style: const TextStyle(
                          color: AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
