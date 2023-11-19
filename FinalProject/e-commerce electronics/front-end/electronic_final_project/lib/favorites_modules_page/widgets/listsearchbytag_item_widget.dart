import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/theme/app_decoration.dart';
import 'package:electronic_final_project/theme/app_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListsearchbytagItemWidget extends StatelessWidget {
  ListsearchbytagItemWidget();

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        width: getHorizontalSize(
          79,
        ),
        margin: getMargin(
          right: 10,
        ),
        padding: getPadding(
          left: 19,
          top: 7,
          right: 19,
          bottom: 7,
        ),
        decoration: AppDecoration.txtFillGray100.copyWith(
          borderRadius: BorderRadiusStyle.txtCircleBorder15,
        ),
        child: Text(
          "",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppStyle.txtSFUIDisplaySemibold12,
        ),
      ),
    );
  }
}
