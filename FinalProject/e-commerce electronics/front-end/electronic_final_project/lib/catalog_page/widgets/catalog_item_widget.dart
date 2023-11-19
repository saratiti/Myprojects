import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/theme/app_style.dart';
import 'package:electronic_final_project/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class CatalogItemWidget extends StatelessWidget {
  final Product product;

  CatalogItemWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: getHorizontalSize(161),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    product.image,
                    height: 150,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(top: 8,left: 5),
              child: Row(
                children: [
                  Text(
                    product.price.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtSFUIDisplaySemibold14,
                  ),
                  CustomImageView(
                    svgPath: ImageConstant.imgArrowdown,
                    height: getVerticalSize(16),
                    width: getHorizontalSize(18),
                    margin: getMargin(left: 89),
                  ),
                ],
              ),
            ),
            Padding(
              padding: getPadding(top: 8,left: 5),
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: AppStyle.txtSFUIDisplayRegular14Gray600,
              ),
            ),
            Padding(
              padding: getPadding(top: 4),
              child: Text(
                product.brand.brand_name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtSFUIDisplayRegular14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
