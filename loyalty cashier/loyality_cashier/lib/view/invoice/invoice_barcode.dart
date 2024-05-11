// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyality_cashier/controller/api_helper.dart';
import 'package:loyality_cashier/controller/invoice.dart';
import 'package:loyality_cashier/core/app_export.dart';
import 'package:loyality_cashier/model/invoice.dart';
import 'package:loyality_cashier/widgets/custom_elevated_button.dart'; 

class BarcodeGenerator extends StatefulWidget {
  const BarcodeGenerator({super.key});

  @override
  _BarcodeGeneratorState createState() => _BarcodeGeneratorState();
}

class _BarcodeGeneratorState extends State<BarcodeGenerator> {
  String barcodeData = '';
  bool isBarcodeVisible = false;
  Image? qrCodeImage;
  int selectedInvoiceId = 1;
  List<int> InvoiceIds = [];
  int enteredNumberOfPoints = 1;
  int? invoice_id;
  double? total_amount;

  TextEditingController invoiceIdController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchInvoiceId(); 
    fetchTotalAmount();
  }
Future<void> fetchInvoiceId() async {
    try {
      List<Invoice> invoices = await InvoiceController().getAllInvoice();
      setState(() {
       
        InvoiceIds = invoices.map<int>((invoice) => invoice.invoiceId).toList();
        selectedInvoiceId = InvoiceIds.isNotEmpty ? InvoiceIds.first : 0;
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching InvoiceIds: $error");
      }
    }
  }
  Future<void> fetchTotalAmount() async {
  try {
   
    Invoice selectedInvoice = await InvoiceController().getInvoiceById(selectedInvoiceId);
    setState(() {
      total_amount = selectedInvoice.totalAmount;
      totalAmountController.text = total_amount.toString(); 
    });
  } catch (error) {
    if (kDebugMode) {
      print("Error fetching total amount: $error");
    }
  }
}

Future<void> generateBarcodeAndQRCode() async {
  if (total_amount != null) {
    try {
     
      Invoice selectedInvoice = await InvoiceController().getInvoiceById(selectedInvoiceId);
      invoice_id = selectedInvoice.invoiceId;
      
    
      Map<String, dynamic> requestBody = {
        'invoice_id': invoice_id,
        'total_amount': total_amount,
      };

      
      dynamic response = await ApiHelper().postDioForImage('/api/invoices/barcode', requestBody);

      if (response is Uint8List) {
        Uint8List qrCodeImageBytes = response;
        MemoryImage qrCodeMemoryImage = MemoryImage(qrCodeImageBytes);
        setState(() {
          qrCodeImage = Image(image: qrCodeMemoryImage);
           totalAmountController.text = selectedInvoice.totalAmount.toString();
          isBarcodeVisible = true;
        });
      } else {
        if (kDebugMode) {
          print('Failed to generate QR code: Invalid response type');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error generating QR code: $e');
      }
    }
  } else {
    if (kDebugMode) {
      print('Invoice ID and Total Amount are required');
    }
  }
}


   @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Invoice Details',
              style: CustomTextStyles.bodyMediumMerriweatherBlack900,
            ),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Select Invoice:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(width: 20.0),
                  DropdownButton<int>(
                    value: selectedInvoiceId ,
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedInvoiceId= newValue!;
                        fetchTotalAmount(); 
                      });
                    },
                    items: InvoiceIds.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString(),style: TextStyle(color: appTheme.deepOrange800)),
                        
                      );
                    }).toList(),
                  ),
                ],
              ),
          const SizedBox(height: 10.0),
const SizedBox(height: 20),
TextField(
  controller: totalAmountController,
  keyboardType: TextInputType.number,
  onChanged: (value) {
    setState(() {
      total_amount = double.tryParse(value);
    });
  },
  style: TextStyle(color: appTheme.deepOrange800), // Set the text color
  decoration: InputDecoration(
    labelText: 'Total Amount',
    labelStyle: TextStyle(color: appTheme.deepOrange800), 
    prefixIcon: Icon(Icons.money, color: appTheme.deepOrange800), 
    border: const OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appTheme.deepOrange800, width: 2.0),
      borderRadius: BorderRadius.circular(10.0),
    ),
    hoverColor: appTheme.deepOrange800.withOpacity(0.2), 
  ),
),


            const SizedBox(height: 40),
            Center(
              child: CustomElevatedButton(
                text: 'Generate Barcode',
                onPressed: () {
                  generateBarcodeAndQRCode();
                },
                buttonStyle: CustomButtonStyles.fillPrimary,
              ),
            ),
            const SizedBox(height: 20),
            if (invoice_id != null && total_amount != null)
              Center(
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: 'Invoice ID: $invoice_id\nTotal Amount: $total_amount',
                  width: 200,
                  height: 200,
                ),
              ),
          ],
        ),
      ),
    );
  }
  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
          "Generate Barcode",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
