// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/cart_model.dart';

import 'package:rjfruits/view/cart/widgets/cart_widget.dart';
import 'package:rjfruits/view/checkOut/check_out_view.dart';
import 'package:rjfruits/view_model/cart_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  gettingAllRequiredData() async {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    final userModel = await userPreferences.getUser();
    final token = userModel.key;
    Provider.of<CartRepositoryProvider>(context, listen: false)
        .getCachedProducts(context, token);
  }

  @override
  void initState() {
    gettingAllRequiredData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);

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
                      Center(
                        child: Text(
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
                      ),
                    ],
                  ),
                  Consumer<CartRepositoryProvider>(
                    builder: (context, cartRepoProvider, child) {
                      List<Product> cartProducts =
                          cartRepoProvider.cartRepositoryProvider.cartProducts;
                      List<CartItem> cartItems =
                          cartRepoProvider.cartRepositoryProvider.cartItems;

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.44,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final product = cartProducts[index];
                            final carPro = cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: CartWidget(
                                onpress: () async {
                                  final userModel =
                                      await userPreferences.getUser();
                                  final token = userModel.key;
                                  // Assuming you want to delete the product
                                  cartRepoProvider.deleteProduct(
                                      carPro.id, context, token);
                                  Provider.of<CartRepositoryProvider>(context,
                                          listen: false)
                                      .getCachedProducts(context, token);
                                },
                                productId: product.id.toString(),
                                name: product.title,
                                img: product.thumbnailImage,
                                price: product.price.toString(),
                                guantity: carPro.quantity,
                                individualPrice: product.price.toString(),
                                id: carPro.id,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const VerticalSpeacing(10.0),
                  Container(
                    height: 360,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 1),
                      color: const Color.fromRGBO(255, 255, 255, 0.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Coupon",
                                style: TextStyle(
                                  fontFamily: 'CenturyGothic',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /
                                          1.8,
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            hintText: "Enter coupon code"),
                                      )),
                                ],
                              ),
                              Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "Apply",
                                    style: GoogleFonts.getFont(
                                      "Poppins",
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpeacing(12.0),
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
                                    '₹${cartProvider.cartRepositoryProvider.totalPrice.toStringAsFixed(2)}',
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
                          Consumer<CartRepositoryProvider>(
                            builder: (context, cartProvider, _) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Discount Price",
                                    style: TextStyle(
                                      fontFamily: 'CenturyGothic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  Text(
                                    '₹${cartProvider.cartRepositoryProvider.discountPrice.toStringAsFixed(2)}',
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
                                    '₹${double.parse(cartProvider.calculateTotalPrice())}',
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
                          const VerticalSpeacing(20.0),
                          Consumer<CartRepositoryProvider>(
                            builder: (context, cartProvider, _) {
                              return SizedBox(
                                height: 55.0,
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CheckOutScreen(
                                        totalPrice: (cartProvider
                                                .cartRepositoryProvider
                                                .totalPrice)
                                            .toStringAsFixed(2),
                                      );
                                    }));
                                  },
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
                                                .withOpacity(0.25),
                                            blurRadius: 8.1,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]),
                                    child: Center(
                                      child: Text(
                                        "Proceed to CheckOut : ₹${double.parse(cartProvider.calculateTotalPrice()).toStringAsFixed(2)}",
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
