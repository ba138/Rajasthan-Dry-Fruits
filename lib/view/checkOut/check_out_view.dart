import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/checkOut/widgets/address_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../utils/routes/routes_name.dart';
import '../../utils/routes/utils.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key, required this.totalPrice}) : super(key: key);

  final String totalPrice;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late Map<String, dynamic> selectedAddress = {};
  late Razorpay _razorPay;

  void openCheckout(String amount) async {
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
    String? paymentId = response.paymentId ?? '';
    String? orderId = response.orderId ?? '';

    // Retrieve selected address from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSelectedAddress = prefs.getString('selectedAddress');

    if (jsonSelectedAddress != null) {
      // Decode the selected address JSON string
      Map<String, dynamic> selectedAddress = jsonDecode(jsonSelectedAddress);

      // Store payment and address details
      await prefs.setStringList(
        'paymentDetails',
        [paymentId, orderId, jsonEncode(selectedAddress)],
      );

      Utils.toastMessage('Payment Successfully Done: $paymentId');
      Utils.toastMessage('Payment orderId: $orderId');
      print(
          'Slected address is : ${selectedAddress} and total amount is ${widget.totalPrice}');

      // Navigate to payment done screen with address and total amount
      Navigator.pushNamed(
        context,
        RoutesName.paymentDone,
        arguments: {
          'selectedAddress': selectedAddress,
          'totalAmount': widget.totalPrice,
        },
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utils.toastMessage('Payment Fail: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utils.toastMessage('External wallet: ${response.walletName}');
  }

  @override
  void initState() {
    super.initState();
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString(
                                        'selectedAddress', jsonEncode(address));
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
                RoundedButton(
                  title: "Proceed to Payment: ${widget.totalPrice}",
                  onpress: () {
                    openCheckout(widget.totalPrice);
                  },
                ),
                const VerticalSpeacing(20),
              ],
            ),
          ),
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
