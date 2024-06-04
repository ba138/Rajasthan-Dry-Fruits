// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rjfruits/model/checkout_return_model.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({
    super.key,
    required this.checkoutdetail,
  });

  final CheckoutreturnModel checkoutdetail;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> captureAndSave() async {
    try {
      // Ensure the widget is completely rendered
      await Future.delayed(const Duration(milliseconds: 200));

      RenderRepaintBoundary? boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        throw Exception('Boundary is null');
      }

      // Ensure the boundary has no pending repaint requests
      if (!boundary.debugNeedsPaint) {
        var image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData =
            await image.toByteData(format: ImageByteFormat.png);
        if (byteData == null) {
          throw Exception('ByteData is null');
        }
        Uint8List pngBytes = byteData.buffer.asUint8List();

        final status = await Permission.storage.request();
        if (status.isGranted) {
          final directory = await getExternalStorageDirectory();
          if (directory == null) {
            throw Exception('Directory is null');
          }
          String filePath = '${directory.path}/list_image.png';
          File imgFile = File(filePath);
          await imgFile.writeAsBytes(pngBytes);

          // Save to gallery
          await ImageGallerySaver.saveImage(pngBytes, name: "list_image");

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image saved to gallery')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permission denied')),
          );
        }
      } else {
        throw Exception('Boundary needs paint');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      debugPrint("this is error:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkoutDetail = widget.checkoutdetail.data;
    final orderItems = checkoutDetail.orderItems;
    final billedBy = checkoutDetail.fullName;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColor.whiteColor,
          image: DecorationImage(
              image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.west,
                        color: AppColor.appBarTxColor,
                      ),
                    ),
                    Text(
                      'Invoice',
                      style: GoogleFonts.getFont(
                        "Poppins",
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColor.appBarTxColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        captureAndSave();
                      },
                      icon: const Icon(
                        Icons.download_outlined,
                        color: AppColor.appBarTxColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: AppColor.primaryColor, width: 2),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "images/logo.png",
                            height: 100,
                            width: 100,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Invoice Number:",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      widget.checkoutdetail.data
                                          .order_invoice_number,
                                      style: GoogleFonts.poppins(fontSize: 14)),
                                  Text("Billed By:",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text(billedBy,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text(widget.checkoutdetail.data.address,
                                      style: GoogleFonts.poppins(fontSize: 14)),
                                  Text(
                                    widget.checkoutdetail.data.contact,
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  Text(
                                    "********",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  Text(
                                    widget.checkoutdetail.data.createdOn
                                        .toString(),
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),

                                  // If billedBy's address and phone are also needed, add them here
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Billed To:",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text("jhwebtech",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "185, karannagar (G.H.B, Sanand - Nalsarovar Rd, Ahmedabad\n, Gujarat 382110,Ahmedabad,",
                                      style: GoogleFonts.poppins(fontSize: 14)),
                                  Text(
                                    "GSTIN: 24APVPJ6817J1ZC",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  Text(
                                    "PAN: APVPJ6817J",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  Text(
                                    "Email: jhwebtech2016@gmail.com",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  Text(
                                    "Phone: +917041717178",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  Text(
                                    "Bank Name: Bank Of Baroda",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  Text(
                                    "Bank Account No: 31030200001599",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  Text(
                                    "IFSC Code: BARB0SANAND",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  ),
                                  // If billedTo's address and phone are also needed, add them here
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text("Order Items:",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        for (var item in orderItems)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Product Name: ${item.product.title}",
                                  style: GoogleFonts.poppins(fontSize: 14)),
                              Text("Price: ${item.product.price}",
                                  style: GoogleFonts.poppins(fontSize: 14)),
                              Text("Quantity: ${item.qty}",
                                  style: GoogleFonts.poppins(fontSize: 14)),
                              const VerticalSpeacing(8),
                            ],
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(
                              widget.checkoutdetail.data.total.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                widget.checkoutdetail.data.state == 'gujarat'
                                    ? "Tax (sgst + cgst)"
                                    : "Tax (igst)",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(
                              widget.checkoutdetail.data.tax.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shipment Charges",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(
                              widget.checkoutdetail.data.shippingCharges
                                  .toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppColor.primaryColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sub-Total",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(
                              widget.checkoutdetail.data.subTotal.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
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
