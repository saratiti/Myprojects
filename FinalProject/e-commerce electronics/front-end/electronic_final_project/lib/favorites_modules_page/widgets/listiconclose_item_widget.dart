import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/theme/app_style.dart';
import 'package:electronic_final_project/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';



class ListiconcloseItemWidget extends StatelessWidget {
  ListiconcloseItemWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: getPadding(
              right: 9,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: getVerticalSize(
                    194,
                  ),
                  width: getHorizontalSize(
                    161,
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgImage14,
                        height: getVerticalSize(
                          194,
                        ),
                        width: getHorizontalSize(
                          161,
                        ),
                        alignment: Alignment.center,
                      ),
                      CustomImageView(
                        svgPath: ImageConstant.imgIconclose,
                        height: getSize(
                          24,
                        ),
                        width: getSize(
                          24,
                        ),
                        alignment: Alignment.topRight,
                        margin: getMargin(
                          top: 3,
                          right: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 8,
                  ),
                  child: Text(
                    "",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFUIDisplaySemibold14,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 5,
                  ),
                  child: Text(
                    "",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFUIDisplayRegular14Gray600,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 3,
                  ),
                  child: Text(
                    "",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFUIDisplayRegular14,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 3,
                  ),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Size: ",
                              style: TextStyle(
                                color: ColorConstant.gray600,
                                fontSize: getFontSize(
                                  14,
                                ),
                                fontFamily: 'SF UI Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: "43",
                              style: TextStyle(
                                color: ColorConstant.blueGray900,
                                fontSize: getFontSize(
                                  14,
                                ),
                                fontFamily: 'SF UI Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: getPadding(
                          left: 15,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Colour: ",
                                style: TextStyle(
                                  color: ColorConstant.gray600,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'SF UI Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "White",
                                style: TextStyle(
                                  color: ColorConstant.blueGray900,
                                  fontSize: getFontSize(
                                    14,
                                  ),
                                  fontFamily: 'SF UI Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: getPadding(
              left: 9,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: getVerticalSize(
                    194,
                  ),
                  width: getHorizontalSize(
                    161,
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgImage15,
                        height: getVerticalSize(
                          194,
                        ),
                        width: getHorizontalSize(
                          161,
                        ),
                        alignment: Alignment.center,
                      ),
                      CustomImageView(
                        svgPath: ImageConstant.imgIconclose,
                        height: getSize(
                          24,
                        ),
                        width: getSize(
                          24,
                        ),
                        alignment: Alignment.topRight,
                        margin: getMargin(
                          top: 3,
                          right: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 8,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtSFUIDisplaySemibold14Red400,
                      ),
                      Padding(
                        padding: getPadding(
                          left: 9,
                          top: 4,
                        ),
                        child: Text(
                          "",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtSFUIDisplayRegular10.copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 4,
                  ),
                  child: Text(
                    "",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFUIDisplayRegular14Gray600,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 3,
                  ),
                  child: Text(
                    "",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFUIDisplayRegular14,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 5,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Size: ",
                          style: TextStyle(
                            color: ColorConstant.gray600,
                            fontSize: getFontSize(
                              14,
                            ),
                            fontFamily: 'SF UI Display',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "44",
                          style: TextStyle(
                            color: ColorConstant.blueGray900,
                            fontSize: getFontSize(
                              14,
                            ),
                            fontFamily: 'SF UI Display',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
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
