import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';

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

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.map((category) {
            final index = categories.indexOf(category);
            return Padding(
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
                      child: category.imageBytesList != null && index < category.imageBytesList!.length
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6), // Changed to use BorderRadius.circular for all corners
                              child: Image.memory(
                                category.imageBytesList![index],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // Handle error when loading image
                                  print('Error loading image: $error');
                                  return const Text('Error loading image');
                                },
                              ),
                            )
                          : Container(), // Added empty container when imageBytesList is null or empty
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
            );
          }).toList(),
        ),
      ),
    );
  }
}
