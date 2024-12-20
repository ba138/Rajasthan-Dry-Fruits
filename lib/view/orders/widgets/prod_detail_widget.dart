// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../../res/components/colors.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    required this.img,
    required this.title,
    required this.price,
    required this.productPrice,
    required this.procustAverate,
    required this.productId,
    required this.id,
  });

  final String img;
  final String title;
  final String price;
  final String productPrice;
  final String procustAverate;
  final String productId;
  final String id;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
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
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: ListTile(
              leading: SizedBox(
                height: 80.0,
                width: 58.0,
                child: Image.network(img),
              ),
              title: Row(
                children: [
                  const SizedBox(width: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: '$title \n',
                          style: const TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColor.textColor1,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: price,
                              style: const TextStyle(
                                color: AppColor.cardTxColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productPrice,
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColor.textColor1,
                    ),
                  ),
                  Text(
                    procustAverate,
                    style: const TextStyle(
                      fontFamily: 'CenturyGothic',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.cardTxColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
