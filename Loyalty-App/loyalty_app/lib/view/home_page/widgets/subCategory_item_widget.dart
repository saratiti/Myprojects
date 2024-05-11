// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';


class SubCategoryWidget extends StatelessWidget {
  SubCategoryWidget({Key? key}) : super(key: key);

  final CategoryController _categoryController = CategoryController();

  @override
  Widget build(BuildContext context) {
        mediaQueryData = MediaQuery.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
      ? TextDirection.rtl
      : TextDirection.ltr;

  return Directionality(
    textDirection: textDirection,
   child: FutureBuilder<List<Catalog>>(
      future: _categoryController.getFirstThree(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Catalog>? categories = snapshot.data;
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories!.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0), // Adjust spacing as needed
                  child: Column(
                    children: [
                      ClipOval(
                        child: CustomImageView(
                imagePath: ImageConstant.imgImg,
                height: 120.adaptSize,
                width: 120.adaptSize,
              ),
                      ),
                      const SizedBox(height: 7.0),
                      Text(
                        category.nameEnglish,
                        style: CustomTextStyles.labelLargeProximaNovaBluegray900,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
   ) );
  }
}
