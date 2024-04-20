import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/checkOut/widgets/Payment_field.dart';
import 'package:rjfruits/view/checkOut/widgets/address_container.dart';
import 'package:rjfruits/view/checkOut/widgets/payment_container.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool isOnline = false;
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                const VerticalSpeacing(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select delivery address",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                    Text(
                      "Add New",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(12),
                const AddressCheckOutWidget(
                    bgColor: AppColor.whiteColor,
                    borderColor: AppColor.primaryColor,
                    titleColor: AppColor.primaryColor,
                    title: "Home Address",
                    phNo: "(309) 071-9396-939",
                    address: "Delhi  India"),
                const VerticalSpeacing(20),
                const AddressCheckOutWidget(
                    bgColor: AppColor.whiteColor,
                    borderColor: AppColor.primaryColor,
                    titleColor: AppColor.textColor1,
                    title: "Office Address",
                    phNo: "(309) 071-9396-939",
                    address: "Delhi  India"),
                const VerticalSpeacing(24),
                Text(
                  "Select payment method",
                  style: GoogleFonts.getFont(
                    "Poppins",
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textColor1,
                    ),
                  ),
                ),
                const VerticalSpeacing(16),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      PaymentContainer(
                        bgColor: AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                        name: "Stripe",
                        img: "images/stripe.png",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      PaymentContainer(
                        bgColor: AppColor.whiteColor,
                        textColor: AppColor.textColor1,
                        name: "Paypal",
                        img: "images/paypal.png",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      PaymentContainer(
                        bgColor: AppColor.whiteColor,
                        textColor: AppColor.textColor1,
                        name: "Cash On Delivery",
                        img: "images/handcash.png",
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                const VerticalSpeacing(24),
                const PaymentField(
                  maxLines: 2,
                  text: "Card Name",
                  hintText: "Hiren User",
                ),
                const PaymentField(
                  maxLines: 2,
                  text: "Card Number",
                  hintText: "123 456 ********",
                ),
                const Row(
                  children: [
                    Expanded(
                      child: PaymentField(
                        maxLines: 2,
                        text: "Expiration Date",
                        hintText: "05/09/2021",
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: PaymentField(
                        maxLines: 2,
                        text: "Csv",
                        hintText: "565",
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(
                  14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Remeber My Card Details",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textColor1,
                        ),
                      ),
                    ),
                    Container(
                      height: 26,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isOnline = false;
                              });
                            },
                            child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: isOnline ? null : AppColor.whiteColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                isOnline = true;
                              });
                            },
                            child: Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                color: isOnline ? AppColor.whiteColor : null,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const VerticalSpeacing(50),
                RoundedButton(
                  title: "323\$pay",
                  onpress: () {},
                ),
                const VerticalSpeacing(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
