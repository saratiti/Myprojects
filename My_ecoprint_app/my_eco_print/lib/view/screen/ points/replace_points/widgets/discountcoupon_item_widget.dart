// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/api_helper.dart';
import 'package:my_eco_print/controller/store._controller.dart';
import 'package:my_eco_print/controller/user_profile_provider.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/data/module/offer.dart';



import 'package:provider/provider.dart';

class ClothesScreen extends StatefulWidget {
  final int? offerId;
  final int? storeId;

  const ClothesScreen({Key? key, this.offerId, this.storeId}) : super(key: key);

  @override
  _ClothesScreenState createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  late OfferProvider offerProvider;

  @override
  void initState() {
    super.initState();
    offerProvider = OfferProvider();
    fetchData();
  }
final ApiHelper _apiHelper=ApiHelper();
  Future<void> fetchData() async {
    await offerProvider.fetchData(widget.storeId, widget.offerId);

    if (offerProvider.offers.isNotEmpty) {
      final offer = offerProvider.offers[0];
      print("Offer ID: ${offer.id}, Description: ${offer.offerDescription}");
    } else {
      print("No data available");
    }
  }

@override
Widget build(BuildContext context) {
  final localization = AppLocalizationController.to;
  final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: ChangeNotifierProvider<OfferProvider>(
    create: (context) => offerProvider,
    child: Consumer<OfferProvider>(
      builder: (context, offerProvider, child) {
        if (offerProvider.offers.isEmpty) {
          return Center(
            child: Text("No data available"),
          );
        }

        final offer = offerProvider.offers[0];

        return Center(
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
                                              child: Padding(
                padding: EdgeInsets.only(left: 8.0), 
                child: FutureBuilder(
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
        // Handle the case when imageData is null
        return Text('No image available');
      }
    } else {
      return CircularProgressIndicator();
    }
  },
),

              ),


                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 40, bottom: 40),
                                            child: Flex(
                                              direction:  Axis.horizontal,
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
                    );
      },
    ),
      )  );
}



     
  }



class OfferProvider with ChangeNotifier {
  List<Offer> _offers = [];

  List<Offer> get offers => _offers;

  Future<void> fetchData(int? storeId, int? offerId) async {
  if (storeId == null || offerId == null) {
    print('Error: storeId or offerId is null');
    return;
  }

  try {
    print('storeId: $storeId, offerId: $offerId');
    _offers = await StoreController().getOfferByStoreAndOfferId(storeId, offerId);
    notifyListeners();
  } catch (e) {
   
  }
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
      // English text direction, align the shape to the left
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





