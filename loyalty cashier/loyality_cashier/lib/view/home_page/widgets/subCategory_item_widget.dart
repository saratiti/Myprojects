// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:loyality_cashier/controller/category.dart';
import 'package:loyality_cashier/core/app_export.dart';
import 'package:loyality_cashier/model/category.dart';
import 'package:loyality_cashier/widgets/custom_image_view.dart';


// ignore: must_be_immutable
// class SubCategoryWidget extends StatelessWidget {
//   SubCategoryWidget({Key? key}) : super(key: key);

//   final CategoryController _categoryController = CategoryController();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Category>>(
//       future: _categoryController.getFirstThree(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           List<Category>? categories = snapshot.data;
//           return Container(
//             height: MediaQuery.of(context).size.height * 0.8,
//             width: MediaQuery.of(context).size.width, // Ensure bounded width
//             child: ListView.builder(
//               itemCount: categories!.length,
//               itemBuilder: (context, index) {
//                 Category category = categories[index];
//                 return Padding(
//                   padding: EdgeInsets.only(bottom: 16.0),
//                   child: Column(
//                     children: [
//                       ClipOval(
//                         child: CustomImageView(
//                 imagePath: ImageConstant.imgImg,
//                 height: 120.adaptSize,
//                 width: 120.adaptSize,
//               ),
//                       ),
//                       SizedBox(height: 7.0),
//                       Text(
//                         category.nameEnglish,
//                         style: CustomTextStyles.labelLargeProximaNovaBluegray900,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class SubCategoryWidget extends StatelessWidget {
  SubCategoryWidget({Key? key}) : super(key: key);

  final CategoryController _categoryController = CategoryController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Catalog>>(
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
    );
  }
}
