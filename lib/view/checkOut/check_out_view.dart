// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/checkout_return_model.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/loading_manager.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:rjfruits/view/checkOut/check_out_detailed_view.dart';
import 'package:rjfruits/view/profileView/add_address_view.dart';
import 'dart:convert';
import '../../utils/routes/utils.dart';
import 'package:http/http.dart' as http;
import '../../view_model/cart_view_model.dart';
import '../../view_model/user_view_model.dart';
import '../profileView/edit_address.dart';

// ignore: must_be_immutable
class CheckOutScreen extends StatefulWidget {
  CheckOutScreen({super.key, this.totalPrice});

  String? totalPrice;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  double totalPrice = 0.0;
  int selectedContainerIndex = 0;
  String _btn2SelectedVal = "Normal";

  static const menuItems = <String>[
    'Normal',
    'Fast',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  Color selectedContainerColor = AppColor.primaryColor;
  Color unselectedContainerColor = Colors.white;
  Color selectedIconColor = Colors.white;
  Color unselectedIconColor = Colors.black;
  Color selectedTextColor = Colors.white;
  Color unselectedTextColor = Colors.black;

  Map<String, dynamic>? selectedAddress;
  List<Map<String, dynamic>> addresses = [];

  @override
  void initState() {
    super.initState();

    // Initialize totalPrice with the value from widget if available
    totalPrice =
        widget.totalPrice != null ? double.parse(widget.totalPrice!) : 0.0;

    // Load the selected address from shared preferences
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    _isLoading = true;
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
      debugPrint('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final shipCharge =
        Provider.of<CartRepositoryProvider>(context, listen: false);
    setState(() {
      totalPrice += shipCharge.cartRepositoryProvider.shipRocketCharges;
    });
  }

  //check out done function
  bool _isLoading = false;

  Future<void> checkoutDone(BuildContext context) async {
    if (selectedAddress != null && selectedAddress!.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> requestData = {
        "full_name": selectedAddress!['full_name'],
        "contact": selectedAddress!['contact'],
        "postal_code": selectedAddress!['postal_code'],
        "address": selectedAddress!['address'],
        "address_label": 'home',
        "city": selectedAddress!['city'],
        "state": selectedAddress!['state'],
        "country": selectedAddress!['country'],
        "gst_in": selectedAddress!['gst_in'],
        "payment_type": "online",
        "shipment_type": shippingType,
        "service_type": _btn2SelectedVal == 'Normal' ? 'normal' : 'fast'
      };

      print('..............required data: $requestData............');

      try {
        final userPreferences =
            Provider.of<UserViewModel>(context, listen: false);
        final userModel = await userPreferences.getUser();
        final token = userModel.key;

        Map<String, String> headers = {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRFToken':
              'tUleT0twriskMO0B4VJJM0N7AM9CMwYVUmBxpJOZqur0syeIlChijYkwLDa17MCD',
          'authorization': 'Token $token',
        };

        http.Response apiResponse = await http.post(
          Uri.parse('http://103.117.180.187/api/checkout/'),
          headers: headers,
          body: jsonEncode(requestData),
        );

        print('API Response Status Code: ${apiResponse.statusCode}');

        if (apiResponse.statusCode == 201) {
          print('API Response Body: ${apiResponse.body}');
          Utils.toastMessage('Checkout Successfully Done');
          final checkoutDetails =
              CheckoutreturnModel.fromJson(jsonDecode(apiResponse.body));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CheckoutDetailView(checkoutModel: checkoutDetails);
              },
            ),
          );
        } else {
          debugPrint(
              '.........................Check Out return data ${apiResponse.statusCode}: ${apiResponse.body}...........≥');
          Utils.toastMessage('Failed to submit Checkout datea');
          Navigator.pushNamed(context, RoutesName.dashboard);
        }
      } catch (e) {
        if (e is http.ClientException) {
          Utils.toastMessage('Network error occurred: ${e.message}');
        } else {
          Utils.toastMessage('Error occurred while processing Checkout: $e');
          debugPrint('error: $e');
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      Utils.toastMessage('Selected address is empty.');
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
      fetchAddresses();
      // Successfully deleted the address
    } else {
      // Error occurred while deleting the address
      print('Failed to delete the address');
    }
  }

  String shippingType = 'ship_rocket';

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
        child: LoadingManager(
          isLoading: _isLoading,
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
                        "Service Type",
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
                      Container(
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(
                            color: AppColor.primaryColor,
                            width: 1.0,
                          ),
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
                            value: _btn2SelectedVal,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _btn2SelectedVal = newValue;
                                  if (newValue == "Normal") {
                                    totalPrice =
                                        double.parse(widget.totalPrice!) +
                                            shipCharge.cartRepositoryProvider
                                                .shipRocketCharges;
                                  } else {
                                    totalPrice =
                                        double.parse(widget.totalPrice!) +
                                            shipCharge.cartRepositoryProvider
                                                    .shipRocketCharges *
                                                2;
                                  }
                                });
                              }
                            },
                            items: _dropDownMenuItems,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
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
                      Row(
                        children: [
                          // Ship rocket
                          InkWell(
                            onTap: () {
                              setState(() {
                                shippingType = 'ship_rocket'; // Corrected here
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 135,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: shippingType == 'ship_rocket'
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
                                        color: shippingType == 'ship_rocket'
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
                                            color: shippingType == 'ship_rocket'
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

                          const SizedBox(width: 20.0),
                          // Custom shipping
                          InkWell(
                            onTap: () {
                              setState(() {
                                shippingType = 'custom'; // Corrected here
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 135,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: shippingType == 'custom'
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
                                        color: shippingType == 'custom'
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
                                            color: shippingType == 'custom'
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
                        ],
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final address = addresses[index];
                        final isSelected = address == selectedAddress;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2, color: AppColor.primaryColor),
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
                                  right: 10.0, left: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedAddress = address;
                                            });
                                            debugPrint(
                                                'address $selectedAddress');
                                          },
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor.primaryColor),
                                              color: isSelected
                                                  ? AppColor.primaryColor
                                                  : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20.0),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              text: address['full_name'],
                                              style: const TextStyle(
                                                fontFamily: 'CenturyGothic',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.primaryColor,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '\n${address['contact'] ?? ''}\n',
                                                  style: const TextStyle(
                                                    color: AppColor.textColor1,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: (() {
                                                    String fullText =
                                                        '${address['address'] ?? ''}, ${address['city'] ?? ''} ${address['state'] ?? ''} ${address['postal_code'] ?? ''} ${address['gst'] ?? ''}';
                                                    return fullText.length > 20
                                                        ? '${fullText.substring(0, 20)}...'
                                                        : fullText;
                                                  })(),
                                                  style: const TextStyle(
                                                    color: AppColor.textColor1,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditAddress(address,
                                                          address['id'])),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: AppColor.textColor1,
                                          )),
                                      IconButton(
                                        onPressed: () {
                                          _deleteAddress(address['id']);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppColor.textColor1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const VerticalSpeacing(50),
                  RoundedButton(
                    title: "Proceed to Checkout",
                    onpress: () {
                      if (selectedAddress!.isEmpty) {
                        Utils.toastMessage('please select the Address');
                      } else {
                        checkoutDone(context);
                      }
                    },
                  ),
                  const VerticalSpeacing(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
