import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/point_controller.dart';
import 'package:my_eco_print/controller/user_profile_provider.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:provider/provider.dart';
class CardContainerEnglish extends StatelessWidget {
  const CardContainerEnglish({super.key});



  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 314.h,
        margin: EdgeInsets.only(left: 5.h, right: 15.h),
        padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 3.v),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: fs.Svg(ImageConstant.imgGroup48096399),
            fit: BoxFit.cover,
          ),
        ),
        child:  CardContentEnglish(),
      ),
    );
  }
}

class CardContentEnglish extends StatefulWidget {


  CardContentEnglish ({Key? key}) : super(key: key);

  @override
  _CardContentEnglishState createState() => _CardContentEnglishState();
}

class _CardContentEnglishState extends State<CardContentEnglish > {
  late UserProfileModel userProfile; 

  @override
  void initState() {
    super.initState();
     userProfile = Provider.of<UserProfileModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 26.v),
        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyle.roundedBorder40,
          ),
          child: Container(
            height: 180.v,
            width: 300.h,
            decoration: AppDecoration.gradientLightGreenToLightGreen.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder40,
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.h,
                      vertical: 50.v,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: fs.Svg(
                          ImageConstant.imgGroup11,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(25.h, 35.v, 44.h, 27.v),
                          decoration: AppDecoration.fillLightGreen.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 29.h,
                      bottom: 31.v,
                    ),
                    child: Container(
                      height: 4.v,
                      width: 204.h,
                      decoration: BoxDecoration(
                        color: appTheme.whiteA700.withOpacity(0.48),
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2.h),
                        child: LinearProgressIndicator(
                          value: 0.11,
                          backgroundColor: appTheme.whiteA700.withOpacity(0.48),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            appTheme.whiteA700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 29.h,
                      bottom: 43.v,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.v),
                                    child: CustomImageView(
                                      svgPath: ImageConstant.imgVolume,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize,
                                      margin: EdgeInsets.only(
                                        right: 6.h,
                                        bottom: 3.v,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.v),
                                    child: Text(
                                      "lbl17".tr,
                                      style:
                                          CustomTextStyles.titleLargeWhiteA700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "lbl18".tr,
                                        style: CustomTextStyles
                                            .titleSmallBahijTheSansArabicWhiteA700,
                                      ),
                                        Consumer<UserProfileModel>(
      builder: (context, userProfile, _) {
        return FutureBuilder<int>(
  future:userProfile.totalPointsRedeemed,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Column(
                  children: [
                    Text(
                      " ${snapshot.data}",
                      style: CustomTextStyles.titleSmallBahijTheSansArabicWhiteA700,
                    ),
                  ],
                );
              }
            },
          );
   } )],
                                    
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.64,
                  child: CustomImageView(
                    svgPath: ImageConstant.imgVolumeOnprimarycontainer,
                    height: 36.v,
                    width: 48.h,
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(
                      right: 23.h,
                      top: 20.v,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 44.v,
                      left: 30.h,
                    ),
                                       child: Consumer<UserProfileModel>(
      builder: (context, userProfile, _) {
        return FutureBuilder<int>(
  future: userProfile.totalPoints,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text("Error: ${snapshot.error}");
    } else {
      
      return Text(
        "${snapshot.data}",
        style: CustomTextStyles.headlineSmallWhiteA700,
      );
    }
  },
);

      },
    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
