import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/utils/routes/utils.dart';
import 'package:rjfruits/view/profileView/widgets/promo_card.dart';

import '../../view_model/user_view_model.dart';

class PromoView extends StatefulWidget {
  const PromoView({super.key});

  @override
  State<PromoView> createState() => _PromoViewState();
}

class _PromoViewState extends State<PromoView> {
  List<Map<String, String>> _coupons = [];

  @override
  void initState() {
    super.initState();
    _fetchCoupons();
  }

  Future<void> _fetchCoupons() async {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    final userModel = await userPreferences.getUser();
    final token = userModel.key;

    final response = await http.get(
      Uri.parse('http://103.117.180.187/api/coupon-list/'),
      headers: {
        'accept': 'application/json',
        'X-CSRFToken':
            'EPfbegDrcoMcKsg8rk5bx1bMotQv2GCk5hvuKZYUbALSqcufI1DK4ZIbzkRUnWg2',
        'authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _coupons = data.map((coupon) {
          return {
            'discount': coupon['discount'] as String,
            'code': coupon['code'] as String,
          };
        }).toList();
      });
    } else {
      Utils.flushBarErrorMessage('error occure', context);
    }
  }

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
          "Coupons",
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
          child: _coupons.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.count(
                  padding: const EdgeInsets.all(5.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: (230 / 255),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: List.generate(
                    _coupons.length,
                    (index) {
                      final coupon = _coupons[index];
                      return PromoCard(
                        discount: coupon['discount']!,
                        code: coupon['code']!,
                        onpress: () {
                          Clipboard.setData(
                            ClipboardData(text: coupon['code'].toString()),
                          );
                          Utils.toastMessage("Code copied to clipboard");
                        },
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
