import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view/checkOut/check_out_view.dart';
import 'package:rjfruits/view_model/user_view_model.dart';

import '../checkOut/widgets/payment_field.dart';

class EditAddress extends StatefulWidget {
  const EditAddress(this.address, this.addressId);
  final Map<String, dynamic> address;
  final int addressId;

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  String? _errorphone;
  String? _errorAddress;
  String? _errorZipcode;
  bool phoneValid = false;
  bool addressValid = false;
  bool zipValid = false;
  String _selectedState = "andhra_pradesh";
  String _selectedCountry = "india";

  final List<String> statesList = [
    'andhra_pradesh',
    'arunachal_pradesh',
    'assam',
    'bihar',
    'chhattisgarh',
    'goa',
    'gujarat',
    'haryana',
    'himachal_pradesh',
    'jharkhand',
    'karnataka',
    'kerala',
    'madhya_pradesh',
    'maharashtra',
    'manipur',
    'meghalaya',
    'mizoram',
    'nagaland',
    'odisha',
    'punjab',
    'rajasthan',
    'sikkim',
    'tamil_nadu',
    'telangana',
    'tripura',
    'uttar_pradesh',
    'uttarakhand',
    'west_bengal',
    'andaman_and_nicobar_islands',
    'chandigarh',
    'dadra_and_nagar_haveli_and_daman_and_diu',
    'lakshadweep',
    'delhi',
    'puducherry',
    'ladakh',
    'jammu_and_kashmir ',
  ];

  final List<String> countriesList = ['USA', 'Canada', 'india'];

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.address['full_name'] ?? '';
    _phoneController.text = widget.address['contact'] ?? '';
    _addressController.text = widget.address['address'] ?? '';
    _cityController.text = widget.address['city'] ?? '';
    _gstController.text = widget.address['gst'] ?? '';

    _zipCodeController.text = widget.address['postal_code'].toString();
    _selectedState = widget.address['state'] ?? 'andhra_pradesh';
    _selectedCountry = widget.address['country'] ?? 'india';
  }

  void validateFields() {
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
    }
  }

  Future<void> updateAddress() async {
    try {
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      final userModel = await userPreferences.getUser();
      final token = userModel.key;

      Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRFToken':
            'SlSrUKA34Wtxgek0vbx9jfpCcTylfy7BjN8KqtVw38sdWYy7MS5IQdW1nKzKAOLj',
        'authorization': 'Token $token',
      };

      Map<String, dynamic> updatedAddress = {
        'full_name': _fullNameController.text,
        'contact': _phoneController.text,
        'address': _addressController.text,
        'city': _cityController.text,
        'state': _selectedState,
        'country': _selectedCountry,
        'postal_code': _zipCodeController.text,
        'gst': _gstController.text,
      };

      final response = await http.patch(
        Uri.parse('http://103.117.180.187/api/address/${widget.addressId}/'),
        headers: headers,
        body: jsonEncode(updatedAddress),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        Utils.toastMessage('Address updated successfully');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CheckOutScreen()),
        );
      } else {
        Utils.flushBarErrorMessage('Failed to update address', context);
        print('Failed to update address: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("images/bgimg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 6),
                      Text(
                        "Edit Address",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 2),
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
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          PaymentField(
                            controller: _fullNameController,
                            text: "Full Name",
                            hintText: "Enter your full name",
                            maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phone Number",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
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
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        style: const TextStyle(fontSize: 15),
                                        controller: _phoneController,
                                        decoration: InputDecoration(
                                          hintText: phoneValid
                                              ? _errorphone
                                              : 'Enter phone number',
                                          filled: true,
                                          fillColor: const Color(0xffEEEEEE),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          PaymentField(
                            controller: _addressController,
                            text: "Address",
                            hintText: addressValid
                                ? _errorAddress
                                : "Enter your address",
                            maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          PaymentField(
                            controller: _cityController,
                            text: "City",
                            hintText: "Enter your city",
                            maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          PaymentField(
                            controller: _gstController,
                            text: "GST-IN",
                            hintText: "Enter your GST-IN",
                            maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Country",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: const Color(0xffEEEEEE),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedCountry,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCountry = value!;
                                      });
                                    },
                                    items: countriesList
                                        .map((country) => DropdownMenuItem(
                                              child: Text(country),
                                              value: country,
                                            ))
                                        .toList(),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          //select State
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
                                    dropdownColor: AppColor.whiteColor,
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                    value: _selectedState,
                                    onChanged: (value) {
                                      if (value != null) {
                                        setState(() {
                                          _selectedState = value;
                                        });
                                      }
                                    },
                                    items: statesList
                                        .map((state) => DropdownMenuItem(
                                              child: Text(state),
                                              value: state,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                          PaymentField(
                            controller: _zipCodeController,
                            text: "Zip Code",
                            hintText: zipValid
                                ? _errorZipcode
                                : "Enter your zip code",
                            maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          RoundedButton(
                            title: "Save Address",
                            onpress: () {
                              validateFields();
                              updateAddress();
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
