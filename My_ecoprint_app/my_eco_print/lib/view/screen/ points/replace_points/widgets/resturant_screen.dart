// // ignore_for_file: camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/store._controller.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/data/module/store.dart';
import 'package:my_eco_print/view/screen/%20points/collecting_points/collecting_points.dart';

// class RestaurantScreen extends StatelessWidget {
//   const RestaurantScreen({Key? key}) : super(key: key);

//    @override
//   Widget build(BuildContext context) {
//   final localization = AppLocalizationController.to;
// final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

//     return Directionality(
//       textDirection: textDirection,
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: SizedBox(
//           height: 107.v,
//           width: 330.h,
//           child: buildClothesContainer(context),
//         ),
//       ),
//     );
//   }

// Widget buildClothesContainer(BuildContext context) {
// final localization = AppLocalizationController.to;
// final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;


//    return GestureDetector(
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 contentPadding: EdgeInsets.zero,
//                 content: Container(
//                   width: 350.h,
//                   height: 350.v,
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
//                   decoration: AppDecoration.fillWhiteA.copyWith(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   child: ListView(
//                     shrinkWrap: true,
//                     children: [
//                       Directionality(
//                         textDirection: textDirection,
//                         child: CustomImageView(
//                           svgPath: ImageConstant.imgClose,
//                           height: 24.adaptSize,
//                           width: 24.adaptSize,
//                           onTap: () {
//                             onTapImgCloseone(context);
//                           },
//                         ),
//                       ),
//                       Directionality(
//                         textDirection: textDirection,
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 10.h, top: 24.v),
//                           child: Text(
//                             "lbl48".tr,
//                             style: CustomTextStyles.displaySmallRed700,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10.v),
//                       SizedBox(
//                         width: 300.h,
//                         child: RichText(
//                           text: TextSpan(children: [
//                             TextSpan(
//                               text: "msg49".tr,
//                               style: theme.textTheme.titleMedium,
//                             ),
//                             TextSpan(
//                               text: "lbl_103".tr,
//                               style: CustomTextStyles.titleMediumRed700,
//                             ),
//                           ]),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       SizedBox(height: 20.v),
//                       Align(
//   alignment: Alignment.center,
//   child: CustomElevatedButton(
//     height: 35.v,
//     width: 150.h,
//     text: "lbl49".tr,
//     margin: EdgeInsets.only(top: 22.v),
//     buttonStyle: CustomButtonStyles.fillLightGreenTL20,
//     buttonTextStyle: CustomTextStyles.titleSmallBahijTheSansArabicWhiteA700,
//     onTap: () {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//              contentPadding: EdgeInsets.zero,
//                 content: Container(
//                   width: 350.h,
//                   height: 350.v,
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
//                   decoration: AppDecoration.fillWhiteA.copyWith(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   child: ListView(
//                     shrinkWrap: true,
//                     children: [
//                       Directionality(
//                         textDirection: textDirection,
//                         child: CustomImageView(
//                           svgPath: ImageConstant.imgClose,
//                           height: 24.adaptSize,
//                           width: 24.adaptSize,
//                           onTap: () {
//                             onTapImgCloseone(context);
//                           },
//                         ),
//                       ),
                    
//                       SizedBox(height: 10.v),
//                  Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 24.v, right: 59.h),
//                   child: Text(
//                     "lbl37".tr,
//                     style: theme.textTheme.displaySmall,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 46.v),
//               Align(
//                 alignment: Alignment.center,
//                 child: SizedBox(
//                   width: 156.h,
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "lbl_104".tr,
//                           style: theme.textTheme.titleMedium,
//                         ),
//                         TextSpan(
//                           text: "lbl_50".tr,
//                           style: CustomTextStyles.titleMediumLightgreen500,
//                         ),
//                              TextSpan(
//                           text: "lbl_106".tr,
//                           style: theme.textTheme.titleMedium,
//                         ),
//                                            const WidgetSpan(
//         child: SizedBox(width: 10.0),
//       ),
              
//                                 TextSpan(
//                           text: "lbl_105".tr,
//                           style: theme.textTheme.titleMedium,
//                         ),
                                 
//                          TextSpan(
//                           text: "lbl_102".tr,
//                           style: CustomTextStyles.titleMediumRed700,
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//                      ] )));
//         },
//       );
//     },
//   ),
// ),

//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//  child:  Center(
//   child: Container(
//     margin: EdgeInsets.only(top: 20.v),
//     padding: EdgeInsets.symmetric(
//       horizontal: 20.h,
//       vertical: 5.v,
//     ),
//     decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
//       borderRadius: BorderRadiusStyle.roundedBorder24,
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 1.v,top: 10),
//                     child: SizedBox(
//                       height: 44.adaptSize,
//                       width: 44.adaptSize,
//                       child: Container(
//                         height: 44.adaptSize,
//                         width: 44.adaptSize,
//                         padding: EdgeInsets.all(6.h),
//                         decoration: AppDecoration.fillGray.copyWith(
//                           borderRadius: BorderRadiusStyle.roundedBorder17,
//                         ),
//                         child: CustomImageView(
//                           imagePath: ImageConstant.imageMac,
//                           height: 44.adaptSize,
//                           width: 44.adaptSize,
//                           alignment: Alignment.center,
//                         ),
//                       ),
//                     ),
//                   ),

                
                  

                 
                   
//                 ],

             
//               ),
                  
              
//             ],
            
//           ),
//         ),
//          Padding(padding:const EdgeInsets.symmetric(vertical: 10),
//                      child: Align(
//                         alignment: Alignment.topCenter,
//                         child: Text(
//                           "lbl_102".tr,
//                           style: theme.textTheme.headlineSmall,
//                         ),
//                       ),
                    
//                   ), 
//          Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                            "msg41".tr,
//                           style: theme.textTheme.labelMedium,
//                         ),
//                       ),
//                     ],
//                   ),
//         Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: paint(textDirection: textDirection),
//               ),
//             ],
//           ),
//         ),
        
//       ],
//     ),
//   ),
// )



//   );
// }
// }
// class paint extends StatelessWidget {
//   const paint({
//     super.key,
//     required this.textDirection,
//   });

//   final TextDirection textDirection;

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.topLeft,
//       child: SizedBox(
//         height: 47.v,
//         width: 40.h,
//         child: Stack(
//           alignment: Alignment.topCenter,
//           children: [
//             Align(
//               alignment: textDirection == TextDirection.rtl
//                   ? Alignment.topLeft
//                   : Alignment.topRight,
//               child: SizedBox(
//                 height: 47,
//                 width: 40,
//                 child: OverflowBox(
//                   maxHeight: double.infinity,
//                   maxWidth: double.infinity,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       bottom: 50.v,
//                     ),
//                     child: CustomPaint(
//                       painter: MyPainter(textDirection: textDirection),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             "lbl_15002".tr,
//                             style: CustomTextStyles.titleMediumWhiteA700,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(right: 2.h),
//                             child: Text(
//                               "lbl39".tr,
//                               style: CustomTextStyles.titleMediumWhiteA700,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






// class MyPainter extends CustomPainter {
//   final TextDirection textDirection;

//   MyPainter({required this.textDirection});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//     Path path = Path();
//     paint.color = const Color(0xff99CA3C);
//     path = Path();

//     if (textDirection == TextDirection.ltr) {
//       // English text direction, align the shape to the left
//       path.lineTo(size.width * 0.78, 0);
//       path.cubicTo(
//           size.width * 0.78, 0, size.width * 0.22, 0, size.width * 0.22, 0);
//       path.cubicTo(
//           size.width * 0.1, 0, 0, size.height * 0.09, 0, size.height * 0.19);
//       path.cubicTo(
//           0, size.height * 0.19, 0, size.height * 0.9, 0, size.height * 0.9);
//       path.cubicTo(0, size.height, size.width * 0.07, size.height * 1.03,
//           size.width * 0.16, size.height * 0.98);
//       path.cubicTo(size.width * 0.16, size.height * 0.98, size.width * 0.45,
//           size.height * 0.85, size.width * 0.45, size.height * 0.85);
//       path.cubicTo(size.width * 0.48, size.height * 0.83, size.width * 0.52,
//           size.height * 0.83, size.width * 0.55, size.height * 0.85);
//       path.cubicTo(size.width * 0.55, size.height * 0.85, size.width * 0.83,
//           size.height * 0.98, size.width * 0.83, size.height * 0.98);
//       path.cubicTo(size.width * 0.93, size.height * 1.03, size.width, size.height,
//           size.width, size.height * 0.9);
//       path.cubicTo(size.width, size.height * 0.9, size.width, size.height * 0.19,
//           size.width, size.height * 0.19);
//       path.cubicTo(size.width, size.height * 0.09, size.width * 0.9, 0,
//           size.width * 0.78, 0);
//     } else {
//       // Arabic text direction, align the shape to the right
//       path.lineTo(size.width * 0.22, 0);
//       path.cubicTo(
//           size.width * 0.22, 0, size.width * 0.78, 0, size.width * 0.78, 0);
//       path.cubicTo(size.width * 0.83, 0, size.width, size.height * 0.09,
//           size.width, size.height * 0.19);
//       path.cubicTo(size.width, size.height * 0.19, size.width,
//           size.height * 0.9, size.width, size.height * 0.9);
//       path.cubicTo(size.width, size.height, size.width * 0.93,
//           size.height * 1.03, size.width * 0.83, size.height * 0.98);
//       path.cubicTo(size.width * 0.83, size.height * 0.98, size.width * 0.55,
//           size.height * 0.85, size.width * 0.55, size.height * 0.85);
//       path.cubicTo(size.width * 0.52, size.height * 0.83, size.width * 0.48,
//           size.height * 0.83, size.width * 0.45, size.height * 0.85);
//       path.cubicTo(size.width * 0.45, size.height * 0.85, size.width * 0.16,
//           size.height * 0.98, size.width * 0.16, size.height * 0.98);
//       path.cubicTo(size.width * 0.07, size.height * 1.03, 0, size.height,
//           0, size.height * 0.9);
//       path.cubicTo(0, size.height * 0.9, 0, size.height * 0.19, 0,
//           size.height * 0.19);
//       path.cubicTo(0, size.height * 0.09, size.width * 0.1, 0,
//           size.width * 0.22, 0);
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }




class AllStoreScreen extends StatefulWidget {
  const AllStoreScreen({Key? key}) : super(key: key);

  @override
  _AllStoreScreenState createState() => _AllStoreScreenState();
}

class _AllStoreScreenState extends State<AllStoreScreen> {
  List<Store> stores = [];

  @override
  void initState() {
    super.initState();
    fetchAllStoresOffer();
  }

  Future<void> fetchAllStoresOffer() async {
    try {
      List<Store> fetchedStoreOffer =
          await StoreController().getAllStoresWithOffers();

      setState(() {
        stores = fetchedStoreOffer;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching stores: $e");
      }
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
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 800.v,
          width: 330.h,
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

  return FutureBuilder<List<Store>>(
    future: StoreController().getAllStoresWithOffers(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No data available'));
      } else {
        List<Store> stores = snapshot.data!;

        return
        SizedBox(
     
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 60.v),
      
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: stores.length,
          itemBuilder: (context, index) {
            Store store = stores[index];

          return 
          
          
           GestureDetector(
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
                              padding: EdgeInsets.only(left: 10.h, top: 24.v),
                              child: Text(
                                "lbl48".tr,
                                style: CustomTextStyles.displaySmallRed700,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.v),
                          SizedBox(
                            width: 300.h,
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "msg49".tr,
                                  style: theme.textTheme.titleMedium,
                                ),
                                TextSpan(
                                  text: "lbl_103".tr,
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
                              buttonStyle:
                                  CustomButtonStyles.fillLightGreenTL20,
                              buttonTextStyle: CustomTextStyles
                                  .titleSmallBahijTheSansArabicWhiteA700,
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
                                        decoration: AppDecoration.fillWhiteA
                                            .copyWith(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Directionality(
                                              textDirection: textDirection,
                                              child: CustomImageView(
                                                svgPath:
                                                    ImageConstant.imgClose,
                                                height: 24.adaptSize,
                                                width: 24.adaptSize,
                                                onTap: () {
                                                  onTapImgCloseone(context);
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 10.v),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 24.v, right: 59.h),
                                                child: Text(
                                                  "lbl37".tr,
                                                  style: theme.textTheme
                                                      .displaySmall,
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
                                                        text: "lbl_104".tr,
                                                        style: theme.textTheme
                                                            .titleMedium,
                                                      ),
                                                      TextSpan(
                                                        text: "lbl_50".tr,
                                                        style:
                                                            CustomTextStyles
                                                                .titleMediumLightgreen500,
                                                      ),
                                                      TextSpan(
                                                        text: "lbl_106".tr,
                                                        style: theme.textTheme
                                                            .titleMedium,
                                                      ),
                                                      const WidgetSpan(
                                                        child: SizedBox(
                                                            width: 10.0),
                                                      ),
                                                      TextSpan(
                                                        text: "lbl_105".tr,
                                                        style: theme.textTheme
                                                            .titleMedium,
                                                      ),
                                                      TextSpan(
                                                        text: "lbl_102".tr,
                                                        style:
                                                            CustomTextStyles
                                                                .titleMediumRed700,
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
                child: Column(
                  children: [
                                                Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (stores[0].offers != null &&
                              stores[0].offers!.isNotEmpty)
                            Align(
                              alignment: Alignment.topLeft,
                              child: paint(
                                textDirection: textDirection,
                                // additionalText:
                                //     stores[0].offers![0].numberPoint.toString(),
              ),
                              ),
                          ],
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                     
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 1.v, top: 10),
                                    child: SizedBox(
                                      height: 44.adaptSize,
                                      width: 44.adaptSize,
                                      child: Container(
                                        height: 44.adaptSize,
                                        width: 44.adaptSize,
                                        padding: EdgeInsets.all(6.h),
                                        decoration: AppDecoration.fillGray
                                            .copyWith(
                                          borderRadius:
                                              BorderRadiusStyle.roundedBorder17,
                                        ),
                                        child: CustomImageView(
                                          imagePath: ImageConstant.imgImage1305,
                                          height: 44.adaptSize,
                                          width: 44.adaptSize,
                                          alignment: Alignment.center,
                                        ),
                                                              
        
                    
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        
                        if (stores[0].offers != null &&
                            stores[0].offers!.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 10),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: stores[0].offers!.map((offer) {
                                  return Text(
                                    offer.offerDescription,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        if (stores[0].offers != null &&
                            stores[0].offers!.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: stores[0].offers!.map((offer) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  offer.offerDiscount.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                 


            
                    ],
                  ),
                ),
              ),
            );
          },
            )
          )
   ) ]));
      }
    },
  );
}
}






class paint extends StatelessWidget {
  const paint({
    super.key,
    required this.textDirection,

  });

  final TextDirection textDirection;
 

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
                          Text(
                            "lbl_15002".tr,
                            style: CustomTextStyles.titleMediumWhiteA700,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 2.h),
                            child: Text(
                              "lbl39".tr,
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
