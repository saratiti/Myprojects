// ignore_for_file: camel_case_types, use_build_context_synchronously, unnecessary_null_comparison


import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/api_helper.dart';
import 'package:my_eco_print/controller/store._controller.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/data/module/offer.dart';
import 'package:my_eco_print/view/screen/barcode/barcode_read.dart';
import 'package:my_eco_print/view/screen/%20points/collecting_points/collecting_points.dart';
import 'package:my_eco_print/view/screen/barcode/ref_screen.dart';

class CoffeeScreen extends StatefulWidget {
  final int? typeId;
  final String? selectedButton;

  const CoffeeScreen({Key? key, this.typeId, this.selectedButton}) : super(key: key);

  @override
  _CoffeeScreenState createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {
  late Future<List<Offer>> _offersFuture;

  @override
  void initState() {
    super.initState();
    _fetchOffers();
  }

  void _fetchOffers() {
    if (widget.selectedButton == "lbl45") {
     
      _offersFuture = StoreController().getStoresWithOffers(0); 
    } else if (widget.typeId != null) {
      
      _offersFuture = StoreController().getStoresWithOffers(widget.typeId!);
    }
  }

  @override
  void didUpdateWidget(covariant CoffeeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedButton != widget.selectedButton || oldWidget.typeId != widget.typeId) {
      _fetchOffers();
    }
  }
 ApiHelper _apiHelper=ApiHelper();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizationController.to;

    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          child: buildClothesContainer(context),
        ),
      ),
    );
  }

  Widget buildClothesContainer(BuildContext context) {
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return FutureBuilder<List<Offer>>(
      future: _offersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          List<Offer> offers = snapshot.data!;

          return SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.only(bottom: 60.v),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  Offer offer = offers[index];

                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: Container(
                              width: 350.h,
                              height: 350.v,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.h,
                                vertical: 20.v,
                              ),
                              decoration: AppDecoration.fillWhiteA.copyWith(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Directionality(
                                    textDirection: textDirection,
                                    child: CustomImageView(
                                      svgPath: ImageConstant.imgClose,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize,
                                      onTap: () {
                                        onTapImgCloseone(context);
                                      },
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: textDirection,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10.h, top: 24.v),
                                      child: Text(
                                        "lbl48".tr,
                                        style:
                                            CustomTextStyles.displaySmallRed700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.v),
                                  SizedBox(
                                    width: 300.h,
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: offer.store?.nameArabic ??
                                              'Unknown Store',
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        TextSpan(
                                          text: offer.numberDiscount.toString(),
                                          style: CustomTextStyles.titleMediumRed700,
                                        ),
                                      ]),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: 20.v),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomElevatedButton(
                                      height: 35.v,
                                      width: 150.h,
                                      text: "lbl49".tr,
                                      margin: EdgeInsets.only(top: 22.v),
                                      buttonStyle: CustomButtonStyles.fillLightGreenTL20,
                                      buttonTextStyle: CustomTextStyles.titleSmallBahijTheSansArabicWhiteA700,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ScanCodeScreenRef1(),
                                            settings: RouteSettings(
                                              arguments: {'offerId': offer.id, 'storeId': offer.storeId},
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20.v),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.h,
                          vertical: 5.v,
                        ),
                        decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: SizedBox(
                                            height: 40.adaptSize,
                                            width: 40.adaptSize,
                                            child: Container(
                                              height: 40.adaptSize,
                                              width: 40.adaptSize,
                                              padding: EdgeInsets.all(5.h),
                                              decoration: AppDecoration.fillGray.copyWith(
                                                borderRadius: BorderRadiusStyle.roundedBorder17,
                                              ),
                                           child:  FutureBuilder(
  future: _apiHelper.getProfilePictureCompany(offer.companyId.toString()),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (snapshot.hasData) {
      Uint8List? imageData = snapshot.data as Uint8List?;
      if (imageData != null) {
        return Image.memory(
          imageData,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        );
      } else {
        return ClipOval(
          child: Container(
            width: 150,
            height: 150,
            color: Colors.grey,
            child: Center(
              child: Icon(
                Icons.image_not_supported,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    } else {
      return CircularProgressIndicator();
    }
  },
),


                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 40, bottom: 40),
                                            child: Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    '${offer.numberDiscount.toString()}%',
                                                    style: theme.textTheme.headlineSmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              offer.offerDescription != null ? offer.offerDescription.toString() : 'No description available',
                              style: theme.textTheme.labelMedium,
                              textAlign: TextAlign.center,
                            ),
                            if (offer.numberPoint != null)
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: paint(
                                        textDirection: textDirection,
                                        additionalText: offer.numberPoint.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}



class paint extends StatelessWidget {
  final TextDirection textDirection;
  final String additionalText; 

  const paint({
    Key? key,
    required this.textDirection,
    required this.additionalText, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 47.v,
        width: 40.h,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: textDirection == TextDirection.rtl
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: SizedBox(
                height: 47,
                width: 40,
                child: OverflowBox(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 50.v,
                    ),
                    child: CustomPaint(
                      painter: MyPainter(textDirection: textDirection),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                         
                          Padding(
                            padding: EdgeInsets.only(right: 2.h),
                            child: Text(
                              additionalText,
                              style: CustomTextStyles.titleMediumWhiteA700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MyPainter extends CustomPainter {
  final TextDirection textDirection;

  MyPainter({required this.textDirection});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint.color = const Color(0xff99CA3C);
    path = Path();

    if (textDirection == TextDirection.ltr) {
      path.lineTo(size.width * 0.78, 0);
      path.cubicTo(
          size.width * 0.78, 0, size.width * 0.22, 0, size.width * 0.22, 0);
      path.cubicTo(
          size.width * 0.1, 0, 0, size.height * 0.09, 0, size.height * 0.19);
      path.cubicTo(
          0, size.height * 0.19, 0, size.height * 0.9, 0, size.height * 0.9);
      path.cubicTo(0, size.height, size.width * 0.07, size.height * 1.03,
          size.width * 0.16, size.height * 0.98);
      path.cubicTo(size.width * 0.16, size.height * 0.98, size.width * 0.45,
          size.height * 0.85, size.width * 0.45, size.height * 0.85);
      path.cubicTo(size.width * 0.48, size.height * 0.83, size.width * 0.52,
          size.height * 0.83, size.width * 0.55, size.height * 0.85);
      path.cubicTo(size.width * 0.55, size.height * 0.85, size.width * 0.83,
          size.height * 0.98, size.width * 0.83, size.height * 0.98);
      path.cubicTo(size.width * 0.93, size.height * 1.03, size.width,
          size.height, size.width, size.height * 0.9);
      path.cubicTo(size.width, size.height * 0.9, size.width,
          size.height * 0.19, size.width, size.height * 0.19);
      path.cubicTo(size.width, size.height * 0.09, size.width * 0.9, 0,
          size.width * 0.78, 0);
    } else {
      path.lineTo(size.width * 0.22, 0);
      path.cubicTo(
          size.width * 0.22, 0, size.width * 0.78, 0, size.width * 0.78, 0);
      path.cubicTo(size.width * 0.83, 0, size.width, size.height * 0.09,
          size.width, size.height * 0.19);
      path.cubicTo(size.width, size.height * 0.19, size.width,
          size.height * 0.9, size.width, size.height * 0.9);
      path.cubicTo(size.width, size.height, size.width * 0.93,
          size.height * 1.03, size.width * 0.83, size.height * 0.98);
      path.cubicTo(size.width * 0.83, size.height * 0.98, size.width * 0.55,
          size.height * 0.85, size.width * 0.55, size.height * 0.85);
      path.cubicTo(size.width * 0.52, size.height * 0.83, size.width * 0.48,
          size.height * 0.83, size.width * 0.45, size.height * 0.85);
      path.cubicTo(size.width * 0.45, size.height * 0.85, size.width * 0.16,
          size.height * 0.98, size.width * 0.16, size.height * 0.98);
      path.cubicTo(size.width * 0.07, size.height * 1.03, 0, size.height, 0,
          size.height * 0.9);
      path.cubicTo(
          0, size.height * 0.9, 0, size.height * 0.19, 0, size.height * 0.19);
      path.cubicTo(
          0, size.height * 0.09, size.width * 0.1, 0, size.width * 0.22, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
