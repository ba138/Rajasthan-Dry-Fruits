// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

import '../../../res/components/colors.dart';
import '../../../res/components/vertical_spacing.dart';

class myOrderCard extends StatefulWidget {
  const myOrderCard({
    super.key,
    required this.ontap,
    required this.orderId,
    required this.status,
    required this.cartImg,
    required this.cartTitle,
    required this.quantity,
  });
  final Function ontap;
  final String orderId;
  final String status;
  final String cartImg;
  final String cartTitle;
  final String quantity;

  @override
  State<myOrderCard> createState() => _myOrderCardState();
}

class _myOrderCardState extends State<myOrderCard> {
  // String _truncateText(String text, int maxLength) {
  //   if (text.length <= maxLength) {
  //     return text; // Return the original text if it's within the limit
  //   } else {
  //     return '${text.substring(0, maxLength)}...'; // Truncate and add ellipsis
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114.0,
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                      text: 'order ID: ',
                      style: TextStyle(
                        color: AppColor.cardTxColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    TextSpan(
                      text: widget.orderId,
                      style: const TextStyle(
                        color: AppColor.textColor1,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ]),
                ),
                Text.rich(
                  TextSpan(children: [
                    const TextSpan(
                      text: 'Status: ',
                      style: TextStyle(
                        color: AppColor.cardTxColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    TextSpan(
                      text: widget.status,
                      style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            const VerticalSpeacing(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: NetworkImage(widget.cartImg),
                        fit: BoxFit.contain),
                  ),
                  // child: Image.asset('images/cartImg.png'),
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Shipment Charges: ₹${widget.cartTitle}\n',
                      style: const TextStyle(
                        color: AppColor.cardTxColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    const TextSpan(
                      text: 'Address: ',
                      style: TextStyle(
                        color: AppColor.cardTxColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    TextSpan(
                      text: widget.quantity,
                      style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ]),
                ),
                InkWell(
                  onTap: () {
                    widget.ontap();
                  },
                  child: Container(
                    height: 32,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppColor.primaryColor,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Center(
                        child: Text(
                          'Order Detail',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
