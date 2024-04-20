import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/checkOut/widgets/Payment_field.dart';

class AddAddresScreen extends StatelessWidget {
  const AddAddresScreen({super.key});

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
          child: SingleChildScrollView(
            child: Column(
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
                      "New Address",
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
                Container(
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
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        const VerticalSpeacing(30),
                        const PaymentField(
                          maxLines: 2,
                          text: "Full Name",
                          hintText: "Hiren User",
                        ),
                        const PaymentField(
                          maxLines: 2,
                          text: "Phone Number",
                          hintText: "+9123456789",
                        ),
                        const PaymentField(
                          maxLines: 2,
                          text: "Address Link 1",
                          hintText: "Delhi India",
                        ),
                        const PaymentField(
                          maxLines: 2,
                          text: "Address Link 2",
                          hintText: "Delhi India",
                        ),
                        const PaymentField(
                          maxLines: 2,
                          text: "City",
                          hintText: "Delhi",
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: PaymentField(
                                maxLines: 2,
                                text: "State",
                                hintText: "India",
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: PaymentField(
                                maxLines: 2,
                                text: "Zip Code",
                                hintText: "1555",
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpeacing(30),
                        Row(
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "Make Default Default Shipping Address",
                              style: GoogleFonts.getFont(
                                "Poppins",
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textColor1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpeacing(38),
                        RoundedButton(title: "Save Address", onpress: () {}),
                        const VerticalSpeacing(38),
                      ],
                    ),
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
