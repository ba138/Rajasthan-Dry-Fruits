// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/checkOut/widgets/invoice_screen.dart';

import '../../model/checkout_return_model.dart';

class PaymentDoneScreen extends StatefulWidget {
  const PaymentDoneScreen({
    super.key,
    required this.checkoutModel,
  });
  final CheckoutreturnModel checkoutModel;

  @override
  State<PaymentDoneScreen> createState() => _PaymentDoneScreenState();
}

class _PaymentDoneScreenState extends State<PaymentDoneScreen> {
  @override
  Widget build(BuildContext context) {
    // debugPrint('Total Amount: ${widget.totalAmount}');
    // debugPrint('Data : ${widget.sendData}');

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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/done.png",
                height: 282,
                width: 316,
              ),
              const VerticalSpeacing(40),
              Text(
                "Order Placed Successfully ",
                style: GoogleFonts.getFont(
                  "Poppins",
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textColor1,
                  ),
                ),
              ),
              const VerticalSpeacing(12),
              Text(
                "Thanks for your order. Your order has placed successfully. To track the delivery, go to My Account > My Order.",
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  "Poppins",
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColor.iconColor,
                  ),
                ),
              ),
              const VerticalSpeacing(60),
              RoundedButton(
                title: "Back to home",
                onpress: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutesName.dashboard, (route) => false);
                },
              ),
              const VerticalSpeacing(14),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.myorders);
                },
                child: Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                  child: Center(
                    child: Text(
                      "Track Order",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const VerticalSpeacing(14),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => InvoiceScreen(
                        checkoutdetail: widget.checkoutModel,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                  child: Center(
                    child: Text(
                      "Invoice",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
