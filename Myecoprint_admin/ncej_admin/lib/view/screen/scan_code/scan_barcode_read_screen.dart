// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison, use_key_in_widget_constructors

import 'dart:async';


import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ncej_admin/controller/point_controller.dart';
import 'package:ncej_admin/core/app_export.dart';
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

//    Future<void> scanBarcode(BuildContext context) async {
//   try {
//     var result = await BarcodeScanner.scan();

//     if (result != null &&
//         result.rawContent != null &&
//         result.format == BarcodeFormat.qr) {
//       setState(() {
//         scannedData = result.rawContent;
//       });



//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Barcode Information'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Scanned QR Code: $scannedData'),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Close'),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   var redemptionResult = await onTapRedeemPoints(
//                     context,
//                     scannedData,
//                   );

//                   if (redemptionResult != null) {
//                     if (redemptionResult['success'] == true) {
//                       int pointsRedeemed = redemptionResult['redeemedPoints'] ?? 0;
//                       print('Redemption successful');
//                       print(
//                           'StoreId: ${redemptionResult['barcodeInfo']['store_id']}, OfferId: ${redemptionResult['barcodeInfo']['offer_id']}, PointsRedeemed: $pointsRedeemed');

//                       showRedeemPointsMessage(pointsRedeemed);
//                     } else {
//                       print('Redemption not successful');
//                       showCustomErrorDialog(
//                         context,
//                         'Redemption Failed',
//                         'Invalid response format',
//                       );
//                     }
//                   } else {
//                     print('Redemption not successful');
//                     showCustomErrorDialog(
//                       context,
//                       'Redemption Failed',
//                       'Invalid response format',
//                     );
//                   }

//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Redeem'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       showErrorDialog(
//           context, 'Error Scanning QR Code', 'Result is null or missing properties.');
//     }
//   } catch (e) {
//     print('Error scanning QR code: $e');
//     showErrorDialog(context, 'Error Scanning QR Code', 'Error: $e');
//   }
// }

Future<void> scanBarcode(BuildContext context) async {
  try {
    ScanResult result = await BarcodeScanner.scan();

    if (result != null && result.rawContent != null) {
      setState(() {
        scannedData = result.rawContent;
      });
      if (result.type == ResultType.Barcode) {
  
        String barcodeFormat = result.format.toString();
        print('Barcode Format: $barcodeFormat');

       
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
                  Text('Barcode Format: $barcodeFormat'),
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
                      if (redemptionResult['success'] == true) {
                        int pointsRedeemed = redemptionResult['redeemedPoints'] ?? 0;
                        print('Redemption successful');
                        print(
                            'StoreId: ${redemptionResult['barcodeInfo']['store_id']}, OfferId: ${redemptionResult['barcodeInfo']['offer_id']}, PointsRedeemed: $pointsRedeemed');

                        showRedeemPointsMessage(pointsRedeemed);
                      } else {
                        print('Redemption not successful');
                        showCustomErrorDialog(
                          context,
                          'Redemption Failed',
                          'Invalid response format',
                        );
                      }
                    } else {
                      print('Redemption not successful');
                      showCustomErrorDialog(
                        context,
                        'Redemption Failed',
                        'Invalid response format',
                      );
                    }

                    Navigator.of(context).pop();
                  },
                  child: const Text('Redeem'),
                ),
              ],
            );
          },
        );
      } else {
        showErrorDialog(context, 'Error Scanning Barcode', 'Unsupported barcode format.');
      }
    } else {
      showErrorDialog(context, 'Error Scanning QR Code', 'Result is null or missing properties.');
    }
  } catch (e) {
    print('Error scanning QR code: $e');
    showErrorDialog(context, 'Error Scanning QR Code', 'Error: $e');
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
              Text('Error Content: $content'), 
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
  

void showCustomErrorDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scanned Barcode: N/A'),
            Text('Error Content: $content'), 
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
    Map<String, dynamic> barcodeData = parseBarcodeData(scannedData);
    if (barcodeData.isEmpty) {
      print('Invalid barcode data format');
      return null;
    }

    int storeId = barcodeData['storeId'];
    int offerId = barcodeData['offerId'];
    int pointsToRedeem = barcodeData['currentNumberPoint'] ?? 0;

    var result = await pointController.redeemPoints(
      storeId: storeId,
      offerId: offerId,
      pointsRedeemed: pointsToRedeem,
      scannedData: scannedData,
    );

    print('Backend Response: $result');

    if (storeId == 0 || offerId == 0 || pointsToRedeem == 0) {
      print('Invalid values extracted from barcode data');
      return null;
    }


    if (result != null && result['message'] != null) {
      String successMessage = result['message'];
      print('Redemption successful: $successMessage');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Redemption Successful'),
            content: Text(successMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      return result;
    } else {
      print("Redemption not successful");
      return null;
    }

  } catch (e) {
    if (e is DioError) {
      print("DioError response: ${e.response}");
      print("DioError request: ${e.requestOptions}");

      if (e.response?.statusCode == 400) {
       
        String errorMessage = e.response?.data['error'] ?? 'Redemption failed';
        print("Error in redeeming points: $errorMessage");

    
        if (errorMessage == 'User has already redeemed from this offer and store') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Redemption Failed'),
                content: Text(errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          print("Error in redeeming points: $errorMessage");
        }
      } else {
        print("Error in redeeming points: $e");
      }
    }

    print("Redemption not successful");
    return null;
  }
}





Map<String, dynamic> parseBarcodeData(String barcodeValue) {
  try {
    print('Raw Barcode Data: $barcodeValue');

    List<String> parts;

    if (barcodeValue.startsWith('#')) {
      parts = barcodeValue.substring(1).split('#');
    } else {
      print('Invalid barcode data format: $barcodeValue');
      return {};
    }

    if (parts.length == 5) {
      var currentNumberPointRaw = parts[3];
      int? currentNumberPoint;

      if (currentNumberPointRaw != null && currentNumberPointRaw.isNotEmpty) {
        currentNumberPoint = int.tryParse(currentNumberPointRaw);
      }

      if (currentNumberPoint == null) {
        print('Invalid currentNumberPoint value: $currentNumberPointRaw');
        return {};
      }

      int storeId = parts[1] != null ? int.tryParse(parts[1]!) ?? 0 : 0;
      int offerId = parts[2] != null ? int.tryParse(parts[2]!) ?? 0 : 0;
      int userId = parts[4] != null ? int.tryParse(parts[4]!) ?? 0 : 0;

      if (storeId == 0 || offerId == 0 || userId == 0) {
        print('Invalid values extracted from barcode data');
        return {};
      }

      return {
        'randomString': parts[0],
        'storeId': storeId,
        'offerId': offerId,
        'currentNumberPoint': currentNumberPoint,
        'userId': userId,
      };
    } else {
      print('Invalid barcode data format: $barcodeValue');
      return {};
    }
  } catch (e) {
    print('Error parsing barcode data: $e');
    return {
      'randomString': '',
      'storeId': 0,
      'offerId': 0,
      'currentNumberPoint': 0,
      'userId': 0,
    };
  }
}






  


  Future<bool> checkPreviousRedemption(
    BuildContext context,
    int storeId,
    int offerId,
  ) async {

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

    final scaffoldKeyContext = _scaffoldKey.currentContext;
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
