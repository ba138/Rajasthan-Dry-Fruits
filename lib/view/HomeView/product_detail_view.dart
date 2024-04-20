import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/HomeView/widgets/image_slider.dart';
import 'package:rjfruits/view/HomeView/widgets/weight_container.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
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
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                const ImageSlider(),
                const VerticalSpeacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dry figs",
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
                          "\$30",
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
                          "\$20",
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeightContainer(
                            conColor: AppColor.primaryColor,
                            gmColor: AppColor.textColor1,
                            numbColor: AppColor.whiteColor),
                        SizedBox(
                          width: 6,
                        ),
                        WeightContainer(
                            conColor: AppColor.whiteColor,
                            gmColor: AppColor.textColor1,
                            numbColor: AppColor.cardTxColor),
                        SizedBox(
                          width: 6,
                        ),
                        WeightContainer(
                          conColor: AppColor.whiteColor,
                          gmColor: AppColor.textColor1,
                          numbColor: AppColor.cardTxColor,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
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
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "2",
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
                        Container(
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
                  "Duis aute veniam veniam qui aliquip irure duis sint magna occaecat dolore nisi culpa do. Est nisi incididunt aliquip  commodo aliqua tempor.",
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
                    Navigator.pushNamed(context, RoutesName.totalReview);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.cartView,
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
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
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.checkOut,
                        );
                      },
                      child: Container(
                        height: 55.0,
                        width: 264.0,
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
