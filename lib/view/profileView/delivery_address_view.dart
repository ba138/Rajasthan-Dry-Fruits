import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/loading_manager.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/profileView/edit_address.dart';
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
    fetchAddresses(context);
  }

  Future<void> fetchAddresses(BuildContext context) async {
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
      Utils.toastMessage('Error Occure');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteAddress(int id) async {
    final userPreferences = Provider.of<UserViewModel>(context, listen: false);
    final userModel = await userPreferences.getUser();
    final token = userModel.key;
    final url = Uri.parse('http://103.117.180.187/api/address/$id/');
    final response = await http.delete(
      url,
      headers: {
        'accept': 'application/json',
        'X-CSRFToken':
            'SlSrUKA34Wtxgek0vbx9jfpCcTylfy7BjN8KqtVw38sdWYy7MS5IQdW1nKzKAOLj',
        'authorization': 'Token $token',
      },
    );

    if (response.statusCode == 204 || response.statusCode == 200) {
      Utils.toastMessage('Seccessfully deleted Address');
      fetchAddresses(context);
      // Successfully deleted the address
    } else {
      // Error occurred while deleting the address
      print('Failed to delete the address');
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
                    onpressEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditAddress(address, address['id'])),
                      );
                    },
                    onpresDelete: () {
                      _deleteAddress(address['id']);
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
