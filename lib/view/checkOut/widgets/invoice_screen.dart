// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rjfruits/model/checkout_return_model.dart';
import 'package:rjfruits/res/components/colors.dart';
import 'package:rjfruits/res/components/vertical_spacing.dart';
import 'package:uuid/uuid.dart';

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

  Future<void> captureAndSave(BuildContext context) async {
    try {
      debugPrint("changes");
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          final pdf = pw.Document();
          const itemsPerPage = 2; // Define how many items per page

          // Function to create a page
          pw.Page createPage(List<dynamic> items) {
            return pw.Page(
              build: (pw.Context context) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 20),
                    pw.Center(
                      child: pw.Text(
                        "Rajistan-Dry-Fruits",
                        style: pw.TextStyle(
                          fontSize: 20,
                          color: PdfColor.fromInt(AppColor.primaryColor.value),
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Invoice Number:",
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text(widget.checkoutdetail.data.order_invoice_number,
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text("Billed By:",
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text(" RAJASTHAN DRY FRUIT HOUSE",
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text(
                            "Address :GF-8, CAMPUS CORNER-2, OPP AUDA GARDEN 100 FT ROAD,PRAHALAD NAGAR, AHMEDABAD, Ahmedabad, Gujarat, 380015",
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text("GSTIN: 24ABEFR0010J1ZQ",
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text("Email: rajasthandryfruits21@gmail.com",
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text("MO.NO : 8141066633",
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Invoice Number:",
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text(widget.checkoutdetail.data.order_invoice_number,
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text("Billed to:",
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text(widget.checkoutdetail.data.fullName,
                            style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text(
                            "Address: ${widget.checkoutdetail.data.address}",
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text("Phone: ${widget.checkoutdetail.data.contact}",
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text("GSTIN: ********",
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                        pw.Text(widget.checkoutdetail.data.createdOn.toString(),
                            style: pw.TextStyle(
                                fontSize: 14,
                                color: PdfColor.fromInt(Colors.black.value))),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text("Order Items:",
                        style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.black.value))),
                    for (var item in items)
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Product Name: ${item.product.title}",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromInt(Colors.black.value))),
                          pw.Text("Price: ${item.product.price}",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromInt(Colors.black.value))),
                          pw.Text("Quantity: ${item.qty}",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromInt(Colors.black.value))),
                          pw.Text("HSN CODE: ${item.qty}",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromInt(Colors.black.value))),
                          pw.Text("DISC(%): ${item.qty}",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromInt(Colors.black.value))),
                          pw.Text("TAX(%): ${item.qty}",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromInt(Colors.black.value))),
                          pw.SizedBox(height: 20),
                        ],
                      ),
                    if (items.length <= itemsPerPage) ...[
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Amount Before Tax",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromInt(Colors.black.value))),
                          pw.Text(widget.checkoutdetail.data.total.toString(),
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromInt(Colors.black.value))),
                        ],
                      ),
                      widget.checkoutdetail.data.state == "gujarat"
                          ? pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text("CGST(5%)",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromInt(
                                            Colors.black.value))),
                                pw.Text(
                                    widget.checkoutdetail.data.tax.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        color: PdfColor.fromInt(
                                            Colors.black.value))),
                              ],
                            )
                          : pw.SizedBox(height: 1),
                      widget.checkoutdetail.data.state == "gujarat"
                          ? pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text("SGST(5%)",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromInt(
                                            Colors.black.value))),
                                pw.Text(
                                    widget.checkoutdetail.data.tax.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        color: PdfColor.fromInt(
                                            Colors.black.value))),
                              ],
                            )
                          : pw.SizedBox(height: 1),
                      widget.checkoutdetail.data.state != "gujarat"
                          ? pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text("IGST(5%)",
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromInt(
                                            Colors.black.value))),
                                pw.Text(
                                    widget.checkoutdetail.data.tax.toString(),
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        color: PdfColor.fromInt(
                                            Colors.black.value))),
                              ],
                            )
                          : pw.SizedBox(height: 1),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Shipment Charges",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromInt(Colors.black.value))),
                          pw.Text(
                              widget.checkoutdetail.data.shippingCharges
                                  .toString(),
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromInt(Colors.black.value))),
                        ],
                      ),
                      pw.Divider(
                          color: PdfColor.fromInt(AppColor.primaryColor.value)),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Sub-Total",
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromInt(Colors.black.value))),
                          pw.Text(
                              widget.checkoutdetail.data.subTotal.toString(),
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  color: PdfColor.fromInt(Colors.black.value))),
                        ],
                      ),
                    ],
                  ],
                );
              },
            );
          }

          // Split order items into chunks of 'itemsPerPage'
          for (int i = 0;
              i < widget.checkoutdetail.data.orderItems.length;
              i += itemsPerPage) {
            var itemsChunk = widget.checkoutdetail.data.orderItems.sublist(
                i,
                i + itemsPerPage > widget.checkoutdetail.data.orderItems.length
                    ? widget.checkoutdetail.data.orderItems.length
                    : i + itemsPerPage);
            pdf.addPage(createPage(itemsChunk));
          }

          String uuid = const Uuid().v1();
          // Save PDF to file
          if (await _requestPermissions()) {
            final directory = Directory('/storage/emulated/0/Download');

            String filePath = '${directory.path}/invoice$uuid.pdf';
            debugPrint('Saving PDF to: $filePath'); // Debug print statement

            final File file = File(filePath);
            await file.writeAsBytes(await pdf.save());

            // Verify if the file exists
            if (await file.exists()) {
              debugPrint(
                  'PDF file successfully saved'); // Debug print statement

              // Show success message
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PDF saved to Downloads folder')),
              );
            } else {
              throw Exception('File was not saved successfully');
            }
          } else {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Permission denied')),
            );
          }
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
          debugPrint("Error in captureAndSave: $e");
        }
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      debugPrint("Error in captureAndSave: $e");
    }
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted) {
        return true;
      } else if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }
    } else if (Platform.isIOS) {
      return await Permission.photos.request().isGranted;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final checkoutDetail = widget.checkoutdetail.data;
    final orderItems = checkoutDetail.orderItems;
    final billedBy = checkoutDetail.fullName;
    debugPrint('Checkout Details: ${widget.checkoutdetail.data.fullName}');
    debugPrint('Checkout Details: ${widget.checkoutdetail.data.state}');

    String taxLabel =
        widget.checkoutdetail.data.state.trim().toLowerCase() == 'gujarat'
            ? "Tax (sgst + cgst)"
            : "Tax (igst)";
    debugPrint('Tax Label: $taxLabel');
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
                        captureAndSave(context);
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
                child: Builder(builder: (BuildContext context) {
                  return RepaintBoundary(
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
                                    Text("RAJASTHAN DRY FRUIT HOUSE",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                        "Address :GF-8, CAMPUS CORNER-2, OPP AUDA GARDEN 100 FT ROAD,PRAHALAD NAGAR, AHMEDABAD, Ahmedabad, Gujarat, 380015",
                                        style:
                                            GoogleFonts.poppins(fontSize: 14)),
                                    Text(
                                      "GSTIN:24ABEFR0010J1ZQ",
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                    Text(
                                      "MO.NO : 8141066633",
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                    Text(
                                      "Email:  rajasthandryfruits21@gmail.com",
                                      style: GoogleFonts.poppins(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
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
                                        style:
                                            GoogleFonts.poppins(fontSize: 14)),
                                    Text("Billed To:",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    Text(billedBy,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    Text(widget.checkoutdetail.data.address,
                                        style:
                                            GoogleFonts.poppins(fontSize: 14)),
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
                                Text("HSN CODE: ${item.qty}",
                                    style: GoogleFonts.poppins(fontSize: 14)),
                                Text("DISC(%): ${item.qty}",
                                    style: GoogleFonts.poppins(fontSize: 14)),
                                Text("TAX(%): ${item.qty}",
                                    style: GoogleFonts.poppins(fontSize: 14)),
                                const VerticalSpeacing(8),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Amount Before Tax",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
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
                              Text("Shipment Charges",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                widget.checkoutdetail.data.shippingCharges
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Visibility(
                            visible:
                                widget.checkoutdetail.data.state == 'gujarat'
                                    ? false
                                    : true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("IGST",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  widget.checkoutdetail.data.shippingCharges
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                widget.checkoutdetail.data.state == 'gujarat'
                                    ? true
                                    : false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("CGST(5%)",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  widget.checkoutdetail.data.shippingCharges
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                widget.checkoutdetail.data.state == 'gujarat'
                                    ? true
                                    : false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("SGST(5%)",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  widget.checkoutdetail.data.shippingCharges
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: AppColor.primaryColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sub-Total",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
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
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
