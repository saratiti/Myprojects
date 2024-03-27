import 'package:flutter/material.dart';
import 'package:loyalty_app/controller/category.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/model/category.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';
import 'softdrink1_item_widget.dart'; 

class SoftdrinkItemWidget extends StatefulWidget {
  const SoftdrinkItemWidget({Key? key}) : super(key: key);

  @override
  _SoftdrinkItemWidgetState createState() => _SoftdrinkItemWidgetState();
}

class _SoftdrinkItemWidgetState extends State<SoftdrinkItemWidget> {
  late List<Category> _categories;
  bool _isLoading = true;
  int? _selectedCategoryId;

  Map<int, String> categoryImageMap = {
    1: "assets/images/img_rectangle_39.png",
    2: "assets/images/img_rectangle_44.png",
    3: "assets/images/img_rectangle_24.png",
    // Add more category IDs and corresponding images here
  };

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await CategoryController().getAll();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (ex) {
      print('Error fetching categories: $ex');
    }
  }

  @override
Widget build(BuildContext context) {
  return _isLoading
      ? SizedBox(
          height: 122.h,
          child: Padding(
            padding: EdgeInsets.only(top: 1.v),
            child: CircularProgressIndicator(),
          ),
        )
      : SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Padding(
                  padding: EdgeInsets.only(top: 1.v),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var category in _categories)
                          Padding(
                            padding: EdgeInsets.only(right: 24.h),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategoryId = category.id;
                                });
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
                                    child: CustomImageView(
                                      imagePath: categoryImageMap[category.id] ?? "",
                                      height: 89.v,
                                      width: 60.h,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                                  SizedBox(height: 20.v),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30, right: 30, top: 10),
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
                  ),
                ),
              ),
              // Render Softdrink1ItemWidget if a category is selected
              if (_selectedCategoryId != null)
             
 Softdrink1ItemWidget(categoryId: _selectedCategoryId!),


            ],
          ),
        );
}
}