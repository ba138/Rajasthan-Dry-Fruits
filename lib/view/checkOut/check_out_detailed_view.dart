import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rjfruits/model/checkout_return_model.dart';
import 'package:rjfruits/view/checkOut/payment_done_view.dart';
import '../../res/components/colors.dart';
import '../../res/components/vertical_spacing.dart';
import '../../utils/routes/utils.dart';
import 'package:http/http.dart' as http;

import '../../view_model/user_view_model.dart';

class CheckoutDetailView extends StatefulWidget {
  const CheckoutDetailView({super.key, required this.checkoutModel});
  final CheckoutreturnModel checkoutModel;

  @override
  State<CheckoutDetailView> createState() => _CheckoutDetailViewState();
}

class _CheckoutDetailViewState extends State<CheckoutDetailView> {
  late Razorpay _razorPay;

  @override
  void initState() {
    super.initState();
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Map<String, dynamic> requestData = {
      "razorpay_order_id": widget.checkoutModel.razorpayOrderId,
      "razorpay_payment_id": response.paymentId,
      "razorpay_signature": 'string',
    };
    try {
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      final userModel = await userPreferences.getUser();
      final token = userModel.key;

      Map<String, String> headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'X-CSRFToken':
            'nhMfk5vj6u370ntAQIeaFBV9sGSk4QVSOJ2yQOQM5G2NG7HH7pMJczsyDxTJp6zA',
        'authorization': 'Token $token',
      };

      http.Response apiResponse = await http.post(
        Uri.parse('http://103.117.180.187/api/payment/success/'),
        headers: headers,
        body: jsonEncode(requestData),
      );
      if (apiResponse.statusCode == 200) {
        Utils.toastMessage('Payment SuccessFully Done');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PaymentDoneScreen(checkoutModel: widget.checkoutModel);
        }));
      } else {
        Utils.toastMessage('Payment Failed');
      }
    } catch (e) {
      if (e is http.ClientException) {
        Utils.toastMessage('Network error occurred: ${e.message}');
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utils.toastMessage('Payment Fail: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utils.toastMessage('External wallet: ${response.walletName}');
  }

  void openCheckout(String amount) {
    int amountInPaise = (double.parse(amount) * 100).toInt();
    var options = {
      "key": "rzp_test_kkUIxwpbhcs1td",
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

  @override
  Widget build(BuildContext context) {
    debugPrint('Checkout Details: ${widget.checkoutModel.data.fullName}');
    debugPrint('Checkout Details: ${widget.checkoutModel.data.state}');

    String taxLabel =
        widget.checkoutModel.data.state.trim().toLowerCase() == 'gujarat'
            ? "Tax (sgst + cgst)"
            : "Tax (igst)";

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
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalSpeacing(50.0),
              Container(
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const VerticalSpeacing(30.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Payment:",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpeacing(16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            '₹${widget.checkoutModel.data.total}',
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpeacing(12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Shipping Charges",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            '₹${widget.checkoutModel.data.shippingCharges}',
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const VerticalSpeacing(10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            taxLabel,
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            '₹${widget.checkoutModel.data.tax}',
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const VerticalSpeacing(10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sub Total",
                            style: TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor,
                            ),
                          ),
                          Text(
                            '₹${widget.checkoutModel.data.subTotal}',
                            style: const TextStyle(
                              fontFamily: 'CenturyGothic',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor,
                            ),
                          ),
                        ],
                      ),
                      const VerticalSpeacing(46.0),
                      InkWell(
                        onTap: () {
                          openCheckout(
                              widget.checkoutModel.data.subTotal.toString());
                        },
                        child: Container(
                          height: 56,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColor.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.25), // Shadow color
                                  blurRadius: 8.1, // Blur radius
                                  spreadRadius: 0, // Spread radius
                                  offset: const Offset(0, 4), // Offset
                                ),
                              ]),
                          child: Center(
                            child: Text(
                              "Pay Now",
                              style: GoogleFonts.getFont(
                                "Poppins",
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
      ),
    ));
  }
}
