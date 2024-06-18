import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/loading_manager.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/routes/utils.dart';
import '../../view_model/user_view_model.dart';
import '../checkOut/widgets/address_container.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> addresses = [];
  Map<String, dynamic>? selectedAddress;

  @override
  void initState() {
    super.initState();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final userPreferences =
          Provider.of<UserViewModel>(context, listen: false);
      final userModel = await userPreferences.getUser();
      final token = userModel.key;
      final response = await http.get(
        Uri.parse('http://103.117.180.187/api/address/'),
        headers: {
          'Accept': 'application/json',
          'X-CSRFToken':
              'SlSrUKA34Wtxgek0vbx9jfpCcTylfy7BjN8KqtVw38sdWYy7MS5IQdW1nKzKAOLj',
          'authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          addresses =
              List<Map<String, dynamic>>.from(json.decode(response.body));
          if (addresses.isNotEmpty) {
            selectedAddress = addresses[0];
          }
          _isLoading = false;
        });
      } else {
        Utils.flushBarErrorMessage('Failed to load addresses', context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      Utils.flushBarErrorMessage('Error: $e', context);
      setState(() {
        _isLoading = false;
      });
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
      body: LoadingManager(
        isLoading: _isLoading,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return Column(
                children: [
                  AddressCheckOutWidget(
                    bgColor: AppColor.whiteColor,
                    borderColor: AppColor.primaryColor,
                    titleColor: AppColor.primaryColor,
                    title: address['full_name'] ?? '',
                    phNo: address['contact'] ?? '',
                    address:
                        '${address['address'] ?? ''}, ${address['city'] ?? ''} ${address['state'] ?? ''} ${address['postal_code'] ?? ''}',
                    onpress: () async {
                      // Store the selected address in shared preferences
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('selectedAddress', jsonEncode(address));
                      setState(() {
                        selectedAddress = address;
                      });
                    },
                  ),
                  const VerticalSpeacing(20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
