// Import necessary packages and dependencies
// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ncej_admin/controller/api_helper.dart';
import 'package:ncej_admin/view/screen/barcode/barcode_read.dart';
import 'package:ncej_admin/view/screen/scan_code/scan_barcode_read_screen.dart';

import '../../../core/app_export.dart';

class BarcodeGenerator extends StatefulWidget {
  const BarcodeGenerator({super.key});

  @override
  _BarcodeGeneratorState createState() => _BarcodeGeneratorState();
}

class _BarcodeGeneratorState extends State<BarcodeGenerator> {
  String barcodeData = '56432';
  bool isBarcodeVisible = false;
  Image? qrCodeImage;

  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Barcode generated successfully!'),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

  Future<void >generateBarcodeAndQRCode(String dataToEncode) async {
    try {
      Map<String, dynamic> requestBody = {
        'dataToEncode': dataToEncode,
      };
      dynamic response = await ApiHelper()
          .postDioForImage('/api/barcodes/generateBarcode', requestBody);

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
      appBar: buildAppBar(context),
      body: Center(
        child: Column(
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
            MyElevatedButton(
              onTap: () {
                generateBarcodeAndQRCode(barcodeData);
                showSuccessSnackBar();
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
    );
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

CustomAppBar buildAppBar(BuildContext context) {
  final localization = AppLocalizationController.to;
  final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return CustomAppBar(
    height: 50.v,
    leadingWidth: 52.h,
    leading: CustomImageView(
      svgPath: (textDirection == TextDirection.rtl)
          ? ImageConstant.imgArrowright
          : ImageConstant.imgArrowleftOnprimary,
      height: 24.0,
      width: 24.0,
      margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
      onTap: () => onTapArrowleft(context),
    ),
    centerTitle: true,
    title: AppbarTitle(text: "Barcode".tr),
  );
}

void onTapArrowleft(BuildContext context) {
  Navigator.pop(context);
}
