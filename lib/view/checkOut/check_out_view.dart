// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rjfruits/model/checkout_return_model.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/loading_manager.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/view/checkOut/check_out_detailed_view.dart';
import 'package:rjfruits/view/checkOut/widgets/address_container.dart';
import 'package:rjfruits/view/profileView/add_address_view.dart';
import 'package:rjfruits/view_model/shipping_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

  late Map<String, dynamic> selectedAddress;

  @override
  void initState() {
    super.initState();

    // Initialize totalPrice with the value from widget if available
    totalPrice =
        widget.totalPrice != null ? double.parse(widget.totalPrice!) : 0.0;

    // Load the selected address from shared preferences
    _loadSelectedAddress();
  }

  Future<void> _loadSelectedAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonSelectedAddress = prefs.getString('selectedAddress');

    if (jsonSelectedAddress != null) {
      setState(() {
        selectedAddress = jsonDecode(jsonSelectedAddress);
      });
    } else {
      setState(() {
        selectedAddress = {};
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

  Future<void> checkoutDone(
    BuildContext context,
  ) async {
    if (selectedAddress.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      final provider = Provider.of<ShippingProvider>(context, listen: false);

      Map<String, dynamic> requestData = {
        "full_name": selectedAddress['fullName'],
        "contact": selectedAddress['phone'],
        "postal_code": selectedAddress['zipCode'],
        "address": selectedAddress['address'],
        "address_label": 'home',
        "city": selectedAddress['city'],
        "state": selectedAddress['state'],
        "country": "USA",
        "gst_in": selectedAddress['gst'],
        "payment_type": "online",
        "shipment_type": provider.selectedShippingType,
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
          Utils.toastMessage(
              'Failed to submit Checkout data. Status code: ${apiResponse.statusCode}');
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

  @override
  Widget build(BuildContext context) {
    final shipCharge = Provider.of<CartRepositoryProvider>(context);
    bool isPressed = false;

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
                                    double basePrice = widget.totalPrice != null
                                        ? double.parse(widget.totalPrice!)
                                        : 0.0;
                                    double shipRocket = shipCharge
                                        .cartRepositoryProvider
                                        .shipRocketCharges;

                                    totalPrice = _btn2SelectedVal == "Normal"
                                        ? basePrice + shipRocket
                                        : basePrice + shipRocket * 2;
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
                                            _btn2SelectedVal == "Normal"
                                                ? "₹${shipCharge.cartRepositoryProvider.shipRocketCharges}"
                                                : "₹${shipCharge.cartRepositoryProvider.shipRocketCharges * 2}",
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
                                    double basePrice = widget.totalPrice != null
                                        ? double.parse(widget.totalPrice!)
                                        : 0.0;
                                    double customShippingCharges = shipCharge
                                        .cartRepositoryProvider
                                        .customShippingCharges;

                                    totalPrice = _btn2SelectedVal == "Normal"
                                        ? basePrice + customShippingCharges
                                        : basePrice + customShippingCharges * 2;
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
                                            _btn2SelectedVal == "Normal"
                                                ? "₹${shipCharge.cartRepositoryProvider.customShippingCharges}"
                                                : "₹${shipCharge.cartRepositoryProvider.customShippingCharges * 2}",
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
                  // Select address
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
                          final isSelected = addresses == selectedAddress;
                          return Column(
                            children: addresses.map((address) {
                              return Column(
                                children: [
                                  Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.2),
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      border: Border.all(
                                          width: 2,
                                          color: AppColor.primaryColor),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white
                                              .withOpacity(0.5), // Shadow color
                                          blurRadius: 2, // Blur radius
                                          spreadRadius: 0, // Spread radius
                                          offset: const Offset(0, 0), // Offset
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, left: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              const VerticalSpeacing(7),
                                              InkWell(
                                                onTap: () async {
                                                  await _storeSelectedAddress(
                                                      address);
                                                  selectedAddress = address;
                                                },
                                                child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColor
                                                            .primaryColor),
                                                    color: isSelected
                                                        ? AppColor.primaryColor
                                                        : Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const MyCheckBox(),
                                          const SizedBox(width: 15.0),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  text: address['fullName']
                                                              .length >
                                                          15
                                                      ? '${address['fullName'].substring(0, 15)}...'
                                                      : address['fullName'],
                                                  style: const TextStyle(
                                                    fontFamily: 'CenturyGothic',
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColor.primaryColor,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          '\n${address['phone'] ?? ''}\n',
                                                      style: const TextStyle(
                                                        color:
                                                            AppColor.textColor1,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: (() {
                                                        String fullText =
                                                            '${address['address'] ?? ''}, ${address['city'] ?? ''} ${address['state'] ?? ''} ${address['zipCode'] ?? ''} ${address['gst'] ?? ''}';
                                                        return fullText.length >
                                                                20
                                                            ? '${fullText.substring(0, 20)}...'
                                                            : fullText;
                                                      })(),
                                                      style: const TextStyle(
                                                        color:
                                                            AppColor.textColor1,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  // AddressCheckOutWidget(
                                  //   bgColor: AppColor.whiteColor,
                                  //   borderColor: AppColor.primaryColor,
                                  //   titleColor: AppColor.primaryColor,
                                  //   title: address['fullName'] ?? '',
                                  //   phNo: address['phone'] ?? '',
                                  //   address:
                                  //       '${address['address'] ?? ''}, ${address['city'] ?? ''} ${address['state'] ?? ''} ${address['zipCode'] ?? ''} ${address['gst'] ?? ''}',
                                  //   onpress: () async {
                                  //     // Store the selected address in shared preferences
                                  //     await _storeSelectedAddress(address);
                                  //     selectedAddress = address;
                                  //   },
                                  // ),
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
                  Consumer<ShippingProvider>(
                      builder: (context, provider, child) {
                    return RoundedButton(
                      title: "Proceed to Checkout: ₹$totalPrice",
                      onpress: () {
                        if (selectedAddress.isEmpty) {
                          Utils.toastMessage('please select the Address');
                        } else {
                          checkoutDone(context);
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
      ),
    );
  }

  Future<void> _storeSelectedAddress(Map<String, dynamic> address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedAddress', jsonEncode(address));
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      selectedAddress = address;
    });
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
