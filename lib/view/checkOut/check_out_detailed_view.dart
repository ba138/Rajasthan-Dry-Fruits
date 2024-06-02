import 'package:flutter/material.dart';
import 'package:rjfruits/model/checkout_return_model.dart';

class CheckoutDetailView extends StatelessWidget {
  const CheckoutDetailView({super.key, required this.checkoutModel});
  final CheckoutreturnModel checkoutModel;

  @override
  Widget build(BuildContext context) {
    debugPrint('Checkout Details: ${checkoutModel.data.fullName}');
    return Scaffold(
      body: Center(
        child: Text('checkout detailed'),
      ),
    );
  }
}
