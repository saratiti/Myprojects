

import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:flutter/material.dart';
class SoftdrinkItemWidget extends StatelessWidget {
  final List<Catalog> categories;
  final int? selectedCategoryId;
  final Function(int) onSelectCategory;

  SoftdrinkItemWidget({
    Key? key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelectCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizationController.to;
    final isEnglish = localization.locale.languageCode == 'en';
      mediaQueryData = MediaQuery.of(context);
  
    final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,
   child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var category in categories)
            Padding(
              padding: EdgeInsets.only(right: 24.h),
              child: GestureDetector(
                onTap: () {
                  onSelectCategory(category.categoryId);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 122.adaptSize,
                      width: 122.adaptSize,
                      padding: EdgeInsets.symmetric(
                        horizontal: 31.h,
                        vertical: 3.v,
                      ),
                      decoration: AppDecoration.outlineBlueGrayAd.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder24,
                      ),
                    ),
                    SizedBox(height: 20.v),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Center(
                        child: Text(
                          isEnglish ? category.nameEnglish.localized : category.nameArabic.localized,
                          style: CustomTextStyles.titleSmallSenBluegray90001.copyWith(
                            color: appTheme.blueGray90001,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
   ) );
  }
}
