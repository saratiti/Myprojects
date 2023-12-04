
// ignore_for_file: overridden_fields, use_key_in_widget_constructors, use_build_context_synchronously, library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:my_eco_print/controller/point_controller.dart';
import 'package:my_eco_print/core/app_export.dart';


class CollectingPointScreen extends StatefulWidget {
  const CollectingPointScreen({super.key});

  @override
  _CollectingPointScreenState createState() => _CollectingPointScreenState();
}

class _CollectingPointScreenState extends State< CollectingPointScreen> {


String scannedBarcode = '123456789';
String dialogMessage = '';

Future<void> scanBarcode() async {
  try {
    var result = await BarcodeScanner.scan();
    setState(() {
      scannedBarcode = result.rawContent;
    });

    final isBranchAndStoreConfirmed = await sendBarcodeToBackend(scannedBarcode);
    if (isBranchAndStoreConfirmed) {
      dialogMessage = 'The branch and store are confirmed.\n';
    } else {
      dialogMessage = 'The branch and store are rejected.\n';
    }
    dialogMessage += 'Barcode: $scannedBarcode\n'
        'Branch ID: 3\n'
        'Store ID: 4\n'
        'User ID: 6\n'
        'Total Price: \$100.0\n'
        'Offer ID: 42';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text(dialogMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('Reject'),
              onPressed: () {
                // Show a Snackbar for rejection
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Rejected'),
                ));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {

                final result = await sendBarcodeToBackend(scannedBarcode);

                if (result) {
                 
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Confirmed'),
                  ));
                } else {
                 
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Rejected'),
                  ));
                }
                Navigator.of(context).pop();
              },
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

  Future<bool> sendBarcodeToBackend(String barcode) async {
    try {
      const apiUrl = '/api/barcodes/scanQRCode';

      final Map<String, dynamic> barcodeData = {
        'barcode_value': barcode,
        'branch_id': 3,
        'store_id': 4,
        'user_id': 6,
        'offer_id': 42,
      };

      final response = await Dio().post(
        apiUrl,
        data: barcodeData,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        String message = responseData['message'];
        if (kDebugMode) {
          print('Backend response: $message');
        }
        return message == 'Confirmed';
      } else {
        if (kDebugMode) {
          print('Failed to send barcode to the backend: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending barcode to the backend: $e');
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
    
   child: SafeArea(
      child: Scaffold(
        
        appBar:buildAppBar(context),
        body: 
        
        
        SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: [
                   const SizedBox(height: 35,),
                  const RewardsList(),
                DividerWidget(text: "lbl34".tr,),
                 const SomeStackedWidgets(),
                ScanElevatedButton(
              onTap: scanBarcode,
            
            ),
                  const SomeOtherWidgets(),
                ],
              ),
            ),
          ),
        ),
  
      ),
    ));

  }
  
  void onTapArrowleft(BuildContext context) {

       
    Navigator.pop(context);
            


  }
}




class RewardsList extends StatelessWidget {
  const RewardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        int dailyPoints = await _collectDailyPoints();
         if (kDebugMode) {
           print("Daily Points: $dailyPoints");
         }
          _showPopDialog(context,dailyPoints);
        
      }, 
      
      child:
      
       RawChip(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          "msg72".tr,
          style: TextStyle(
            color: appTheme.whiteA700,
            fontSize: 16.fSize,
            fontFamily: 'Bahij TheSansArabic',
            fontWeight: FontWeight.w500,
          ),
        ),
        deleteIcon: CustomImageView(
          svgPath: ImageConstant.imgFile,
          height: 40.h,
          width: 40.h,
          margin: EdgeInsets.only(left: 5.h),
          color: Colors.white,
        ),
        onDeleted: () {},
        selected: false,
        backgroundColor: appTheme.lightGreen500,
        selectedColor: appTheme.lightGreen500,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
Future<int> _collectDailyPoints() async {
  try {
    PointController pointController = PointController();
    int dailyPoints = await pointController.collectDailyPoints();
    return dailyPoints;
  } catch (e) {
    if (kDebugMode) {
      print("Error collecting daily points: $e");
    }
    return 0;
  }
}

void _showPopDialog(BuildContext context, int dailyPoints) {
  String messageText = dailyPoints > 0
      ? "msg37".tr 
      : "msg36".tr;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 41.h, right: 41.h, bottom: 150.v),
          padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 25.v),
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
                  onTapImgCloseone(context);
                },
              ),
             Align(
  alignment: Alignment.centerRight,
  child: Padding(
    padding: EdgeInsets.only(top: 24.v, right: 59.h),
    child: Text(
      dailyPoints > 0 ? "lbl37".tr : "msg_36".tr,
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
                          text: messageText,
                          style: theme.textTheme.titleMedium,
                        ),
                        if (dailyPoints > 0)
                          TextSpan(
                            text: " $dailyPoints",
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
}
 void onTapImgCloseone(BuildContext context) {
    Navigator.pop(context);
  }
class RewardCard extends StatelessWidget {
  final String labelText;
  final String subLabelText;

  const RewardCard({super.key, required this.labelText, required this.subLabelText});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              subLabelText,
              textAlign: TextAlign.right,
              style: CustomTextStyles.bahijTheSansArabicOnPrimary,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 3.v),
              child: Text(
                labelText,
                textAlign: TextAlign.right,
                style: theme.textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  @override
  final Key? key;
  final String text;

  const DividerWidget({ required this.text, this.key});

  @override
  Widget build(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,child: 
        Padding(
          padding: EdgeInsets.only(top: 20.v),
          child: Text(
            text,
            style: CustomTextStyles.headlineLargeOnPrimary,
          ),
        ),
      
    );
  }
}


class SomeStackedWidgets extends StatelessWidget {
  const SomeStackedWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 264.v,
      width: 246.h,
      child: Stack(
      
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage1,
            height: 193.v,
            width: 175.h,
            alignment: Alignment.center,
          ),
         
        ],
      ),
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

class SomeOtherWidgets extends StatelessWidget {
  const SomeOtherWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 35.h, top: 37.v, right: 28.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            svgPath: ImageConstant.imgArrowleft,
            height: 9.adaptSize,
            width: 9.adaptSize,
            margin: EdgeInsets.only(top: 8.v, bottom: 7.v),
          ),
     
        ],
      ),
    );
  }
}
CustomAppBar buildAppBar(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  return 

  
  
 CustomAppBar(

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
    title: AppbarTitle(text:"lbl21".tr),
  );
}

void onTapArrowleft(BuildContext context) {
  Navigator.pop(context);
}
