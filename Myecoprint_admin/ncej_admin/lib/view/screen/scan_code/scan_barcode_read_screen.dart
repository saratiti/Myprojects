// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison, use_key_in_widget_constructors

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ncej_admin/controller/offer.dart';
import 'package:ncej_admin/controller/point_controller.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:ncej_admin/data/module/offer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BarcodeScannerReadScreen extends StatefulWidget {
  const BarcodeScannerReadScreen({Key? key}) : super(key: key);

  @override
  _BarcodeScannerReadScreenState createState() =>
      _BarcodeScannerReadScreenState();
}

class _BarcodeScannerReadScreenState extends State<BarcodeScannerReadScreen> {
  String scannedData = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PointController pointController = PointController();
  int? storeId;
  int? offerId;
  int? pointsToRedeem;

   Future<void> scanBarcode(BuildContext context) async {
    try {
      var result = await BarcodeScanner.scan();

      if (result != null &&
          result.rawContent != null &&
          result.format == BarcodeFormat.qr) {
        setState(() {
          scannedData = result.rawContent;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Barcode Information'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Scanned QR Code: $scannedData'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () async {
                    var redemptionResult = await onTapRedeemPoints(
                      context,
                      scannedData,
                    );

                    if (redemptionResult != null) {
                      print('Redemption successful');
                    } else {
                      print('Redemption not successful');
                    }

                    Navigator.of(context).pop(); // Close the dialog after redeeming points
                  },
                  child: const Text('Redeem'),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog(
            context, 'Error Scanning QR Code', 'Result is null or missing properties.');
      }
    } catch (e) {
      print('Error scanning QR code: $e');
      showErrorDialog(
          context, 'Error Scanning QR Code', 'Error: $e');
    }
  }


  void showErrorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scanned Barcode: ${scannedData ?? "N/A"}'),
              Text('Error Content: $content'), // Display additional error information
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
  

Future<Map<String, dynamic>?> onTapRedeemPoints(
  BuildContext context,
  String scannedData,
) async {
  try {
    // Parse the barcode data to get storeId, offerId, and pointsToRedeem
    Map<String, dynamic> barcodeData = parseBarcodeData(scannedData);

    if (barcodeData.isEmpty) {
      print('Invalid barcode data format');
      return null; // or handle accordingly
    }

    int storeId = barcodeData['storeId'];
    int offerId = barcodeData['offerId'];
    int pointsToRedeem = barcodeData['pointsToRedeem'];

    var result = await pointController.redeemPoints(
      storeId: storeId,
      offerId: offerId,
      pointsRedeemed: pointsToRedeem,
      scannedData: scannedData,
    );

    print('Backend Response: $result');

    // Handle the response as before

  } catch (e) {
    if (kDebugMode) {
      print("Error in redeeming points: $e");
    }

    return null;
  }
}

Map<String, dynamic> parseBarcodeData(String scannedData) {
  try {
    // Assuming the scanned data format is "#STORE_ID_OFFER_ID_POINTS_TO_REDEEM"
    List<String> parts = scannedData.split('_');

    if (parts.length == 4) {
      return {
        'storeId': int.tryParse(parts[1]) ?? 0,
        'offerId': int.tryParse(parts[2]) ?? 0,
        'pointsToRedeem': int.tryParse(parts[3]) ?? 0,
      };
    } else {
      print('Invalid barcode data format');
      return {};
    }
  } catch (e) {
    print('Error parsing barcode data: $e');
    return {};
  }
}


  void showCustomErrorDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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

  Future<bool> checkPreviousRedemption(
    BuildContext context,
    int storeId,
    int offerId,
  ) async {
    // Implement the logic to check if the user has already redeemed points
    // for the given storeId and offerId. You may use shared preferences,
    // database, or any other method to store and retrieve this information.

    // For example, using shared preferences:
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String key = 'REDEMPTION_${storeId}_$offerId';
    bool redeemed = prefs.getBool(key) ?? false;

    return redeemed;
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showRedeemPointsMessage(int pointsRedeemed) {
    // Use the context property directly
    final scaffoldKeyContext = _scaffoldKey.currentContext;

    // Check if the Scaffold context is not null before showing SnackBar
    if (scaffoldKeyContext != null) {
      ScaffoldMessenger.of(scaffoldKeyContext).showSnackBar(
        SnackBar(
          content: Text('Redeemed $pointsRedeemed points successfully!'),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Redeem Points'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Points Redeemed: $pointsRedeemed'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              data: scannedData,
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
