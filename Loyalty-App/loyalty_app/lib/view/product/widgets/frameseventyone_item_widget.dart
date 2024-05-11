// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';

// ignore: must_be_immutable
class FrameseventyoneItemWidget extends StatefulWidget {
  const FrameseventyoneItemWidget({Key? key}) : super(key: key);

  @override
  _FrameseventyoneItemWidgetState createState() => _FrameseventyoneItemWidgetState();
}

class _FrameseventyoneItemWidgetState extends State<FrameseventyoneItemWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
         mediaQueryData = MediaQuery.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,
   child: GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        width: 120.h,
        padding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 8.v,
        ),
        decoration: BoxDecoration(
          color: isSelected ? appTheme.deepOrange800 : appTheme.gray500Cc,
          borderRadius: BorderRadiusStyle.roundedBorder15,
        ),
        child: Text(
          "White Chocolate",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
   ) );
  }
}
