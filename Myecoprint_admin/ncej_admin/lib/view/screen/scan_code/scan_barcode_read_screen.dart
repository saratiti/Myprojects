// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison, use_key_in_widget_constructors

import 'dart:async';
import 'dart:convert';


import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ncej_admin/controller/point_controller.dart';
import 'package:ncej_admin/controller/provider/user_profile_provider.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:provider/provider.dart';
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



// Future<void> scanBarcode(BuildContext context) async {
//   try {
//     ScanResult result = await BarcodeScanner.scan();

//     if (result != null && result.rawContent != null) {
//       setState(() {
//         scannedData = result.rawContent;
//       });
//       if (result.type == ResultType.Barcode) {
  
//         String barcodeFormat = result.format.toString();
//         print('Barcode Format: $barcodeFormat');

       
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Barcode Information'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Scanned QR Code: $scannedData'),
//                   Text('Barcode Format: $barcodeFormat'),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Close'),
//                 ),
//                 TextButton(
//                   onPressed: () async {
//                     var redemptionResult = await onTapRedeemPoints(
//                       context,
//                       scannedData,
//                     );

//                     if (redemptionResult != null) {
//                       if (redemptionResult['success'] == true) {
//                         int pointsRedeemed = redemptionResult['redeemedPoints'] ?? 0;
//                         print('Redemption successful');
//                         print(
//                             'StoreId: ${redemptionResult['barcodeInfo']['store_id']}, OfferId: ${redemptionResult['barcodeInfo']['offer_id']}, PointsRedeemed: $pointsRedeemed');

//                         showRedeemPointsMessage(context,pointsRedeemed);
//                       } else {
//                         print('Redemption not successful');
//                         showCustomErrorDialog(
//                           context,
//                           'Redemption Failed',
//                           'Invalid response format',
//                         );
//                       }
//                     } else {
//                       print('Redemption not successful');
//                       showCustomErrorDialog(
//                         context,
//                         'Redemption Failed',
//                         'Invalid response format',
//                       );
//                     }

//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Redeem'),
//                 ),
//               ],
//             );
//           },
//         );
//       } else {
//         showErrorDialog(context, 'Error Scanning Barcode', 'Unsupported barcode format.');
//       }
//     } else {
//       showErrorDialog(context, 'Error Scanning QR Code', 'Result is null or missing properties.');
//     }
//   } catch (e) {
//     print('Error scanning QR code: $e');
//     showErrorDialog(context, 'Error Scanning QR Code', 'Error: $e');
//   }
// }

//   void showErrorDialog(BuildContext context, String title, String content) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Scanned Barcode: ${scannedData ?? "N/A"}'),
//               Text('Error Content: $content'), 
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//   Future<Map<String, dynamic>?> onTapRedeemPoints(
//     BuildContext context,
//     String scannedData,
//   ) async {
//     try {
//       Map<String, dynamic> barcodeData = parseBarcodeData(scannedData);
//       if (barcodeData.isEmpty) {
//         print('Invalid barcode data format');
//         return null;
//       }

//       int storeId = barcodeData['storeId'];
//       int offerId = barcodeData['offerId'];
//       int pointsToRedeem = barcodeData['currentNumberPoint'] ?? 0;

// var result = await pointController.redeemPoints(
//   storeId: storeId,
//   offerId: offerId,
//   pointsRedeemed: pointsToRedeem,
//   scannedData: scannedData,
// );
 
// if (result != null && result['success'] != null) {
//   bool success = result['success']; 
//   if (success) {
//     String successMessage = result['message'];
//     int redeemedPoints = result['redeemedPoints']; 
//     print('Redemption successful: $successMessage, Points Redeemed: $redeemedPoints');
  
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Redemption Successful'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(successMessage),
//               Text('Points Redeemed: $redeemedPoints'), 
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//  Provider.of<UserProfileModel>(context, listen: false).updateTotalPointsRedeemed(pointsToRedeem);
// Provider.of<UserProfileModel>(context, listen: false).updateTotalPoints(pointsToRedeem);

//         return result;
//       } else {
//         print("Redemption not successful");
//         return null;
//       }

//     } catch (e) {
//       if (e is DioError) {
//         print("DioError response: ${e.response}");
//         print("DioError request: ${e.requestOptions}");

//         if (e.response?.statusCode == 400) {
         
//           String errorMessage = e.response?.data['error'] ?? 'Redemption failed';
//           print("Error in redeeming points: $errorMessage");

//           if (errorMessage == 'User has already redeemed from this offer and store') {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text('Redemption Failed'),
//                   content: Text(errorMessage),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text('OK'),
//                     ),
//                   ],
//                 );
//               },
//             );
//           } else {
//             print("Error in redeeming points: $errorMessage");
//           }
//         } else {
//           print("Error in redeeming points: $e");
//         }
//       }

//       print("Redemption not successful");
//       return null;
//     }
//   }

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
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 41.h, right: 41.h, bottom: 150.v),
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
                decoration: AppDecoration.fillWhiteA
                    .copyWith(borderRadius: BorderRadiusStyle.circleBorder28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      svgPath: ImageConstant.imgClose,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(height: 24.v),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Barcode Information',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 24.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Scanned QR Code: $scannedData'),
                          Text('Barcode Format: $barcodeFormat'),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
  onPressed: () {
    Navigator.of(context).pop();
  },
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.grey), // Change the button color
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Change the text color
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15.0)), // Change the button padding
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), 
      ),
    ),
  ),
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

        showRedeemPointsMessage(context,pointsRedeemed);
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
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen), 
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white), 
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15.0)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), 
      ),
    ),
  ),
  child: const Text('Redeem'),
),

                      ],
                    ),
                  ],
                ),
              ),
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

    if (result != null && result['success'] != null) {
      bool success = result['success'];
      if (success) {
        String successMessage = result['message'];
        int redeemedPoints = result['redeemedPoints'];
        print('Redemption successful: $successMessage, Points Redeemed: $redeemedPoints');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 41.h, right: 41.h, bottom: 150.v),
                padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
                decoration: AppDecoration.fillWhiteA
                    .copyWith(borderRadius: BorderRadiusStyle.circleBorder28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      svgPath: ImageConstant.imgClose,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 24.v, right: 59.h),
                        child: Text(
                          "Redemption Successful", 
                          style: theme.textTheme.displaySmall,
                        ),
                      ),
                    ),
                    SizedBox(height: 46.v),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 156.h,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: successMessage, // Success message
                                style: theme.textTheme.titleMedium,
                              ),
                              TextSpan(
                                text: " Points Redeemed: $redeemedPoints", // Redeemed points
                                style: CustomTextStyles.titleMediumLightgreen500,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

      Provider.of<UserProfileModel>(context, listen: false).updateTotalPointsRedeemed(pointsToRedeem);
      Provider.of<UserProfileModel>(context, listen: false).updateTotalPoints(pointsToRedeem);

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
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 41.h, right: 41.h, bottom: 150.v),
                  padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
                  decoration: AppDecoration.fillWhiteA
                      .copyWith(borderRadius: BorderRadiusStyle.circleBorder28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        svgPath: ImageConstant.imgClose,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 24.v, right: 59.h),
                          child: Text(
                            "Redemption Failed", 
                            style: theme.textTheme.displaySmall,
                          ),
                        ),
                      ),
                      SizedBox(height: 46.v),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          errorMessage, 
                          style: theme.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
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


Map<String, dynamic> parseBarcodeData(String barcodeValue) {
  try {
    print('Raw Barcode Data: $barcodeValue');

    List<String> parts = barcodeValue.split('#');

    if (parts.length != 6) {
      print('Invalid barcode data format: $barcodeValue');
      return {};
    }

    String randomString = parts[1];
    int storeId = int.tryParse(parts[2]) ?? 0;
    int offerId = int.tryParse(parts[3]) ?? 0;
    int currentNumberPoint = int.tryParse(parts[4]) ?? 0;
    int userId = int.tryParse(parts[5]) ?? 0;

    if (storeId == 0 || offerId == 0 || userId == 0) {
      print('Invalid values extracted from barcode data');
      return {};
    }

    return {
      'randomString': randomString,
      'storeId': storeId,
      'offerId': offerId,
      'currentNumberPoint': currentNumberPoint,
      'userId': userId,
    };
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

  void showRedeemPointsMessage(BuildContext context, int pointsRedeemed) {
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
  
  // Show a snackbar with the points redeemed message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Redeemed $pointsRedeemed points successfully!'),
      duration: const Duration(seconds: 2),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context,"lbl35"),
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

