import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/model/checkout_return_model.dart';
import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class CheckoutDetailView extends StatelessWidget {
  const CheckoutDetailView({super.key, required this.checkoutModel});
  final CheckoutreturnModel checkoutModel;

  @override
  Widget build(BuildContext context) {
    debugPrint('Checkout Details: ${checkoutModel.data.fullName}');
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
        image: DecorationImage(
          image: AssetImage("images/bgimg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalSpeacing(50.0),
              Container(
                width: double.infinity,
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const VerticalSpeacing(30.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Payment:",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpeacing(16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            '₹${checkoutModel.data.total}',
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpeacing(12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Shipping Charges",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            '₹${checkoutModel.data.shippingCharges}',
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const VerticalSpeacing(10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tax (sgst + cgst)",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            '₹${checkoutModel.data.tax}',
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const VerticalSpeacing(10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sub Total",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            '₹${checkoutModel.data.subTotal}',
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpeacing(46.0),
                      Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
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
                            "Pay Now",
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
                      )
                    ],
                  ),
                ),
              ),
            ]),
      ),
    ));
  }
}
