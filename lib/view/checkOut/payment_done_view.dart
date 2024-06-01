import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/rounded_button.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:rjfruits/utils/routes/routes_name.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class PaymentDoneScreen extends StatefulWidget {
  const PaymentDoneScreen({super.key});

  @override
  State<PaymentDoneScreen> createState() => _PaymentDoneScreenState();
}

class _PaymentDoneScreenState extends State<PaymentDoneScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _items = [];
  final GlobalKey _globalKey = GlobalKey();

  void _addItem() {
    setState(() {
      _items.add(_controller.text);
      _controller.clear();
    });
  }

  Future<void> _captureAndSave() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = (await getExternalStorageDirectory())?.path;
      String filePath = '$directory/list_image.png';
      File imgFile = File(filePath);
      await imgFile.writeAsBytes(pngBytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image saved to $filePath')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final selectedAddress = arguments['selectedAddress'];
    final totalAmount = arguments['totalAmount'];
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/done.png",
                height: 282,
                width: 316,
              ),
              const VerticalSpeacing(40),
              Text(
                "Order Placed Successfully ",
                style: GoogleFonts.getFont(
                  "Poppins",
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textColor1,
                  ),
                ),
              ),
              const VerticalSpeacing(12),
              Text(
                "Thanks for your order.Your order has placed successfully.to track the delivery ,my account>my order",
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  "Poppins",
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColor.iconColor,
                  ),
                ),
              ),
              const VerticalSpeacing(60),
              RoundedButton(
                  title: "Back to home",
                  onpress: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutesName.dashboard, (route) => false);
                  }),
              const VerticalSpeacing(
                14,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.myorders);
                },
                child: Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.primaryColor, width: 2),
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
                  child: Center(
                    child: Text(
                      "Track Order",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const VerticalSpeacing(
                14,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.primaryColor, width: 2),
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
                  child: Center(
                    child: Text(
                      "DownLoad Invoice",
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
