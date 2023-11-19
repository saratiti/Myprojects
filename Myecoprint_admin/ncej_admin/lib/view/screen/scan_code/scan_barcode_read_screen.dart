// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison, use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/services.dart';
import 'package:ncej_admin/controller/barcodes.dart';
import 'package:ncej_admin/core/app_export.dart';

class BarcodeScannerReadScreen extends StatefulWidget {
  const BarcodeScannerReadScreen({super.key});

  @override
  _BarcodeScannerReadScreenState createState() =>
      _BarcodeScannerReadScreenState();
}

class _BarcodeScannerReadScreenState extends State<BarcodeScannerReadScreen> {
  String scannedData = "";
  BarcodeController barcodeController=BarcodeController();


  
  Future<void> scanBarcode(BuildContext context) async {
  try {
    ScanResult scanResult = await BarcodeScanner.scan();

    String barcode = scanResult.rawContent;
    setState(() {
      scannedData = barcode;
    });
    final response = await barcodeController.checkBarcode(barcode);

    if (response != null) {
      final offerIdFromBarcode = response['offer']['offer_id'];
      final offerIdFromResponse = response['offer']['offer_id'];
      final storeFromBarcode = response['store']['name_arabic'];
      final storeFromResponse = response['store']['name_arabic'];

      if (offerIdFromBarcode == offerIdFromResponse && storeFromBarcode == storeFromResponse) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Barcode Information'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Barcode Value: $barcode'),
                  Text('Offer Name: ${response['offer']['offer_name_arabic']}'),
                  Text('Store Name: $storeFromResponse'),
                  Text('Branch Email: ${response['branch']['email']}'),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Barcode Mismatch'),
              content: const Text('The scanned barcode does not match the offer or store.'),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Barcode Not Found'),
            content: const Text('The scanned barcode is not found or does not match.'),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.cameraAccessDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Camera Permission Denied'),
            content: const Text('Please grant camera permission to scan barcodes.'),
            actions: [
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      if (kDebugMode) {
        print('Error scanning barcode: $e');
      }
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
          children: <Widget>[
            const Text(
              'Scanned Barcode:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
               scannedData,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            BarcodeWidget(
              data:  scannedData,
              width: 200,
              height: 100,
              barcode: Barcode.qrCode(),
            ),
            const SizedBox(height: 30),
            MyElevatedButton(
             onTap: () => scanBarcode(context),
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
    title: AppbarTitle(text:"lbl35".tr),
  );
}

void onTapArrowleft(BuildContext context) {
  Navigator.pop(context);
}
