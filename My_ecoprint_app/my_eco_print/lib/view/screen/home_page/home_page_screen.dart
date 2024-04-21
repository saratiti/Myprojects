// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/api_helper.dart';
import 'package:my_eco_print/controller/user.dart';
import 'package:my_eco_print/controller/user_profile_provider.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/view/screen/home_page/widgets/card_arabic.dart';
import 'package:my_eco_print/view/screen/home_page/widgets/card_english.dart';
import 'package:my_eco_print/view/screen/home_page/widgets/listcoupontext_item_widget.dart';
import 'package:my_eco_print/view/screen/home_page/widgets/chipviewcompute_item_widget.dart';
import 'package:my_eco_print/view/widgets/app_bar/appbar.dart';
import 'package:provider/provider.dart';


class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String userEmail = "";
  String userName = "";
  String name="";
 final ApiHelper _apiHelper = ApiHelper();
  @override
  void initState() {
    super.initState();
    getUserData();
    
  }
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
        appBar: buildAppBar(context,"lbl15"),
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



  void onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }

  Widget buildBody(BuildContext context) {
  final localization = AppLocalizationController.to;
  final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(),
      child: Column(
        children: [
          buildUserDetails(context),
          SizedBox(height: 50.v),
          buildMainStack(context),
          SizedBox(height: 30.v),
          buildChipView(context),
          const SizedBox(height: 50),
          buildNavigationRow(context),
          buildCouponList(context),
        ],
      ),
    ),
  );
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
              return isArabic
                  ? const CardContainerArabic()
                  : const CardContainerEnglish();
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
                      "lbl20_".tr,
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
  final textDirection =
      localization.locale.languageCode == 'ar' ? TextDirection.ltr : TextDirection.rtl;

  return Directionality(
    textDirection: textDirection,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Adjust as needed
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0), 
                child: Consumer<UserProfileModel>(
                  builder: (context, userProfile, _) {
                    return FutureBuilder(
                      future: _apiHelper.getProfilePicture(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.data != null) {
                          Uint8List imageData = snapshot.data as Uint8List;
                          return ClipOval(
                            child: Image.memory(
                              imageData,
                              width: 56.adaptSize,
                              height: 56.adaptSize,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return ClipOval(
                            child: CustomImageView(
                              svgPath: ImageConstant.imgFingerprint,
                              height: 56.v,
                              width: 56.h,
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(top: 40.v),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
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
    Navigator.of(context).pushNamed(AppRoutes.collectingPoints);
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.loginScreen);
  }

  void navigateToCouponScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  const CoponScreen(),
    ));
  }
  
}
