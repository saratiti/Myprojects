import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_eco_print/controller/api_helper.dart';
import 'package:my_eco_print/controller/offer_controller.dart';
import 'package:my_eco_print/controller/user.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/data/module/offer.dart';
import 'package:my_eco_print/view/screen/%20points/replace_points/widgets/discountcoupon_item_widget.dart';
import '../ points/collecting_points/collecting_points.dart';
import '../../../data/module/user.dart';

class ScanCodeScreenRef extends StatefulWidget {
  @override
  _ScanCodeScreenRefState createState() => _ScanCodeScreenRefState();
}

class _ScanCodeScreenRefState extends State<ScanCodeScreenRef> with WidgetsBindingObserver {
  Uint8List? qrCodeImageBytes;
  String dataToEncode = '';

  String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedCurrentTime = DateFormat('hh:mm a').format(DateTime.now());
  Offer? offer;
  int? offerId;
  int? storeId;
  int? userId;

@override
void initState() {
  super.initState();
  WidgetsBinding.instance?.addObserver(this);
  _generateBarcodeAndQRCode();
}


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
@override
void didUpdateWidget(covariant ScanCodeScreenRef oldWidget) {
  super.didUpdateWidget(oldWidget);
  _generateBarcodeAndQRCode();
}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _generateBarcodeAndQRCode();
    }
  }

  Future<void> _generateBarcodeAndQRCode() async {
    try {
      if (offerId != null && storeId != null && qrCodeImageBytes == null) {
        Offer? offer = await OfferController().getOfferById(offerId!);
        User? user = await UserController().getUser();

        int? offerNumberPoint = offer.numberPoint;
        int? userId = user.id;

        Map<String, dynamic> barcodeData = {
          'offer_id': offerId,
          'store_id': storeId,
          'user_id': userId,
          'number_point': offerNumberPoint,
        };
        dataToEncode = jsonEncode(barcodeData);

        Map<String, dynamic> requestBody = {
          'dataToEncode': dataToEncode,
        };

        print('Generated dataToEncode: $dataToEncode');
        dynamic response = await ApiHelper().postDioForImage('/api/barcodes/offerstoreBarcode', requestBody);

        if (response is Uint8List) {
          // Check if the widget is still mounted before calling setState
          if (mounted) {
            setState(() {
              qrCodeImageBytes = response;
            });
          }
        } else {
          if (kDebugMode) {
            print('Failed to generate QR code: Invalid response type');
          }
        }
      }
    } catch (e) {
      // Handle exceptions
      print('Error generating barcode: $e');
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
          appBar: buildCustomAppBar(context),
          body: FutureBuilder(
            future: _generateBarcodeAndQRCode(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Display your page content with the QR code
                return buildBody(mediaQueryData, offerId, storeId);
              } else {
                // Display a loading indicator or placeholder content
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  } else {
    return Center(
      child: Text('Missing offerId or storeId'),
    );
  }
}


  CustomAppBar buildCustomAppBar(BuildContext context) {
    //final mediaQueryData = MediaQuery.of(context);
    return CustomAppBar(
      height: 117.v,
      leadingWidth: 66.h,
      leading: AppbarImage1(
        svgPath: ImageConstant.imgArrowleftOnprimary,
        margin: EdgeInsets.only(left: 42.h, top: 4.v, bottom: 4.v),
        onTap: () => onTapArrowleft(context),
      ),
      title: AppbarTitle(
        text: "msg50".tr,
        margin: EdgeInsets.only(left: 47.h),
      ),
    );
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
                        Center(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: BarcodeWidget(
                              barcode: Barcode.qrCode(),
                              data: '$dataToEncode',
                              width: 200,
                              height: 200,
                              color: Colors.lightGreen,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 140.h, top: 8.v),
                          child: Text(
                            "lbl_0221555a0bb2".tr,
                            style: CustomTextStyles.titleMediumOnPrimaryContainer,
                          ),
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
                        CustomElevatedButton(
                          height: 32.v,
                          width: 190.h,
                          text: "msg54".tr,
                          margin: EdgeInsets.only(left: 100.h, top: 6.v),
                          buttonStyle: CustomButtonStyles.fillLightGreenTL161,
                          buttonTextStyle: theme.textTheme.labelLarge,
                        ),
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
