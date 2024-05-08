import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/cart/widgets/cart_widget.dart';
import 'package:rjfruits/view_model/cart_view_model.dart';

import '../../res/components/colors.dart';
import '../../res/components/rounded_button.dart';
import '../../res/components/vertical_spacing.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartRepositoryProvider>(context, listen: false)
        .getCachedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.west,
                          color: AppColor.appBarTxColor,
                        ),
                      ),
                      const SizedBox(width: 80.0),
                      Text(
                        'Cart Page',
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appBarTxColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // CartWidget(),
                  Consumer<CartRepositoryProvider>(
                    builder: (context, cartRepoProvider, child) {
                      List<Map<String, dynamic>> cartItems =
                          cartRepoProvider.cartRepositoryProvider.cartList;

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            if (index < cartItems.length) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: CartWidget(
                                  onpress: () {
                                    Provider.of<CartRepositoryProvider>(context,
                                            listen: false)
                                        .deleteProduct(
                                            cartItems[index]['productId']);
                                    Provider.of<CartRepositoryProvider>(context,
                                            listen: false)
                                        .getCachedProducts();
                                  },
                                  id: cartItems[index]['productId'],
                                  name: cartItems[index]['name'],
                                  img: cartItems[index]['image'],
                                  price: cartItems[index]['price'],
                                  guantity: cartItems[index]['quantity'],
                                  individualPrice: cartItems[index]
                                          ['individualTotal'] ??
                                      cartItems[index]['price'],
                                ),
                              );
                            } else {
                              return const SizedBox.shrink(
                                child: Center(
                                  child: Text("No Products to Show"),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                  const VerticalSpeacing(10.0),
                  Container(
                    height: 357,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 1),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const VerticalSpeacing(30.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "SUMMARY",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpeacing(16.0),
                          Consumer<CartRepositoryProvider>(
                            builder: (context, cartProvider, _) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total Price",
                                    style: TextStyle(
                                      fontFamily: 'CenturyGothic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  Text(
                                    '\$${cartProvider.cartRepositoryProvider.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontFamily: 'CenturyGothic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const VerticalSpeacing(16.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "DELIVERY CHARGE",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                              Text(
                                'FREE',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          const VerticalSpeacing(16.0),
                          Consumer<CartRepositoryProvider>(
                            builder: (context, cartProvider, _) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "TOTAL",
                                    style: TextStyle(
                                      fontFamily: 'CenturyGothic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  Text(
                                    '\$${cartProvider.cartRepositoryProvider.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontFamily: 'CenturyGothic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const VerticalSpeacing(30.0),
                          Consumer<CartRepositoryProvider>(
                            builder: (context, cartProvider, _) {
                              return SizedBox(
                                height: 55.0,
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 56,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: AppColor.primaryColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 0, 0, 0)
                                                .withOpacity(
                                                    0.25), // Shadow color
                                            blurRadius: 8.1, // Blur radius
                                            spreadRadius: 0, // Spread radius
                                            offset:
                                                const Offset(0, 4), // Offset
                                          ),
                                        ]),
                                    child: Center(
                                      child: Text(
                                        "Proceed to CheckOut : \$${cartProvider.cartRepositoryProvider.totalPrice.toStringAsFixed(2)}",
                                        style: GoogleFonts.getFont(
                                          "Poppins",
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const VerticalSpeacing(60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
