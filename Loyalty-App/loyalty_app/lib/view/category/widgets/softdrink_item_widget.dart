// ignore_for_file: library_private_types_in_public_api, must_be_immutable


import 'package:flutter/material.dart';

import 'package:loyalty_app/core/app_export.dart';


class SoftdrinkItemWidget extends StatelessWidget {
  final List<Catalog> categories;
  final int? selectedCategoryId;
  final Function(int) onSelectCategory;

  SoftdrinkItemWidget({super.key, 
    required this.categories,
    required this.selectedCategoryId,
    required this.onSelectCategory,
  });
  Map<int, String> categoryImageMap = {
    1: "assets/images/img_rectangle_39.png",
    2: "assets/images/img_rectangle_44.png",
    3: "assets/images/img_rectangle_24.png",
    
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
//                     child: Row(
//   children: [
//     for (var category in categories)
//       Expanded(
//         child: ClipRRect(
//           borderRadius: const BorderRadius.horizontal(left: Radius.circular(6)),
//           child: Image.memory(
//             category.imageBytesList as Uint8List,
//             width: 100,
//             height: 100,
//             fit: BoxFit.cover,
//             errorBuilder: (context, error, stackTrace) {
//               return const Text('Error loading image');
//             },
//           ),
//         ),
//       ),
//   ],
// ),


                    ),
                    SizedBox(height: 20.v),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Center(
                        child: Text(
                          category.nameEnglish,
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
    );
  }
}

