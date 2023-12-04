// ignore_for_file: unused_local_variable, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/point_controller.dart';
import 'package:my_eco_print/controller/type_controller.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/data/module/type.dart';
import 'package:my_eco_print/view/screen/%20points/replace_points/widgets/coffee_screen.dart';
import 'package:my_eco_print/view/screen/%20points/replace_points/widgets/discountcoupon_item_widget.dart';
import 'package:my_eco_print/view/screen/%20points/replace_points/widgets/resturant_screen.dart';

class ReplacePointScreen extends StatelessWidget {
  const ReplacePointScreen({Key? key});
 
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    mediaQueryData = MediaQuery.of(context);

    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Directionality(
          textDirection: textDirection,
          child: SizedBox(
            width: screenWidth, 
            height: screenHeight, 
            child: const SingleChildScrollView(
              child: ReplacePointContent(),
            ),
          ),
        ),
      ),
    );
  }
}

class ReplacePointContent extends StatelessWidget {
  const ReplacePointContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const double verticalSpacing = 6.0;
    const double horizontalSpacing = 16.0;

    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
        textDirection: textDirection,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ReplacePointHeader(),
              SizedBox(height: 10.h),
              const ReplacePointRichText(),
              SizedBox(height: 10.h),
              const ReplacePointButtons(),
              SizedBox(height: 10.v),
              // GestureDetector(
              //   onTap: () {
              //     if (kDebugMode) {
              //       print("Tapped on CustomHeaderRow");
              //     }
              //     navigateToReplaceScreen(context);
              //   },
              //   child: CustomHeaderRow(
              //     context: context,
              //   ),
              // ),

              // const ReplacePointListCoffee(),
              SizedBox(height: 2.v),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children:

              // [
              //   Padding(
              //   padding: EdgeInsets.only(top: 35.h, bottom: 3.h, right: 20.h),
              //   child: Text(
              //     "msg43".tr,
              //     style: CustomTextStyles
              //         .titleSmallBahijTheSansArabicOnPrimaryContainer,
              //   ),
              // )],)
            ],
          ),
        ));
  }

  void navigateToReplaceScreen(BuildContext context) {
    if (kDebugMode) {
      print("Navigating to ReplaceScreen");
    }
    Navigator.of(context).pushNamed(AppRoutes.refundableitempoints);
  }
}

// class CustomHeaderRow extends StatelessWidget {
//   final BuildContext context;

//   const CustomHeaderRow({Key? key, required this.context}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (kDebugMode) {
//           print("Tapped on CustomHeaderRow");
//         }
//         navigateToReplaceScreen();
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           // Row(
//           //   children: [
//           //     CustomImageView(
//           //       svgPath: ImageConstant.imgArrowleft,
//           //       height: 15.adaptSize,
//           //       width: 15.adaptSize,
//           //       margin: EdgeInsets.only(top: 35.h, bottom: 3.h,left:15.h ),
//           //     ),
//           //     SizedBox(width: 2.v),
//           //     Padding(
//           //       padding:
//           //           EdgeInsets.only(top: 35.h, bottom: 3.h,right:20.h ),
//           //       child: Text(
//           //         "lbl22".tr,
//           //         style: CustomTextStyles.titleLargeFFShamelFamilyLightgreen500,
//           //       ),
//           //     )
//           //   ],
//           // ),

//         ],
//       ),
//     );
//   }

//   void navigateToReplaceScreen() {
//     if (kDebugMode) {
//       print("Navigating to ReplaceScreen");
//     }
//     Navigator.of(context).pushNamed(AppRoutes.refundableitempoints);
//   }
// }

class ReplacePointHeader extends StatelessWidget {
  const ReplacePointHeader({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImageView(
              svgPath: (textDirection == TextDirection.rtl)
                  ? ImageConstant.imgArrowright
                  : ImageConstant.imgArrowleftOnprimary,
              height: 24.0,
              width: 24.0,
              margin: const EdgeInsets.only(top: 30.0, bottom: 4.0),
              onTap: () => onTapImgArrowLeft(context),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(
                  top: 30.0, bottom: 4.0, right: 10.0, left: 30),
              child: Text(
                "lbl20".tr,
                style: theme.textTheme.titleLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, top: 30.0, bottom: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 1.0),
              decoration: AppDecoration.fillLightGreen.copyWith(
                borderRadius: BorderRadius.circular(13.0),
              ),
              child: FutureBuilder<int>(
                future:PointController().getTotalPointsByUserId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Return a loading indicator while the data is being fetched
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle the error state
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // Display the fetched total points
                    return Text(
                      "Total Points: ${snapshot.data}",
                      style: theme.textTheme.labelLarge,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  void onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}

class ReplacePointListCoffee extends StatelessWidget {
  final int typeId;

  const ReplacePointListCoffee({Key? key, required this.typeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 60.v),
              child: Column(
                children: [
                  SizedBox(
                    height: 600.v, 
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 25.v);
                      },
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return CoffeeScreen(typeId: typeId);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ReplacePointListResturant extends StatelessWidget {
  const ReplacePointListResturant({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 60.v),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 25.v);
                },
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const AllStoreScreen();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReplacePointListClothes extends StatelessWidget {
  const ReplacePointListClothes({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 60.v),
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 25.v);
                },
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const ClothesScreen();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReplacePointRichText extends StatelessWidget {
  const ReplacePointRichText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(top: 10.h, right: 10),
                child: Text("lbl41".tr, style: theme.textTheme.headlineLarge),
              ),
              SizedBox(
                width: 10.v,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.h, right: 10.h),
                child: CustomIconButton(
                  height: 44.0,
                  width: 44.0,
                  margin: EdgeInsets.only(top: 3.h, right: 10.h),
                  padding: const EdgeInsets.all(10.0),
                  decoration: IconButtonStyleHelper.outlineOnPrimaryContainer,
                  alignment: Alignment.topLeft,
                  child:
                      CustomImageView(svgPath: ImageConstant.imgLinearsearch),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(top: 10.h, right: 10.v, left: 10.h),
            child: Text("msg45".tr,
                style: CustomTextStyles.headlineLargeOnPrimary),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, right: 10.v, left: 10.h),
            child: Text("lbl40".tr,
                style: CustomTextStyles.headlineLargeOnPrimary),
          ),
        ],
      ),
    );
  }
}

class ReplacePointButtons extends StatefulWidget {
  const ReplacePointButtons({Key? key}) : super(key: key);

  @override
  _ReplacePointButtonsState createState() => _ReplacePointButtonsState();
}

class _ReplacePointButtonsState extends State<ReplacePointButtons> {
  int? selectedTypeId;
  String? selectedButton;
  bool showList = true;
  List<Type> types = [];

  @override
  void initState() {
    super.initState();
    fetchTypes();
    
    // Set initial values to show AllStoreScreen by default
    selectedButton = "lbl45".tr;
    selectedTypeId = null;
  }

  Future<void> fetchTypes() async {
    try {
      List<Type> fetchedTypes = await TypeController().getAll();

      setState(() {
        types = fetchedTypes;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching types: $e");
      }
    }
  }

  void handleTypeSelection(int typeId) {
    setState(() {
      selectedTypeId = typeId;
      selectedButton = null;
    });
  }

  void handleButtonSelection(String button) {
    setState(() {
      selectedButton = button;
      selectedTypeId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    List<Widget> typeButtons = [];

    for (Type type in types) {
      typeButtons.add(
        CustomOutlinedButton(
          height: 43.0,
          width: 160.0,
          text: type.typeArabic,
          rightIcon: Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: CustomImageView(
              svgPath: ImageConstant.imgMusic,
            ),
          ),
          buttonStyle: selectedTypeId == type.typeId
              ? CustomButtonStyles.fillLightGreen
              : CustomButtonStyles.outlinePrimary,
          buttonTextStyle: selectedTypeId == type.typeId
              ? CustomTextStyles.titleMediumFFShamelFamilyWhiteA700
              : CustomTextStyles.titleSmallBahijTheSansArabicPrimary_1,
          onTap: () {
            handleTypeSelection(type.typeId);
          },
        ),
      );

      typeButtons.add(const SizedBox(width: 15.0));
    }

    return Directionality(
      textDirection: textDirection,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 15.0),
                ...typeButtons,
                const SizedBox(width: 15.0),
                CustomElevatedButton(
                  height: 43.v,
                  width: 160.h,
                  text: "lbl45".tr,
                  margin: EdgeInsets.only(left: 8.h),
                  rightIcon: Container(
                    margin: EdgeInsets.only(left: 9.h),
                    child: CustomImageView(
                      svgPath: ImageConstant.imgMobileWhiteA700,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.fillLightGreenTL20,
                  buttonTextStyle:
                      CustomTextStyles.titleSmallBahijTheSansArabicWhiteA700,
                  onTap: () {
                    handleButtonSelection("lbl45".tr);
                  },
                ),
              ],
            ),
          ),
          Builder(
            builder: (BuildContext context) {
              Widget visibleWidget;

              if (selectedButton == "lbl45".tr) {
                visibleWidget = Directionality(
                  textDirection: textDirection,
                  child: const Visibility(
                    visible: true,
                    child: AllStoreScreen(),
                  ),
                );
              } else if (selectedTypeId != null) {
                visibleWidget = CoffeeScreen(typeId: selectedTypeId!);
              } else {
                visibleWidget = const SizedBox();
              }

              return Visibility(
                visible: visibleWidget != const SizedBox(),
                child: visibleWidget,
              );
            },
          ),
        ],
      ),
    );
  }
}

