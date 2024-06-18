// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/product_detail_model.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/HomeView/widgets/image_slider.dart';
import 'package:rjfruits/view/checkOut/check_out_view.dart';
import 'package:rjfruits/view/total_review/total_review.dart';
import 'package:rjfruits/view_model/home_view_model.dart';
import 'package:rjfruits/view_model/product_detail_view_model.dart';
import 'package:rjfruits/view_model/save_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.detail});
  final ProductDetail detail;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? weight;
  String? weightPrice;
  String? weightid;
  String discountedPrice = "0";
  String intPrice = "";
  String intweight = "";
  int amount = 1;
  void increament() {}

  void decrement() {
    if (amount == 0) {
    } else {
      setState(() {
        amount--;
      });
    }
  }

  String parseHtmlString(String htmlString) {
    dom.Document document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }

  calclutePrice() {
    HomeRepositoryProvider homeRepoProvider =
        Provider.of<HomeRepositoryProvider>(context, listen: false);
    double originalPrice = double.parse(widget.detail.price);
    String per = widget.detail.discount.toString();
    double originalDiscount = double.parse(per);
    discountedPrice = homeRepoProvider.homeRepository
        .calculateDiscountedPrice(originalPrice, originalDiscount);
    intPrice = discountedPrice;
  }

  gettingAllTheData() async {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    final userModel =
        await userPreferences.getUser(); // Await the Future<UserModel> result
    final token = userModel.key;
    Provider.of<SaveProductRepositoryProvider>(context, listen: false)
        .getCachedProducts(context, token);
  }

  @override
  void initState() {
    super.initState();
    calclutePrice();
    gettingAllTheData();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);

    ProductRepositoryProvider proRepoProvider =
        Provider.of<ProductRepositoryProvider>(context, listen: false);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpeacing(20),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.west,
                        color: AppColor.textColor1,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                    ),
                    Text(
                      "Product Details",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                  ],
                ),
                ImageSlider(
                  image: widget.detail.thumbnailImage,
                  listImage: widget.detail.images,
                  id: widget.detail.id,
                  name: widget.detail.title,
                  discount: discountedPrice,
                ),
                const VerticalSpeacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.detail.title,
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 14,
                          width: 14,
                          decoration: const BoxDecoration(
                              color: AppColor.primaryColor,
                              shape: BoxShape.circle),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "In stock",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Available in",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "₹${widget.detail.priceWithTax.toString()}",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          "₹${widget.detail.discountedPriceWithTax.toString()}",
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const VerticalSpeacing(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 20,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.detail.productWeight.length,
                        itemExtent: MediaQuery.of(context).size.width / 5,
                        itemBuilder: (BuildContext context, int index) {
                          final productWeight =
                              widget.detail.productWeight[index];

                          return Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  weight =
                                      productWeight == productWeight.weight.name
                                          ? null
                                          : productWeight.weight.name;
                                  weightPrice = productWeight
                                      .discountedPriceWithTax
                                      .toString();
                                  intweight =
                                      productWeight.priceWithTax.toString();
                                  weightid = productWeight.id.toString();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: weight == productWeight.weight.name
                                      ? AppColor
                                          .primaryColor // Change the color for the selected category
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      productWeight.weight.name,
                                      style: GoogleFonts.getFont(
                                        "Poppins",
                                        textStyle: const TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.textColor1,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " ${productWeight.discountedPriceWithTax}₹ ",
                                      style: GoogleFonts.getFont(
                                        "Poppins",
                                        textStyle: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.w400,
                                          color: weight ==
                                                  productWeight.weight.name
                                              ? AppColor.whiteColor
                                              : AppColor.textColor1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (amount <= 1) {
                            } else {
                              setState(() {
                                if (weightPrice == null) {
                                  amount--;
                                  String priceWithoutDecimals =
                                      intPrice.split('.').first;
                                  int initPrice =
                                      int.parse(priceWithoutDecimals);

                                  discountedPrice =
                                      "${amount * initPrice}".toString();
                                } else {
                                  amount--;

                                  String priceWithoutDecimals =
                                      intweight.split('.').first;
                                  int initPrice =
                                      int.parse(priceWithoutDecimals);

                                  weightPrice =
                                      "${amount * initPrice}".toString();
                                }
                              });
                            }
                          },
                          child: Container(
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.iconColor),
                              color: AppColor.whiteColor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          amount.toString(),
                          style: GoogleFonts.getFont(
                            "Poppins",
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.textColor1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (weightPrice == null) {
                                amount++;

                                String priceWithoutDecimals =
                                    intPrice.split('.').first;
                                int initPrice = int.parse(priceWithoutDecimals);

                                discountedPrice =
                                    "${amount * initPrice}".toString();
                              } else {
                                amount++;

                                String priceWithoutDecimals =
                                    intweight.split('.').first;
                                int initPrice = int.parse(priceWithoutDecimals);

                                weightPrice =
                                    "${amount * initPrice}".toString();
                              }
                            });
                          },
                          child: Container(
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.iconColor),
                              color: AppColor.whiteColor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const VerticalSpeacing(18),
                Text(
                  "Product Details",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                const VerticalSpeacing(8),
                Text(
                  parseHtmlString(widget.detail.description),
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.iconColor,
                    ),
                  ),
                ),
                const VerticalSpeacing(10),
                const Divider(
                  color: AppColor.dividerColor,
                ),
                const VerticalSpeacing(12),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => TotalRatingScreen(
                          reviews: widget.detail.productReview,
                          averageReview: widget.detail.averageReview.toString(),
                          totalReviews: widget.detail.totalReviews.toString(),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review",
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textColor1,
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: AppColor.primaryColor,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const VerticalSpeacing(12),
                const Divider(
                  color: AppColor.dividerColor,
                ),
                const VerticalSpeacing(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        final userModel = await userPreferences
                            .getUser(); // Await the Future<UserModel> result
                        final token = userModel.key;
                        proRepoProvider.saveCartProducts(
                            widget.detail.id,
                            widget.detail.title,
                            weightid ?? "null",
                            discountedPrice,
                            amount,
                            token,
                            context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.primaryColor,
                          ),
                          color: const Color.fromRGBO(255, 255, 255,
                              0.2), // Background color with opacity
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.white.withOpacity(0.5), // Shadow color
                              blurRadius: 2, // Blur radius
                              spreadRadius: 0, // Spread radius
                              offset: const Offset(0, 0), // Offset
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            "images/ds.png",
                            height: 22,
                            width: 22,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final userModel = await userPreferences
                            .getUser(); // Await the Future<UserModel> result
                        final token = userModel.key;
                        proRepoProvider.saveCartProducts(
                            widget.detail.id,
                            widget.detail.title,
                            weightid ?? "null",
                            discountedPrice,
                            amount,
                            token,
                            context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CheckOutScreen(
                            totalPrice: widget.detail.price,
                          );
                        }));
                      },
                      child: Container(
                        height: 55.0,
                        width: MediaQuery.of(context).size.width / 1.7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
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
                          child: Text(
                            "Buy Now",
                            style: GoogleFonts.getFont(
                              "Poppins",
                              color: AppColor.whiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(
                  30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
