// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view/checkOut/check_out_view.dart';
import 'package:rjfruits/view/checkOut/widgets/Payment_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddresScreen extends StatefulWidget {
  const AddAddresScreen({super.key, required this.totalAmount});
  final String totalAmount;

  @override
  State<AddAddresScreen> createState() => _AddAddresScreenState();
}

class _AddAddresScreenState extends State<AddAddresScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _stateController = TextEditingController();

  final TextEditingController _zipCodeController = TextEditingController();
  // String _errorMessage = '';
  Future<void> _saveAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String fullName = _fullNameController.text;
    String phone = _phoneController.text;
    String address = _addressController.text;
    String city = _cityController.text;
    String state = _stateController.text;
    String zipCode = _zipCodeController.text;
    // Validate phone number
    if (phone.length < 10 || !phone.startsWith('9')) {
      setState(() {
        Utils.toastMessage('Invalid phone number');
      });
      return;
    }

    // Validate address
    if (address.length < 10) {
      setState(() {
        Utils.toastMessage('Address must be at least 10 characters long');
      });
      return;
    }

    // Validate zip code
    if (zipCode.length < 6) {
      setState(() {
        Utils.toastMessage('Zip code must be at least 6 characters long');
      });
      return;
    }

    Map<String, dynamic> addressMap = {
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': int.parse(zipCode),
    };

    List<Map<String, dynamic>> addresses =
        prefs.getStringList('addresses')?.map((jsonString) {
              return Map<String, dynamic>.from(jsonDecode(jsonString));
            }).toList() ??
            [];

    addresses.add(addressMap);
    List<String> encodedAddresses =
        addresses.map((address) => jsonEncode(address)).toList();
    await prefs.setStringList('addresses', encodedAddresses);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CheckOutScreen(
        totalPrice: widget.totalAmount,
      );
    }));
  }

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
                        PaymentField(
                          controller: _fullNameController,
                          maxLines: 2,
                          text: "Full Name",
                          hintText: "Hiren User",
                        ),
                        PaymentField(
                          controller: _phoneController,
                          maxLines: 2,
                          text: "Phone Number",
                          hintText: "+9123456789",
                        ),
                        PaymentField(
                          controller: _addressController,
                          maxLines: 2,
                          text: "Address",
                          hintText: "Delhi India",
                        ),
                        PaymentField(
                          controller: _cityController,
                          maxLines: 2,
                          text: "City",
                          hintText: "Delhi",
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PaymentField(
                                controller: _stateController,
                                maxLines: 2,
                                text: "State",
                                hintText: "India",
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: PaymentField(
                                controller: _zipCodeController,
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
                        RoundedButton(
                            title: "Save Address", onpress: _saveAddress),
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
