import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/theme/app_style.dart';
import 'package:flutter/material.dart';



class AppbarTitle extends StatelessWidget {
  AppbarTitle({required this.text, this.margin, this.onTap});

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppStyle.txtSFUIDisplaySemibold17.copyWith(
            color: ColorConstant.blueGray900,
          ),
        ),
      ),
    );
  }
}
