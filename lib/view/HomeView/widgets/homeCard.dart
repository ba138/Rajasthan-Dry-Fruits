import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/product_detail_model.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/res/const/response_handler.dart';
import 'package:rjfruits/view_model/product_detail_view_model.dart';
import 'package:rjfruits/view_model/save_view_model.dart';
import 'package:rjfruits/view_model/user_view_model.dart';
import 'package:http/http.dart' as http;
import '../../../res/components/cart_button.dart';
import '../../../res/components/colors.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({
    super.key,
    required this.isdiscount,
    this.image,
    this.price,
    this.discount,
    this.title,
    this.proId,
    this.weight,
    required this.averageReview,
    this.disPercantage,
  });
  final bool isdiscount;
  final String? image;
  final String? price;
  final String? discount;
  final String? title;
  final String? proId;
  final List<dynamic>? weight;
  final String averageReview;
  final String? disPercantage;

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  int amount = 1;

  void increment() {
    setState(() {
      amount++;
    });
  }

  void decrement() {
    if (amount > 0) {
      setState(() {
        amount--;
      });
    }
  }

  bool isLike = false;

  void checkTheProduct() async {
    SaveProductRepositoryProvider homeRepoProvider =
        Provider.of<SaveProductRepositoryProvider>(context, listen: false);
    bool isInCart = false;

    if (widget.proId != null) {
      isInCart = await homeRepoProvider.isProductInCart(widget.proId!);
    }

    if (isInCart) {
      setState(() {
        isLike = true;
      });
    }
  }

  ProductDetail? productDetail;

  Future<void> fetchProductDetails(BuildContext context, String id) async {
    final String url = 'http://103.117.180.187/api/product/$id/';
    final Map<String, String> headers = {
      'accept': 'application/json',
      'X-CSRFToken':
          'ggUEuomf5SLMCluLyTUTe1TcfnGAZLVoViIVEUEUNtjhGnRumUUHsEMQ3hM8ocJE',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        productDetail = ProductDetail.fromJson(jsonDecode(response.body));
        debugPrint("Product details: $productDetail");
      } else {
        throw Exception('Failed to load product detail');
      }
    } catch (e) {
      debugPrint("Error: $e");
      handleApiError(e, context);
    }
  }

  @override
  void initState() {
    checkTheProduct();
    fetchProductDetails(context, widget.proId!);
    super.initState();
  }

  String formatPrice(String price) {
    final dotIndex = price.indexOf('.');
    if (dotIndex != -1) {
      return price.substring(0, dotIndex);
    }
    return price;
  }

  String truncateTitle(String? title, int charLimit) {
    if (title == null) return 'Dried Figs';
    if (title.length > charLimit) {
      return '${title.substring(0, charLimit)}...';
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    ProductRepositoryProvider proRepoProvider =
        Provider.of<ProductRepositoryProvider>(context, listen: false);

    String formattedPrice = widget.discount ?? '0';
    formattedPrice = formatPrice(formattedPrice);

    String totalPrice = '${widget.price ?? '0'}';
    totalPrice = formatPrice(totalPrice);

    String truncatedTitle = truncateTitle(widget.title, 8);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColor.primaryColor, width: 2),
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
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isdiscount
                    ? Container(
                        height: MediaQuery.of(context).size.height / 26,
                        width: MediaQuery.of(context).size.width / 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.cartDiscountColor,
                        ),
                        child: Center(
                          child: Text.rich(
                            TextSpan(


                              text: '${widget.disPercantage}%\n',

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
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 8.1,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: decrement,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width / 18,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
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
                        ),
                        Text(
                          '${amount.toString()}KG',
                          style: const TextStyle(color: AppColor.whiteColor),
                        ),
                        InkWell(
                          onTap: increment,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width / 18,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpeacing(8),
            widget.image == null
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
                    height: MediaQuery.of(context).size.width / 4.8,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      image:
                          DecorationImage(image: NetworkImage(widget.image!)),
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColor.cardTxColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColor.primaryColor,
                      size: 16,
                    ),
                    Text(
                      widget.averageReview,
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
                Visibility(
                  visible: widget.isdiscount,
                  child: Text(
                    widget.price == null
                        ? '₹50 '
                        : '₹${double.parse(totalPrice)}',
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
                ),
                Text("₹${widget.discount!}",
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
                InkWell(
                  onTap: () async {
                    debugPrint("Product ID: ${widget.proId}");

                    final userModel = await userPreferences.getUser();
                    final token = userModel.key;
                    debugPrint("Product ID: ${widget.proId}");
                    proRepoProvider.saveCartProducts(
                      widget.proId!,
                      widget.title!,
                      productDetail!.productWeight.first.id.toString(),
                      formattedPrice,
                      amount,
                      token,
                      context,
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 21,
                    width: MediaQuery.of(context).size.width / 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.25),
                            blurRadius: 8.1,
                            spreadRadius: 0,
                            offset: const Offset(0, 4),
                          ),
                        ]),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('images/cart.png'),
                      ),
                    ),
                  ),
                ),
                CartButton(
                  onTap: () {
                    debugPrint("Product ID: ${widget.proId}");
                    final productDetailsProvider =
                        Provider.of<ProductRepositoryProvider>(context,
                            listen: false);
                    productDetailsProvider.fetchProductDetails(
                      context,
                      widget.proId!,
                    );
                  },
                  text: 'View',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
