// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ncej_admin/controller/user.dart';
import 'package:ncej_admin/core/app_export.dart';
import 'package:ncej_admin/view/screen/home_page/widgets/card_arabic.dart';
import 'package:ncej_admin/view/screen/home_page/widgets/card_english.dart';
import 'package:ncej_admin/view/screen/home_page/widgets/listcoupontext_item_widget.dart';
import 'package:ncej_admin/view/screen/home_page/widgets/chipviewcompute_item_widget.dart';
import 'package:ncej_admin/view/screen/home_page/widgets/store_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String userEmail = "";
  String userName = "";
  String name="";

  @override
  void initState() {
    super.initState();
    getUserData();
  }
// Future<String> getImageUrlFromDatabase() async {
//   final String apiUrl = 'YOUR_API_ENDPOINT'; // Replace with your API endpoint.

//   try {
//     final response = await http.get(Uri.parse(apiUrl));
    
//     if (response.statusCode == 200) {
//       // If the request is successful, parse the response JSON to get the image URL.
//       final Map<String, dynamic> data = json.decode(response.body);
//       final String imageUrl = data['imageUrl']; // Replace 'imageUrl' with the actual key in your response.

//       return imageUrl;
//     } else {
//       throw Exception('Failed to load image URL');
//     }
//   } catch (e) {
//     throw Exception('Error fetching image URL: $e');
//   }
// }
  Future<void> getUserData() async {
    try {
      final user = await UserController().getUser();
     
      setState(() {
        userEmail = user.email;
        userName = user.username;
        name=user.fullName;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
  final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Directionality(
          textDirection: textDirection,
          child: buildBody(context),
        ),
        bottomNavigationBar: CustomBottomAppBar(
          onChanged: (selectedType) =>
              handleBottomNavChange(context, selectedType),
        ),
      ),
    );
  }

  CustomAppBar buildAppBar(BuildContext context) {
 final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return CustomAppBar(
      height: 50.v,
      leadingWidth: 40.h,
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
      title: AppbarTitle(text: "lbl15".tr),
    );
  }

  void onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }

  Widget buildBody(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
        textDirection: textDirection,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 7.v),
          child: Column(
            children: [
              SizedBox(height: 15.v),
              buildUserDetails(context),
              SizedBox(height: 50.v),
              buildMainStack(context),
              SizedBox(height: 30.v),
              buildChipView(context),
              const SizedBox(height: 50),
              buildChipStore(context),
            
            ],
          ),
        ));
  }

  Widget buildMainStack(BuildContext context) {
   final localization = AppLocalizationController.to;
    final isArabic = localization.locale.languageCode == 'ar';
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: isArabic ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: isArabic ? 34.h : 29.h,
                right: isArabic ? 29.h : 34.h,
                bottom: 150.v,
              ),
            ),
          ),
          SizedBox(height: 30.h),
         Builder(
            builder: (BuildContext context) {
              return isArabic ? const CardContainerArabic() : const CardContainerEnglish();
            },
          ),
        ],
      ),
    );
  }
  Widget buildChipView(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
        textDirection: textDirection,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.v, right: 15.h, left: 10.h),
              child: Text(
                "lbl19".tr,
                style: CustomTextStyles.titleMediumOnPrimaryContainer,
              ),
            ),
            SizedBox(height: 13.v),
            Wrap(
              runSpacing: 10.v,
              spacing: 10.h,
              children: List<Widget>.generate(
                  1, (index) => const ChipviewcomputeItemWidget()),
            ),
          ],
        ));
  }
  Widget buildChipStore(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
        textDirection: textDirection,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            SizedBox(height: 13.v),
            Wrap(
              runSpacing: 10.v,
              spacing: 10.h,
              children: List<Widget>.generate(
                  1, (index) => const StoreWidget()),
            ),
          ],
        ));
  }

  Widget buildNavigationRow(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
        textDirection: textDirection,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => navigateToCouponScreen(context),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.v, right: 10.h, left: 10.h),
                    child: Text(
                      "lbl16".tr,
                      style: CustomTextStyles.titleMediumOnPrimaryContainer,
                    ),
                  ),
                  SizedBox(
                    width: 200.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.v),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "lbl22".tr,
                            style: CustomTextStyles.titleMediumLightgreen500,
                          ),
                          Directionality(
                            textDirection: textDirection,
                            child: CustomImageView(
                              svgPath: (textDirection == TextDirection.rtl)
                                  ? ImageConstant.imgArrowleft
                                  : ImageConstant.imgArrowright,
                              color: appTheme.lightGreen500,
                              height: 15.adaptSize,
                              width: 15.adaptSize,
                              margin: EdgeInsets.only(top: 5.v, bottom: 5),
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget buildCouponList(BuildContext context) {
 final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
        textDirection: textDirection,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => SizedBox(height: 24.v),
          itemCount: 1,
          itemBuilder: (context, index) => const ListcoupontextItemWidget(),
        ));
  }



Widget buildUserDetails(BuildContext context) {
 final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.ltr : TextDirection.rtl;

  return Directionality(
    textDirection: textDirection,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              name.tr,
              style: CustomTextStyles.titleMediumLightgreen700,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Email: ",
                    style: CustomTextStyles.titleSmallBahijTheSansArabic,
                  ),
                  TextSpan(
                    text: userEmail, 
                    style: CustomTextStyles.titleSmallBahijTheSansArabic,
                  ),
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: "Username: ", 
                    style: CustomTextStyles.titleSmallBahijTheSansArabic,
                  ),
                  TextSpan(
                    text: userName, 
                    style: CustomTextStyles.titleSmallBahijTheSansArabic,
                  ),
                ],
              ),
            ),
            CustomElevatedButton(
              height: 33.v,
              width: 200.h,
              text: "msg34".tr,
              rightIcon: Container(
                margin: EdgeInsets.only(left: 1.h),
                child: CustomImageView(
                  svgPath: ImageConstant.imgSettings,
                ),
              ),
              buttonStyle: CustomButtonStyles.fillLightGreenTL16,
              buttonTextStyle: CustomTextStyles.titleSmallBahijTheSansArabicWhiteA700,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.updateUser);
              },
            )
          ],
        ),
       FutureBuilder<String>(
  future: getImageUrlFromDatabase(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {

      return Text('Error: ${snapshot.error}');
    } else if (snapshot.hasData) {
    
      return CustomImageView(
        imagePath: snapshot.data, 
        height: 56.adaptSize,
        width: 56.adaptSize,
        radius: BorderRadius.circular(28.h),
        margin: EdgeInsets.only(left: 10.h, top: 13.v, bottom: 5.v),
      );
    } else {
     
      return CustomImageView(
        imagePath: ImageConstant.imgEllipse63, 
        height: 56.adaptSize,
        width: 56.adaptSize,
        radius: BorderRadius.circular(28.h),
        margin: EdgeInsets.only(left: 10.h, top: 13.v, bottom: 5.v),
      );
    }
  },
)

      ],
    ),
  );
}

  void handleBottomNavChange(BuildContext context, BottomBarEnum selectedType) {
    switch (selectedType) {
      case BottomBarEnum.Infocircle:
        navigateToInfoScreen(context);
        break;
      case BottomBarEnum.Fingerprint:
        navigateToScanCodeScreen(context);
        break;
      case BottomBarEnum.Cut:
        navigateToLoginScreen(context);
        break;
      default:
    }
  }

  void navigateToInfoScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.infoScreen);
  }

  void navigateToScanCodeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.scanCodeScreen);
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.loginScreen);
  }

  void navigateToCouponScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CoponScreen(),
    ));
  }
  
  getImageUrlFromDatabase() {}
}
