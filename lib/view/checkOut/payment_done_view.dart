import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';

class PaymentDoneScreen extends StatelessWidget {
  const PaymentDoneScreen({super.key});

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
                "Thanks for your order.Your order has placed successfully.to track the delivery ,my account>my order",
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
                  title: "Give Rating and Comment",
                  onpress: () {
                    Navigator.pushNamed(
                      context,
                      RoutesName.rating,
                    );
                  }),
              const VerticalSpeacing(
                14,
              ),
              Container(
                height: 56,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
