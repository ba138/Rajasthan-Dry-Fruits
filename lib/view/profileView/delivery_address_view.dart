import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/checkOut/widgets/address_container.dart';
import 'package:rjfruits/view/profileView/add_address_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        backgroundColor: Colors.transparent,
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

      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _getCachedAddresses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> addresses =
                    snapshot.data as List<Map<String, dynamic>>;
                return Column(
                  children: addresses.map((address) {
                    return Column(
                      children: [
                        AddressCheckOutWidget(
                          bgColor: AppColor.whiteColor,
                          borderColor: AppColor.primaryColor,
                          titleColor: AppColor.primaryColor,
                          title: address['fullName'] ?? '',
                          phNo: address['phone'] ?? '',
                          address:
                              '${address['address'] ?? ''}, ${address['city'] ?? ''} ${address['state'] ?? ''} ${address['zipCode'] ?? ''}',
                          onpress: () async {
                            // Store the selected address in shared preferences
                          },
                        ),
                        const VerticalSpeacing(20),
                      ],
                    );
                  }).toList(),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getCachedAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? encodedAddresses = prefs.getStringList('addresses');
    if (encodedAddresses != null) {
      return encodedAddresses.map((jsonString) {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      }).toList();
    } else {
      return [];
    }
  }
}
