import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:loyality_cashier/core/app_export.dart';

class ReceiptScannerPage extends StatefulWidget {
  const ReceiptScannerPage({Key? key}) : super(key: key);

  @override
  _ReceiptScannerPageState createState() => _ReceiptScannerPageState();
}

class _ReceiptScannerPageState extends State<ReceiptScannerPage> {
  String scannedData = "";

  List<List<String>> parseScannedData(String scannedData) {
    List<List<String>> dataRows = [];
    List<String> lines = scannedData.split('\n');
    for (String line in lines) {
      List<String> cells = line.split('\t');
      dataRows.add(cells);
    }
    return dataRows;
  }

 void showSummaryInvoice(BuildContext context) async {
  try {
    ScanResult result = await BarcodeScanner.scan();
    setState(() {
      scannedData = result.rawContent;
    });
    List<String> firstRowCells = scannedData.split('\n').first.split('\t');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Barcode Scanned'),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: firstRowCells.map((cell) {
                return DataColumn(
                  label: Text(
                    cell,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
              rows: parseScannedData(scannedData).skip(1).map((cells) {
                return DataRow(
                  cells: cells.map((cell) {
                    return DataCell(Text(cell));
                  }).toList(),
                );
              }).toList(),
            ),
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
  } catch (e) {
    if (kDebugMode) {
      print('Error scanning barcode: $e');
    }
  }
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
              onPressed: () {
                showSummaryInvoice(context);
              },
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
