import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/checkOut/widgets/address_container.dart';

class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.west,
            color: AppColor.textColor1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Delivery Address",
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColor.textColor1,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
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
              children: [
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.addAddress,
                        );
                      },
                      child: Text(
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
                    ),
                  ],
                ),
                const VerticalSpeacing(12),
                AddressCheckOutWidget(
                  bgColor: AppColor.whiteColor,
                  borderColor: AppColor.primaryColor,
                  titleColor: AppColor.primaryColor,
                  title: "Home Address",
                  phNo: "(309) 071-9396-939",
                  address: "Delhi  India",
                  onpress: () {},
                ),
                const VerticalSpeacing(20),
                AddressCheckOutWidget(
                  bgColor: AppColor.whiteColor,
                  borderColor: AppColor.primaryColor,
                  titleColor: AppColor.textColor1,
                  title: "Office Address",
                  phNo: "(309) 071-9396-939",
                  address: "Delhi  India",
                  onpress: () {},
                ),
                const VerticalSpeacing(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
