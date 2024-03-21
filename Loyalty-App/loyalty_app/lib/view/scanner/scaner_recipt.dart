import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:loyalty_app/core/app_export.dart';

class ReceiptScannerPage extends StatefulWidget {
  const ReceiptScannerPage({Key? key}) : super(key: key);

  @override
  _ReceiptScannerPageState createState() => _ReceiptScannerPageState();
}

class _ReceiptScannerPageState extends State<ReceiptScannerPage> {
  String _scanResult = 'Scan a receipt by clicking the button below';

  @override
  void initState() {
    super.initState();
    _scanReceipt();
  }

  Future<void> _scanReceipt() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        _scanResult = 'Scanned data: ${result.rawContent}';
      });
    } catch (e) {
      setState(() {
        _scanResult = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ElevatedButton(
  onPressed: _scanReceipt,
  child: SizedBox(
    width: double.infinity, // Adjust width to fill the available space
    height: 60, // Adjust height as needed
    child: Center(
      child: Text(
        'Scan Receipt',
        style: TextStyle(fontSize: 18),
      ),
    ),
  )),
            SizedBox(height: 20),
            Text(
              _scanResult,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
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
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        title: Text(
          "Scanner",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
