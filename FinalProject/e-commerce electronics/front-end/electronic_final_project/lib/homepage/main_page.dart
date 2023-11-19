import 'package:electronic_final_project/category/list_category.dart';
import 'package:electronic_final_project/category/sub_category.dart';
import 'package:electronic_final_project/controller/category.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';

import 'package:electronic_final_project/product/list_product.dart';

import 'package:electronic_final_project/theme/app_style.dart';
import 'package:electronic_final_project/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:electronic_final_project/homepage/main_image.dart';
import 'package:electronic_final_project/model/category.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
 
 @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainImage(),
            Padding(
              padding: getPadding(
                top: 7,
              ),
              child: Text(
                "Smart Buy".toUpperCase(),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppStyle.txtSFUIDisplayHeavy17,
              ),
            ),
            Padding(
              padding: getPadding(
                top: 4,
              ),
              child: Text(
                "Welcome",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
            textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.grey,
        )),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppStyle.txtSFUIDisplayHeavy17,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoriesScreen(categories: [],)),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'View All',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: AppStyle.txtSFUIDisplayMedium15,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color:  Color.fromARGB(255, 169, 168, 167),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Category>>(
              future: CategoryController().getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Category> categories = snapshot.data!;
                  return Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: ListCategory(category: categories.take(4).toList()), 
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Top Products',
                    style: AppStyle.txtSFUIDisplayHeavy17,
                  ),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Row(
                      children: [
                       
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: ListProduct(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
  onChanged: (item) {
    navigateToPage(context, item);
  },
  selectedBottomBarItem: BottomBarEnum.Main, 
),

    ),
  );
}

}
