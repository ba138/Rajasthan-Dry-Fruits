// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
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

  final TextEditingController _zipCodeController = TextEditingController();
  // String? _errorMessage;
  String? _errorphone;
  String? _errorAddress;
  String? _errorZipcode;
  bool phoneValid = false;
  bool addressValid = false;
  bool zipValid = false;
  String _btn2SelectedVal = "andhra_pradesh";

  static const menuItems = <String>[
    'andhra_pradesh',
    'arunachal_pradesh',
    "assam",
    'bihar',
    "chhattisgarh",
    "goa",
    "gujarat",
    "haryana",
    "himachal_pradesh",
    "jharkhand",
    "karnataka",
    "kerala",
    "madhya_pradesh",
    "maharashtra",
    "manipur",
    "meghalaya",
    "mizoram",
    "nagaland",
    "odisha",
    "punjab",
    "rajasthan",
    "sikkim",
    "tamil_nadu",
    "telangana",
    "tripura",
    "uttar_pradesh",
    "uttarakhand",
    "west_bengal",
    "andaman_and_nicobar_islands",
    "chandigarh",
    "dadra_and_nagar_haveli_and_daman_and_diu",
    "lakshadweep",
    "delhi",
    "puducherry",
    "ladakh",
    "jammu_and_kashmir ",
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  void validateFields() {
    // Validate phone number
    if (_phoneController.text.length != 10 ||
        !['9', '8', '7', '6'].contains(_phoneController.text[0])) {
      setState(() {
        _errorphone = 'Use an Indian phone number';
        phoneValid = true;
        addressValid = false;
        zipValid = false;
      });
    } else if (_addressController.text.length < 10) {
      setState(() {
        _errorAddress = 'Address must be at least 10 characters long';
        addressValid = true;
        phoneValid = false;
        zipValid = false;
      });
    } else if (_zipCodeController.text.length < 6) {
      setState(() {
        _errorZipcode = 'Zip code must be at least 6 characters long';
        zipValid = true;
        addressValid = false;
        phoneValid = false;
      });
    } else {
      zipValid = false;
      addressValid = false;
      phoneValid = false;
      _saveAddress();
    }
  }

  Future<void> _saveAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String fullName = _fullNameController.text;
    String phone = _phoneController.text;
    String address = _addressController.text;
    String city = _cityController.text;
    String state = _btn2SelectedVal;
    String zipCode = _zipCodeController.text;
    // Validate phone number

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
                        // phone field
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone Number',
                                style: GoogleFonts.getFont(
                                  "Poppins",
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.dashboardIconColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffEEEEEE),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        '+91',
                                        style: GoogleFonts.getFont(
                                          "Roboto",
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.textColor1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        style: const TextStyle(fontSize: 15),
                                        controller: _phoneController,
                                        decoration: InputDecoration(
                                          hintStyle: GoogleFonts.getFont(
                                            "Roboto",
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.textColor1,
                                            ),
                                          ),
                                          hintText: 'Enter phone number',
                                          filled: true,
                                          fillColor: const Color(0xffEEEEEE),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: phoneValid
                                                  ? Colors.red.withOpacity(1)
                                                  : Colors.transparent,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xfff1f1f1)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                _errorphone.toString(),
                                style: TextStyle(
                                  color: phoneValid
                                      ? Colors.red
                                      : Colors.transparent,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // address field
                        PaymentField(
                          errorText: addressValid ? _errorAddress : null,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State",
                              style: GoogleFonts.getFont(
                                "Poppins",
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.dashboardIconColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                // Adjust border radius as needed
                                color: const Color(0xffEEEEEE),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8,
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  value: _btn2SelectedVal,
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _btn2SelectedVal = newValue;
                                      });
                                    }
                                  },
                                  items: _dropDownMenuItems,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Expanded(
                        //   child: PaymentField(
                        //     controller: _stateController,
                        //     maxLines: 2,
                        //     text: "State",
                        //     hintText: "India",
                        //   ),
                        // ),
                        const SizedBox(height: 12),
                        PaymentField(
                          errorText: zipValid ? _errorZipcode : null,
                          controller: _zipCodeController,
                          maxLines: 2,
                          text: "Zip Code",
                          hintText: "1555",
                        ),
                        const VerticalSpeacing(38),
                        RoundedButton(
                            title: "Save Address", onpress: validateFields),
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
