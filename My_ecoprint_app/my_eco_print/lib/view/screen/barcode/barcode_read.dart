
// ignore_for_file: unnecessary_null_comparison, unnecessary_type_check, unused_local_variable, library_private_types_in_public_api, unused_element, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_eco_print/controller/api_helper.dart';
import 'package:my_eco_print/controller/barcodes_controller.dart';

import 'package:my_eco_print/controller/user_profile_provider.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/data/module/barcode.dart';
import 'package:my_eco_print/data/module/offer.dart';
import 'package:my_eco_print/view/screen/%20points/replace_points/widgets/discountcoupon_item_widget.dart';
import 'package:provider/provider.dart';

class ScanCodeScreenRef extends StatefulWidget {
  const ScanCodeScreenRef({super.key});

  @override
  _ScanCodeScreenRefState createState() => _ScanCodeScreenRefState();
}

class _ScanCodeScreenRefState extends State<ScanCodeScreenRef> with WidgetsBindingObserver {
 Uint8List? qrCodeImageBytes;
  String dataToEncode = '';
ButtonStyle buttonStyle = CustomButtonStyles.fillLightGreenTL161;
  String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedCurrentTime = DateFormat('hh:mm a').format(DateTime.now());
  Offer? offer;
  int? offerId;
  int? storeId;
  int? userId;
int ?barcodeId;



  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addObserver(this);
  _generateBarcodeAndQRCode().then((barcodeData) {
    if (barcodeData != null) {
      final String? barcodeId = barcodeData['barcodeId'];
      if (barcodeId != null) {
        fetchBarcodeStatus(int.parse(barcodeId));
      }
    }
  });
}

@override
void didUpdateWidget(covariant ScanCodeScreenRef oldWidget) {
  super.didUpdateWidget(oldWidget);
  _generateBarcodeAndQRCode().then((barcodeData) {
    if (barcodeData != null) {
      final String? barcodeId = barcodeData['barcode_id'];
      if (barcodeId != null) {
        fetchBarcodeStatus(int.parse(barcodeId));
      }
    }
  });
}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _generateBarcodeAndQRCode();
     if (barcodeId != null) {
    fetchBarcodeStatus(barcodeId!);
  }
    }
  }

String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  String randomString = String.fromCharCodes(Iterable.generate(
    length, (_) => chars.codeUnitAt(random.nextInt(chars.length)),
  ));


  return '#$randomString';
}
String barcodeValue = "";
Future<Map<String, dynamic>?> _generateBarcodeAndQRCode() async {
  try {
   
    if (barcodeValue.isNotEmpty && qrCodeImageBytes != null) {
    
      return {
        'barcodeValue': barcodeValue,
        'qrCodeImageBytes': qrCodeImageBytes,
      };
    }


    final response = await ApiHelper().postDioForImage(
      '/api/barcodes/offerstoreBarcode',
      {
        'storeId': storeId.toString(),
        'offerId': offerId.toString(),
      },
    );

    if (response != null) {
      if (response is List<int>) {
      
        return {
          'barcodeValue': barcodeValue, 
          'qrCodeImageBytes': Uint8List.fromList(response),
        };
      } else {

        if (kDebugMode) {
          print('Error: Invalid response format');
        }
        return null;
      }
    } else {

      if (kDebugMode) {
        print('Error: No response received');
      }
      return null;
    }
  } catch (e) {
  
    if (kDebugMode) {
      print('Error generating or retrieving barcode: $e');
    }
    return null;
  }
}


Future<void> _saveBarcodeToLocalDatabase(Map<String, dynamic> barcodeData) async {
  try {

   await BarcodeController().createBarcode(Barcodes.fromJson(barcodeData));
  } catch (e) {
    if (kDebugMode) {
      print('Error saving barcode data: $e');
    }
  
  }
}

 Future<Uint8List> _simulateBarcodeGeneration(String barcodeValue) async {

    String simulatedQRCodeDataUri = 'data:image/png;base64,SimulatedQRCodeData';
    return Uint8List.fromList(base64.decode(simulatedQRCodeDataUri.split(',')[1]));
  }

bool barcodeRead = false;

Future<void> fetchBarcodeStatus(int barcodeId) async {
  try {
    if (barcodeId != null) {
      
      bool isBarcodeRead = await BarcodeController().getBarcodeIsRead(barcodeId);
     
      setState(() {
        barcodeRead = isBarcodeRead;
      });
    } else {
     
      throw Exception('Barcode ID is null');
    }
  } catch (e) {
 
    if (kDebugMode) {
      print('Error fetching barcode status: $e');
    }
   
  }
}


@override
Widget build(BuildContext context) {
  final mediaQueryData = MediaQuery.of(context);
  final Map<String, dynamic>? routeArguments =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

  if (routeArguments != null &&
      routeArguments.containsKey('offerId') &&
      routeArguments.containsKey('storeId')) {
    offerId = routeArguments['offerId'] as int?;
    storeId = routeArguments['storeId'] as int?;

    return Center(
      child: SafeArea(
        child: Scaffold(
          
          body: FutureBuilder(
            future: _generateBarcodeAndQRCode(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
          
                return buildBody(mediaQueryData, offerId, storeId);
              } else {
               
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  } else {
    return const Center(
      child: Text('Missing offerId or storeId'),
    );
  }
}


  

  Widget buildBody(MediaQueryData mediaQueryData, int? offerId, int? storeId) {
    return SizedBox(
      width: mediaQueryData.size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ReplacePointListClothes(offerId: offerId, storeId: storeId),
            buildStackWithAlignment(),
          ],
        ),
      ),
    );
  }

  Stack buildStackWithAlignment() {
    
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 700.v,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Opacity(
                  opacity: 0.1,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgGroup70252,
                    height: 600.v,
                    width: 393.h,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(right: 18.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "msg51".tr,
                            style: CustomTextStyles.titleSmallBahijTheSansArabic15,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 100.h, top: 7.v),
                          child: Row(
                            children: [
                              Text(
                                formattedCurrentTime,
                                style: CustomTextStyles.titleSmallBahijTheSansArabic,
                              ),
                              CustomImageView(
                                svgPath: ImageConstant.imgClockLightGreen500,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                                margin: EdgeInsets.only(left: 13.h),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 55.h, top: 8.v),
                                child: Text(
                                  formattedCurrentDate,
                                  style: CustomTextStyles.titleMediumOnPrimaryContainer,
                                ),
                              ),
                              CustomImageView(
                                svgPath: ImageConstant.imgCalendar,
                                height: 24.adaptSize,
                                width: 24.adaptSize,
                                margin: EdgeInsets.only(left: 13.h),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 44.v,
                          width: 216.h,
                          margin: EdgeInsets.only(left: 100.h, top: 32.v),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "lbl50".tr,
                                  style: theme.textTheme.titleMedium,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "msg52".tr,
                                  style: CustomTextStyles.titleSmallBahijTheSansArabicPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
FutureBuilder<Map<String, dynamic>?>(
  future: _generateBarcodeAndQRCode(), 
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {

      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      // If an error occurs while fetching the image, display an error message
      return Text('Error: ${snapshot.error}');
    } else {
      final barcodeData = snapshot.data;
      if (barcodeData != null) {
        final String? barcodeValue = barcodeData['barcodeValue'];
        final Uint8List? qrCodeImageBytes = barcodeData['qrCodeImageBytes'];

        if (qrCodeImageBytes != null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.memory(
                    qrCodeImageBytes,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
        Padding(
  padding: EdgeInsets.only( top: 8.v),
  child: FutureBuilder<List<Map<String, dynamic>>>(
    future: BarcodeController().getBarcodeByStoreAndOfferId(storeId!, offerId!),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); 
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        
          String? barcodeValue = snapshot.data![0]['barcode_value'];
          if (barcodeValue != null) {
            int startIndex = barcodeValue.indexOf("#"); 
            int endIndex = barcodeValue.indexOf("#", startIndex + 1); 
            if (startIndex >= 0 && endIndex >= 0) {
              barcodeValue = barcodeValue.substring(startIndex, endIndex);
              return Text(
                '$barcodeValue',
                style: CustomTextStyles.titleMediumOnPrimaryContainer,
              );
            } else {
              return const Text('Barcode Value not found');
            }
          } else {
            return const Text('No barcode found');
          }
        } else {
          return const Text('No barcode data found');
        }
      }
    },
  ),
)


            ],
          );
        } else {
         
          return const Text('Error: Failed to load barcode image');
        }
      } else {
        return const CircularProgressIndicator();
      }
    }
    },
),


                        SizedBox(height: 20.v),
                        Padding(
                          padding: EdgeInsets.only(left: 100.h, top: 27.v),
                          child: SizedBox(
                            width: 222.h,
                            child: Text(
                              "msg53".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: CustomTextStyles.titleSmallBahijTheSansArabic_1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 180.h, top: 27.v),
                          child: Text(
                            "lbl51".tr,
                            style: CustomTextStyles.titleSmallBahijTheSansArabic15,
                          ),
                        ),
FutureBuilder<List<Map<String, dynamic>>>(
  future: BarcodeController().getBarcodeByStoreAndOfferId(storeId!, offerId!),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      
      return Text('Error: ${snapshot.error}');
    } else {
     
      final barcodes = snapshot.data;
      if (barcodes != null && barcodes.isNotEmpty) {
        
final barcodeStatus = barcodes[0]['barcode_status'] ?? '';
if (barcodeStatus == 'redeemed') {
  final offers = barcodes[0]['offers'];
  if (offers != null) {
    final pointsRedeemed = offers['number_point'];
    if (pointsRedeemed != null) {
      Provider.of<UserProfileModel>(context, listen: false).updateTotalPointsRedeemed(pointsRedeemed);
      Provider.of<UserProfileModel>(context, listen: false).updateTotalPoints(pointsRedeemed);
    } else {
      if (kDebugMode) {
        print('Number of points redeemed is null');
      }
    }
  } else {
    if (kDebugMode) {
      print('Offers object is null');
    }
  }
}

        final buttonStyle = barcodeStatus == 'redeemed'
            ? CustomButtonStyles.fillRed
            : CustomButtonStyles.fillLightGreenTL161;

       
        return CustomElevatedButton(
          height: 32.v,
          width: 190.h,
          text:barcodeStatus == 'redeemed' ? 'lbl53'.tr : 'msg54'.tr,
          margin: EdgeInsets.only(left: 100.h, top: 6.v),
          buttonStyle: buttonStyle,
          buttonTextStyle: theme.textTheme.labelLarge,
          onTap: () {
            // Handle onTap if needed
          },
        );
      } else {
        // If no barcodes are found, display a message
        return const Text("No barcode found for the given store ID and offer ID");
      }
    }
  },
)


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
Widget buildBarcodeImage(Map<String, dynamic>? barcodeData) {
  if (barcodeData != null) {
    final String? barcodeValue = barcodeData['barcodeValue'];
    final Uint8List? qrCodeImageBytes = barcodeData['qrCodeImageBytes'];

    if (qrCodeImageBytes != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Image.memory(
                qrCodeImageBytes,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 140.h, top: 8.v),
            child: Text(
              'Barcode Value: $barcodeValue', 
              style: CustomTextStyles.titleMediumOnPrimaryContainer,
            ),
          ),
        ],
      );
    } else {
     
      return const Text('Error: Failed to load barcode image');
    }
  } else {
    return const CircularProgressIndicator();
  }
}

class ReplacePointListClothes extends StatelessWidget {
  final int? offerId;
  final int? storeId;

  const ReplacePointListClothes({Key? key, this.offerId, this.storeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.v),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20.v);
                },
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ClothesScreen(offerId: offerId, storeId: storeId);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
