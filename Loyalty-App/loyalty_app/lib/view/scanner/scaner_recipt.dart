// ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:loyalty_app/controller/invoice.dart';
import 'package:loyalty_app/core/app_export.dart';

class ReceiptScannerPage extends StatefulWidget {
  const ReceiptScannerPage({Key? key}) : super(key: key);

  @override
  _ReceiptScannerPageState createState() => _ReceiptScannerPageState();
}

class _ReceiptScannerPageState extends State<ReceiptScannerPage> {
String scannedData = "";
InvoiceController invoiceController = InvoiceController();

Future<void> scanBarcode() async {
  try {
    ScanResult result = await BarcodeScanner.scan();

    if (result.rawContent != null) {
      setState(() {
        scannedData = result.rawContent;
      });

      if (result.type == ResultType.Barcode) {
        int? invoiceId = parseBarcodeData(scannedData);
        if (invoiceId != null) {
          connectToBackend(context,invoiceId);
        } else {
          showErrorDialog(context, 'Error Scanning Barcode', 'Failed to parse invoice ID');
        }
      } else {
        showErrorDialog(context, 'Error Scanning Barcode', 'Unsupported barcode format.');
      }
    } else {
      showErrorDialog(context, 'Error Scanning QR Code', 'Result is null or missing properties.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error scanning QR code: $e');
    }
    showErrorDialog(context, 'Error Scanning QR Code', 'Error: $e');
  }
}

int? parseBarcodeData(String barcodeValue) {
  try {
    if (kDebugMode) {
      print('Raw Barcode Data: $barcodeValue');
    }
    List<String> lines = barcodeValue.split('\n');
    if (kDebugMode) {
      print('Lines after split: $lines');
    }

    // Iterate over each line to find the line containing the invoice ID
    for (String line in lines) {
      // Check if the line contains "invoice_id:"
      if (line.startsWith('invoice_id:')) {
        // Extract the invoice ID from the line
        int? invoiceId = int.tryParse(line.substring('invoice_id:'.length).trim());
        
        // Return the invoice ID if it's valid
        if (invoiceId != null) {
          return invoiceId;
        } else {
          if (kDebugMode) {
            print('Invalid invoice ID extracted from barcode data');
          }
          return null;
        }
      }
    }

    // If no line contains the invoice ID, print an error message
    if (kDebugMode) {
      print('Invoice ID not found in barcode data');
    }
    return null;
  } catch (e) {
    if (kDebugMode) {
      print('Error parsing barcode data: $e');
    }
    return null;
  }
}



void connectToBackend(BuildContext context, int? invoiceId) async {
  try {
    var result = await InvoiceController().collectPoint(invoiceId: invoiceId!);

    String message = result['message'] ?? '';
    double totalAmount = result['totalAmount'] ?? 0.0;

    if (message == 'Loyalty points updated successfully') {
      if (kDebugMode) {
        print('Transaction successful');
      }
      showSuccessDialog(context, 'Transaction Successful', 'Total Amount: $totalAmount',totalAmount);
    } else {
      if (kDebugMode) {
        print('Transaction unsuccessful');
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              message,
              style: const TextStyle(color: Colors.black), // Set text color to black
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error connecting to backend: $e');
    }
    showErrorDialog(context, 'Error', 'An unexpected error occurred while connecting to the backend.');
  }
}


Widget buildDialog(BuildContext context, String title, String content) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Container(
      margin: EdgeInsets.only(left: 41.h, right: 41.h, bottom: 150.v),
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
      decoration: AppDecoration.fillWhiteA
          .copyWith(borderRadius: BorderRadiusStyle.circleBorder27),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 24.v, right: 59.h),
              child: Text(
                title, 
                style: theme.textTheme.displaySmall,
              ),
            ),
          ),
          SizedBox(height: 46.v),
          Align(
            alignment: Alignment.center,
            child: Text(
              content, 
              style: const TextStyle(
                color: Colors.black, // Specify your desired text color here
                fontSize: 16, // You can adjust the font size as needed
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}



void showLoyaltyPointsDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Loyalty Points'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}





void showSuccessDialog(BuildContext context, String title, String content, double totalAmount) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(content),
            const SizedBox(height: 10),
         Text('$totalAmount',
              style: TextStyle(color: appTheme.amber300)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

void showErrorDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: scanBarcode,
              child: const SizedBox(
                width: double.infinity,
                height: 60,
                child: Center(
                  child: Text(
                    'Scan Receipt',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              scannedData,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        elevation: 0,
        leadingWidth: 40.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appTheme.deepOrange800,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        title: const Text(
          "Scanner",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}