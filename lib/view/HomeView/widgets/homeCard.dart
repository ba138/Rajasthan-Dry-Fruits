// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view_model/home_view_model.dart';

import '../../../res/components/cart_button.dart';
import '../../../res/components/colors.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.isdiscount,
    this.image,
    this.price,
    this.discount,
    this.title,
    this.proId,
  });
  final bool isdiscount;
  final String? image;
  final String? price;
  final String? discount;
  final String? title;
  final String? proId;
  @override
  Widget build(BuildContext context) {
    HomeRepositoryProvider homeRepoProvider =
        Provider.of<HomeRepositoryProvider>(context, listen: false);
    double originalPrice = double.parse(price ?? "50");
    double originalDiscount = double.parse(discount ?? "20");
    String discountedPrice = homeRepoProvider.homeRepository
        .calculateDiscountedPrice(originalPrice, originalDiscount);
    String formattedPrice = '\$$discountedPrice';
    final dotIndex = formattedPrice.indexOf('.');
    if (dotIndex != -1) {
      // Decimal point found, remove it and everything after
      formattedPrice = formattedPrice.substring(0, dotIndex);
    }
    String totalPrice = '\$$originalPrice';
    final dotNdex = totalPrice.indexOf('.');
    if (dotNdex != -1) {
      // Decimal point found, remove it and everything after
      totalPrice = totalPrice.substring(0, dotIndex);
    }
    String truncatedTitle = title == null ? 'Dried Figs' : title!;
    if (truncatedTitle.length > 8) {
      truncatedTitle = '${truncatedTitle.substring(0, 8)}...';
    }
    return Container(
      height: 230,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.primaryColor, width: 2),
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isdiscount
                    ? Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AppColor.cartDiscountColor,
                        ),
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              text: discount == null ? '30%\n' : '$discount%\n',
                              style: const TextStyle(
                                  fontSize: 9.0,
                                  color: AppColor.whiteColor,
                                  fontWeight: FontWeight.w600),
                              children: const [
                                TextSpan(
                                  text: 'Off',
                                  style: TextStyle(
                                      fontSize: 9.0,
                                      color: AppColor.whiteColor,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  height: 24,
                  width: 74,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColor.primaryColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0,
                            0.25), // Shadow color (black with 25% opacity)
                        blurRadius: 8.1, // Blur radius
                        offset: Offset(0, 4), // Offset (Y direction)
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: AppColor.whiteColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: AppColor.iconColor,
                            ),
                          ),
                        ),
                        const Text(
                          '2KG',
                          style: TextStyle(color: AppColor.whiteColor),
                        ),
                        Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: AppColor.whiteColor,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              size: 16,
                              color: AppColor.iconColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            image == null
                ? Container(
                    height: 85,
                    width: 145,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/cartImg.png'),
                      ),
                    ),
                  )
                : Container(
                    height: 85,
                    width: 145,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(image!)),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  truncatedTitle,
                  style: GoogleFonts.getFont(
                    "Roboto",
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColor.cardTxColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColor.primaryColor,
                      size: 20,
                    ),
                    Text(
                      '4.5',
                      style: GoogleFonts.getFont(
                        "Roboto",
                        textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  price == null ? '\$50 ' : totalPrice,
                  style: GoogleFonts.getFont(
                    "Roboto",
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColor.cardTxColor,
                    ),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(formattedPrice,
                    style: GoogleFonts.getFont(
                      "Roboto",
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textColor1,
                      ),
                    ),
                    overflow: TextOverflow.fade),
              ],
            ),
            const VerticalSpeacing(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 37,
                  width: 37,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: AppColor.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.25), // Shadow color
                          blurRadius: 8.1, // Blur radius
                          spreadRadius: 0, // Spread radius
                          offset: const Offset(0, 4), // Offset
                        ),
                      ]),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('images/cart.png'),
                    ),
                  ),
                ),
                CartButton(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.productDetail);
                    },
                    text: 'View'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
