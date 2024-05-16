// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view_model/cart_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';
import '../../../res/components/colors.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({
    super.key,
    required this.name,
    required this.price,
    required this.productId,
    required this.guantity,
    required this.img,
    required this.onpress,
    this.individualPrice,
    required this.id,
  });
  final String name;
  final String price;
  final String productId;
  final int guantity;
  final String img;
  final VoidCallback onpress;
  final String? individualPrice;
  final int id;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);

    return Container(
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
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: ListTile(
            leading: Container(
              height: 70.0,
              width: 75.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1, color: AppColor.primaryColor),
                image: DecorationImage(
                    image: NetworkImage(
                      widget.img,
                    ),
                    fit: BoxFit.contain),
              ),
              // child: Image.asset('images/cartImg.png'),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.start,
                      TextSpan(
                        text: '\n${widget.name}\n',
                        style: const TextStyle(
                          fontFamily: 'CenturyGothic',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColor.cardTxColor,
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                            text: '⭐ 4.5',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpeacing(10.0),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            final userModel = await userPreferences
                                .getUser(); // Await the Future<UserModel> result
                            final token = userModel.key;
                            Provider.of<CartRepositoryProvider>(context,
                                    listen: false)
                                .removeQuantity(widget.id, widget.productId,
                                    widget.guantity, context, token);
                            Provider.of<CartRepositoryProvider>(context,
                                    listen: false)
                                .getCachedProducts(context, token);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.textColor1,
                              ),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.guantity.toString()}KG',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textColor1,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () async {
                            final userModel = await userPreferences
                                .getUser(); // Await the Future<UserModel> result
                            final token = userModel.key;
                            Provider.of<CartRepositoryProvider>(context,
                                    listen: false)
                                .addQuantity(widget.id, widget.productId,
                                    widget.guantity, context, token);
                            Provider.of<CartRepositoryProvider>(context,
                                    listen: false)
                                .getCachedProducts(context, token);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.textColor1,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: widget.onpress,
                  child: const Icon(
                    Icons.delete_outline,
                    color: AppColor.appBarTxColor,
                    size: 24,
                  ),
                ),
                Text(
                  widget.individualPrice == null
                      ? '₹${widget.price}'
                      : double.parse(widget.individualPrice!)
                          .toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColor.textColor1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
