// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';
import '../../../res/components/vertical_spacing.dart';

// ignore: camel_case_types
class myOrderCard extends StatefulWidget {
  const myOrderCard({
    super.key,
    required this.ontap,
  });
  final Function ontap;

  @override
  State<myOrderCard> createState() => _myOrderCardState();
}

class _myOrderCardState extends State<myOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'order ID: ',
                      style: TextStyle(
                        color: AppColor.cardTxColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    TextSpan(
                      text: '223456422',
                      style: TextStyle(
                        color: AppColor.textColor1,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                  ]),
                ),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Status: ',
                      style: TextStyle(
                        color: AppColor.cardTxColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    TextSpan(
                      text: 'Completed',
                      style: TextStyle(
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
                    image: const DecorationImage(
                        image: AssetImage('images/cartImg.png'),
                        fit: BoxFit.contain),
                  ),
                  // child: Image.asset('images/cartImg.png'),
                ),
                const Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: 'Dryfruit of mix fresh of new\n',
                      style: TextStyle(
                        color: AppColor.cardTxColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    TextSpan(
                      text: 'And organic   ',
                      style: TextStyle(
                        color: AppColor.cardTxColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    TextSpan(
                      text: 'Qty:1',
                      style: TextStyle(
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
