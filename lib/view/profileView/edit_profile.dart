import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/view/checkOut/widgets/Payment_field.dart';

import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

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
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              const VerticalSpeacing(30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    'Pofile',
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColor.appBarTxColor,
                      ),
                    ),
                  ),
                  Text(
                    'Edit Profile',
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalSpeacing(30.0),
              Container(
                height: MediaQuery.of(context).size.height / 1.2,
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
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const PaymentField(
                            maxLines: 2,
                            text: 'First Name',
                            hintText: 'Hiren user',
                          ),
                          const PaymentField(
                            maxLines: 2,
                            text: 'Last Name',
                            hintText: 'user',
                          ),
                          const PaymentField(
                            maxLines: 2,
                            text: 'Phone Number',
                            hintText: '+923554337111',
                          ),
                          const PaymentField(
                            maxLines: 2,
                            text: 'Gender',
                            hintText: 'Male',
                          ),
                          const PaymentField(
                            maxLines: 2,
                            text: 'Birthday',
                            hintText: '01/02/2003',
                          ),
                          const PaymentField(
                            maxLines: 2,
                            text: 'Password',
                            hintText: '******',
                          ),
                          const VerticalSpeacing(20.0),
                          RoundedButton(
                              title: 'Save',
                              onpress: () {
                                Navigator.pop(context);
                              }),
                          const VerticalSpeacing(20.0),
                        ],
                      ),
                    ],
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
