// Import necessary packages and dependencies
// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ncej_admin/controller/api_helper.dart';
import 'package:ncej_admin/controller/provider/company_provider.dart';
import 'package:ncej_admin/controller/store_controller.dart';
import 'package:ncej_admin/data/module/store.dart';
import 'package:ncej_admin/view/screen/barcode/barcode_read.dart';
import 'package:ncej_admin/view/screen/scan_code/scan_barcode_read_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/app_export.dart';


class BarcodeGenerator extends StatefulWidget {
  const BarcodeGenerator({super.key});

  @override
  _BarcodeGeneratorState createState() => _BarcodeGeneratorState();
}

class _BarcodeGeneratorState extends State<BarcodeGenerator> {
 String barcodeData = '';
  bool isBarcodeVisible = false;
  Image? qrCodeImage;

  int enteredNumberOfPoints = 1;
late int selectedCompanyId;
  int selectedStoreId = 1;

  List<int> storeIds = []; 
 

  @override
  void initState() {
    super.initState();
     selectedCompanyId = Provider.of<CompanyProvider>(context, listen: false).companyId;
    fetchStoreIdsByCompanyId(selectedCompanyId); // Fetch storeIds initially
  }

Future<void> fetchStoreIdsByCompanyId(int companyId) async {
  try {
    List<Store> stores = await StoreController().getStoresByCompanyId(companyId);
    setState(() {
     
      storeIds = stores.map((store) => store.id ?? 0).toList();
      selectedStoreId = storeIds.isNotEmpty ? storeIds.first : 0; 
    });
  } catch (error) {
    print("Error fetching storeIds: $error");
  }
}

  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Barcode generated successfully!'),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

  Future<void> generateBarcodeAndQRCode(String dataToEncode, int numberOfPoints, int storeId) async {
  try {
    Map<String, dynamic> requestBody = {
      'dataToEncode': dataToEncode,
      'number_point': numberOfPoints,  
      'store_id': storeId,
    };

    dynamic response = await ApiHelper().postDioForImage('/api/barcodes/generateBarcode', requestBody);

    if (response is Uint8List) {
      Uint8List qrCodeImageBytes = response;
      MemoryImage qrCodeMemoryImage = MemoryImage(qrCodeImageBytes);
      setState(() {
        qrCodeImage = Image(image: qrCodeMemoryImage);
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
}


  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: buildAppBar(context,"lbl34"),
    body: 
      Center(
         child: SingleChildScrollView(
      child:
      
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isBarcodeVisible)
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: barcodeData,
              width: 200,
              height: 200,
            ),
          const SizedBox(height: 20.0),
          
         Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Store:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(width: 20.0),
                  DropdownButton<int>(
                    value: selectedStoreId,
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedStoreId = newValue!;
                      });
                    },
                    items: storeIds.map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ],
              ),
          const SizedBox(height: 10.0),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter Number Points:',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(width: 20.0),
            
             
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: SizedBox( 
                  width: 100.0, 
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        enteredNumberOfPoints = int.tryParse(value) ?? 1;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          
          MyElevatedButton(
            onTap: () {
              generateBarcodeAndQRCode(barcodeData, enteredNumberOfPoints, selectedStoreId);
            },
          ),
          RefundElevatedButton(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ScanCodeScreen();
                  },
                ),
              );
            },
          ),
          ScanElevatedButton(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const BarcodeScannerReadScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
  ));
}
}

class MyElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  const MyElevatedButton({Key? key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 20),
        CustomElevatedButton(
          width: 236.h,
          text: "Generate New Barcode".tr,
          rightIcon: Container(
            margin: EdgeInsets.only(left: 22.h),
            child: CustomImageView(
              svgPath: ImageConstant.imgTicket,
            ),
          ),
          buttonStyle: CustomButtonStyles.fillLightGreen,
          onTap: onTap,
        ),
      ],
    );
  }
}

class RefundElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  const RefundElevatedButton({Key? key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 20),
        CustomElevatedButton(
          width: 236.h,
          text: "Refund Barcode".tr,
          rightIcon: Container(
            margin: EdgeInsets.only(left: 22.h),
            child: CustomImageView(
              svgPath: ImageConstant.imgTicket,
            ),
          ),
          buttonStyle: CustomButtonStyles.fillLightGreen,
          onTap: onTap,
        ),
      ],
    );
  }
}

class ScanElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  const ScanElevatedButton({Key? key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 20),
        CustomElevatedButton(
          width: 236.h,
          text: "lbl35".tr,
          rightIcon: Container(
            margin: EdgeInsets.only(left: 22.h),
            child: CustomImageView(
              svgPath: ImageConstant.imgTicket,
            ),
          ),
          buttonStyle: CustomButtonStyles.fillLightGreen,
          onTap: onTap,
        ),
      ],
    );
  }
}

