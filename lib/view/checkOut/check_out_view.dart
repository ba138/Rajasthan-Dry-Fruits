// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/checkOut/widgets/address_container.dart';
import 'package:rjfruits/view/profileView/add_address_view.dart';
import 'package:rjfruits/view_model/shipping_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/routes/routes_name.dart';
import '../../utils/routes/utils.dart';
import 'package:http/http.dart' as http;

import '../../view_model/cart_view_model.dart';
import '../../view_model/user_view_model.dart';

// ignore: must_be_immutable
class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({super.key, this.totalPrice});

  String? totalPrice;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late Map<String, dynamic> selectedAddress = {};
  late Razorpay _razorPay;

  void openCheckout(String amount) {
    int amountInPaise = (double.parse(amount) * 100).toInt();
    var options = {
      "key": "rzp_test_Jg802qU7X2QjKh",
      "amount": amountInPaise,
      "name": 'Rajistan_dry_fruit',
      "description": 'for T-shirt',
      "prefill": {"contact": "value1", "email": "value2"},
      'external': {
        'wallet': ['Paytm'],
      }
    };
    try {
      _razorPay.open(options);
    } catch (e) {
      Utils.flushBarErrorMessage('catch error while Payment: $e', context);
    }
  }

  @override
  void dispose() {
    _razorPay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSelectedAddress = prefs.getString('selectedAddress');
    print('Selected Address: $jsonSelectedAddress');

    if (jsonSelectedAddress != null) {
      Map<String, dynamic> selectedAddress = jsonDecode(jsonSelectedAddress);
      final provider = Provider.of<ShippingProvider>(context, listen: false);

      Map<String, dynamic> requestData = {
        "full_name": selectedAddress['fullName'],
        "contact": selectedAddress['phone'],
        "postal_code": selectedAddress['zipCode'],
        "address": selectedAddress['address'],
        "city": selectedAddress['city'],
        "state": selectedAddress['state'],
        "country": "USA",
        "payment_type": "online",
        "shipment_type": provider.selectedShippingType,
      };
      // provider.selectedShippingType
      print('..............required data: $requestData............');

      try {
        // Retrieve the user's authentication token
        final userPreferences =
            Provider.of<UserViewModel>(context, listen: false);
        final userModel = await userPreferences.getUser();
        final token = userModel.key;

        // Construct the request headers with the authentication token
        Map<String, String> headers = {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRFToken':
              'kVkAd4GoV0CSQ4zfGvhKOo5Q93I8QR2jXNwylIuqdn1BTIVuWKMnYCRGNP5JahMY',
          'authorization': 'Token $token',
        };

        // Send the POST request to the API endpoint with the prepared headers and data
        http.Response apiResponse = await http.post(
          Uri.parse('http://103.117.180.187/api/checkout/'),
          headers: headers,
          body: jsonEncode(requestData),
        );

        print('API Response Status Code: ${apiResponse.statusCode}');

        if (apiResponse.statusCode == 201) {
          final provider =
              Provider.of<ShippingProvider>(context, listen: false);

          Utils.toastMessage('Payment Successfully Done');

          Navigator.pushNamed(
            context,
            RoutesName.paymentDone,
            arguments: {
              'selectedAddress': selectedAddress,
              'totalAmount': widget.totalPrice,
            },
          );
        } else {
          // Handle API request failure with more specific message based on response body
          Utils.toastMessage(
              'Failed to submit payment data. Status code: ${apiResponse.statusCode}');
        }
      } catch (e) {
        // Handle exceptions during API request
        if (e is http.ClientException) {
          Utils.toastMessage('Network error occurred: ${e.message}');
        } else {
          Utils.toastMessage('Error occurred while processing payment: $e');
        }
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utils.toastMessage('Payment Fail: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utils.toastMessage('External wallet: ${response.walletName}');
  }

  double totalPrice = 0.0;
  @override
  void initState() {
    super.initState();
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    totalPrice = double.parse(widget.totalPrice.toString());
  }

  int selectedContainerIndex =
      0; // Keeps track of the currently selected container index (0 or 1)
  Color selectedContainerColor = AppColor.primaryColor;
  Color unselectedContainerColor = AppColor.whiteColor;
  Color selectedIconColor = AppColor.whiteColor;
  Color unselectedIconColor = AppColor.blackColor;
  Color selectedTextColor = AppColor.whiteColor;
  Color unselectedTextColor = AppColor.blackColor;

  @override
  Widget build(BuildContext context) {
    final shipCharge = Provider.of<CartRepositoryProvider>(context);

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    Text(
                      "Checkout",
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
                const VerticalSpeacing(20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select shipment type",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                    const VerticalSpeacing(10.0),
                    ChangeNotifierProvider<ShippingProvider>(
                      create: (context) => ShippingProvider(),
                      child: Row(
                        children: [
                          // Ship rocket
                          Consumer<ShippingProvider>(
                            builder: (context, provider, child) => InkWell(
                              onTap: () {
                                provider.updateSelection(0);
                                setState(() {
                                  selectedContainerIndex = 0;
                                  totalPrice = (widget.totalPrice != null
                                          ? double.parse(widget.totalPrice!)
                                          : 0.0) +
                                      shipCharge.cartRepositoryProvider
                                          .shipRocketCharges;
                                });
                              },
                              child: Container(
                                height: 80,
                                width: 135,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: provider.selectedContainerIndex == 0
                                      ? selectedContainerColor
                                      : unselectedContainerColor,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.rocket_outlined,
                                          size: 30.0,
                                          color:
                                              provider.selectedContainerIndex ==
                                                      0
                                                  ? selectedIconColor
                                                  : unselectedIconColor,
                                        ),
                                        Text(
                                          "Ship rocket",
                                          style: GoogleFonts.getFont(
                                            "Poppins",
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  provider.selectedContainerIndex ==
                                                          0
                                                      ? selectedTextColor
                                                      : unselectedTextColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "₹${shipCharge.cartRepositoryProvider.shipRocketCharges}",
                                          style: GoogleFonts.getFont(
                                            "Poppins",
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  provider.selectedContainerIndex ==
                                                          0
                                                      ? selectedTextColor
                                                      : unselectedTextColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 20.0),
                          // Custom shipping
                          Consumer<ShippingProvider>(
                            builder: (context, provider, child) => InkWell(
                              onTap: () {
                                provider.updateSelection(1);
                                setState(() {
                                  selectedContainerIndex = 1;
                                  totalPrice = (widget.totalPrice != null
                                          ? double.parse(widget.totalPrice!)
                                          : 0.0) +
                                      shipCharge.cartRepositoryProvider
                                          .customShippingCharges;
                                });
                              },
                              child: Container(
                                height: 80,
                                width: 135,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: provider.selectedContainerIndex == 1
                                      ? selectedContainerColor
                                      : unselectedContainerColor,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.local_shipping_outlined,
                                          size: 30.0,
                                          color:
                                              provider.selectedContainerIndex ==
                                                      1
                                                  ? selectedIconColor
                                                  : unselectedIconColor,
                                        ),
                                        Text(
                                          "custom shipment",
                                          style: GoogleFonts.getFont(
                                            "Poppins",
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  provider.selectedContainerIndex ==
                                                          1
                                                      ? selectedTextColor
                                                      : unselectedTextColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "₹${shipCharge.cartRepositoryProvider.customShippingCharges}",
                                          style: GoogleFonts.getFont(
                                            "Poppins",
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  provider.selectedContainerIndex ==
                                                          1
                                                      ? selectedTextColor
                                                      : unselectedTextColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
                const VerticalSpeacing(20),
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AddAddresScreen(
                            totalAmount: widget.totalPrice.toString(),
                          );
                        }));
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
                FutureBuilder<List<Map<String, dynamic>>>(
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
                                    await _storeSelectedAddress(address);
                                    selectedAddress = address;
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
                const VerticalSpeacing(50),
                Consumer<ShippingProvider>(builder: (context, provider, child) {
                  return RoundedButton(
                    title: "Proceed to Payment: ₹$totalPrice",
                    onpress: () {
                      if (selectedAddress.isEmpty) {

                        
                        Utils.toastMessage('please select the Address');
                      } else {
                        openCheckout('${double.parse(totalPrice.toString())}');
                      }
                    },
                  );
                }),
                const VerticalSpeacing(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _storeSelectedAddress(Map<String, dynamic> address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedAddress', jsonEncode(address));
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
