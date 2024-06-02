// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:rjfruits/model/checkout_return_model.dart';
// import 'package:rjfruits/res/components/colors.dart';
// import 'package:rjfruits/res/components/vertical_spacing.dart';

// class InvoiceScreen extends StatefulWidget {
//   const InvoiceScreen(
//       {super.key,
//       required this.sendData,
//       required this.totalAmount,
//       required this.checkoutdetail});
//   final Map<String, dynamic> sendData;
//   final String totalAmount;
//   final CheckoutreturnModel checkoutdetail;

//   @override
//   State<InvoiceScreen> createState() => _InvoiceScreenState();
// }

// class _InvoiceScreenState extends State<InvoiceScreen> {
//   final GlobalKey _globalKey = GlobalKey();

//   Future<void> captureAndSave() async {
//     try {
//       // Ensure the widget is completely rendered
//       await Future.delayed(const Duration(milliseconds: 100));

//       RenderRepaintBoundary? boundary = _globalKey.currentContext
//           ?.findRenderObject() as RenderRepaintBoundary?;
//       if (boundary == null) {
//         throw Exception('Boundary is null');
//       }

//       // Ensure the boundary has no pending repaint requests
//       if (!boundary.debugNeedsPaint) {
//         var image = await boundary.toImage(pixelRatio: 3.0);
//         ByteData? byteData =
//             await image.toByteData(format: ImageByteFormat.png);
//         if (byteData == null) {
//           throw Exception('ByteData is null');
//         }
//         Uint8List pngBytes = byteData.buffer.asUint8List();

//         final status = await Permission.storage.request();
//         if (status.isGranted) {
//           final directory = await getExternalStorageDirectory();
//           if (directory == null) {
//             throw Exception('Directory is null');
//           }
//           String filePath = '${directory.path}/list_image.png';
//           File imgFile = File(filePath);
//           await imgFile.writeAsBytes(pngBytes);

//           // Save to gallery
//           final result =
//               await ImageGallerySaver.saveImage(pngBytes, name: "list_image");
//           if (result['isSuccess']) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Image saved to gallery')),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Failed to save image to gallery')),
//             );
//           }
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Permission denied')),
//           );
//         }
//       } else {
//         throw Exception('Boundary needs paint');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//       debugPrint("this is error:$e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final billedBy = widget.sendData['billedBy'] as Map<String, dynamic>? ?? {};
//     final billedTo = widget.sendData['billedTo'] as Map<String, dynamic>? ?? {};
//     final items = widget.sendData['items'] as List<dynamic>? ?? [];
//     final invoiceDetails =
//         widget.sendData['invoiceDetails'] as Map<String, dynamic>? ?? {};
//     final totalAmount = widget.totalAmount ?? '';

//     return Scaffold(
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         decoration: const BoxDecoration(
//           color: AppColor.whiteColor,
//           image: DecorationImage(
//               image: AssetImage("images/bgimg.png"), fit: BoxFit.cover),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(
//                         Icons.west,
//                         color: AppColor.appBarTxColor,
//                       ),
//                     ),
//                     Text(
//                       'Invoice',
//                       style: GoogleFonts.getFont(
//                         "Poppins",
//                         textStyle: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: AppColor.appBarTxColor,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         captureAndSave();
//                       },
//                       icon: const Icon(
//                         Icons.download_outlined,
//                         color: AppColor.appBarTxColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: RepaintBoundary(
//                   key: _globalKey,
//                   child: Container(
//                     padding: const EdgeInsets.all(16.0),
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border:
//                           Border.all(color: AppColor.primaryColor, width: 2),
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.white.withOpacity(0.5),
//                           blurRadius: 2,
//                           spreadRadius: 0,
//                           offset: const Offset(0, 0),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Image.asset(
//                             "images/logo.png",
//                             height: 100,
//                             width: 100,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Billed By:",
//                                       style: GoogleFonts.poppins(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold)),
//                                   Text("${billedBy['name'] ?? "Basit"}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text("${billedBy['address'] ?? "gujarat"}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text("${billedBy['phone'] ?? "7150112345"}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text("${billedBy['gst_in'] ?? "********"}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Billed To:",
//                                       style: GoogleFonts.poppins(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold)),
//                                   Text("Name: ${billedTo['name'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text("Address: ${billedTo['address'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text("Phone: ${billedTo['phone'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text("GSTIN: ${billedTo['gstin'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text("PAN: ${billedTo['pan'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text("Email: ${billedTo['email'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text(
//                                       "Bank Name: ${billedTo['bank_name'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text(
//                                       "Bank Account No: ${billedTo['bank_account_no'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text(
//                                       "IFSC Code: ${billedTo['ifsc_code'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                       "Invoice No: ${invoiceDetails['invoice_no'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text(
//                                       "Invoice Date: ${invoiceDetails['invoice_date'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                   Text(
//                                       "Order No: ${invoiceDetails['order_no'] ?? ""}",
//                                       style: GoogleFonts.poppins(fontSize: 14)),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         Text("Order Summary",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 16, fontWeight: FontWeight.bold)),
//                         const Divider(thickness: 2),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               flex: 1,
//                               child: Text(
//                                 "No.",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 3,
//                               child: Text(
//                                 "Item",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Text(
//                                 "Price",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Text(
//                                 "Quantity",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 1,
//                               child: Text(
//                                 "Total",
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Divider(thickness: 2),
//                         ListView.separated(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: items.length,
//                           itemBuilder: (context, index) {
//                             final item = items[index] as Map<String, dynamic>;
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: Text(
//                                     "${index + 1}",
//                                     style: GoogleFonts.poppins(fontSize: 14),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 3,
//                                   child: Text(
//                                     item['name'] ?? "",
//                                     style: GoogleFonts.poppins(fontSize: 14),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Text(
//                                     item['price'] ?? "",
//                                     style: GoogleFonts.poppins(fontSize: 14),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Text(
//                                     item['quantity'] ?? "",
//                                     style: GoogleFonts.poppins(fontSize: 14),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 1,
//                                   child: Text(
//                                     item['total'] ?? "",
//                                     style: GoogleFonts.poppins(fontSize: 14),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                           separatorBuilder: (context, index) {
//                             return const Divider();
//                           },
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Total",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               totalAmount,
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Shipping Charge :",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(
//                               widget.sendData['shipping_charge'] ?? "",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Tax ( sgst + cgst ):",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                               ),
//                             ),
//                             Text(
//                               widget.sendData['tax'] ?? "",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Divider(thickness: 2),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Sub Total",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               widget.sendData['sub_total'] ?? "",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const VerticalSpeacing(20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
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
    Key? key,
    required this.checkoutdetail,
  }) : super(key: key);

  final CheckoutreturnModel checkoutdetail;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final GlobalKey _globalKey = GlobalKey();

  Future<void> captureAndSave() async {
    try {
      // Ensure the widget is completely rendered
      await Future.delayed(const Duration(milliseconds: 100));

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
          final result =
              await ImageGallerySaver.saveImage(pngBytes, name: "list_image");
          if (result['isSuccess']) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image saved to gallery')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to save image to gallery')),
            );
          }
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
    final billedTo = checkoutDetail.contact;

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
                                  Text("Billed By:",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text("$billedBy",
                                      style: GoogleFonts.poppins(fontSize: 14)),
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
                                  Text("$billedTo",
                                      style: GoogleFonts.poppins(fontSize: 14)),
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
                              const VerticalSpeacing(20),
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
