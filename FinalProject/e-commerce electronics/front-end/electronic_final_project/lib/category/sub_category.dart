import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/category.dart';
import 'package:electronic_final_project/theme/app_decoration.dart';
import 'package:electronic_final_project/theme/app_style.dart';
import 'package:flutter/material.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({
    Key? key,
    required this.category,
  }) : super(key: key);

  final List<Category> category;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: getPadding(
        left: 16,
        top: 22,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: category.map((categorys) {
          return Container(
            height: getSize(92),
            width: getSize(92),
            margin: getMargin(top: 3, bottom: 3),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  categorys.image ?? '',
                  height: getSize(92),
                  width: getSize(92),
                  fit: BoxFit.cover,
                ),
                Container(
                  height: getSize(92),
                  width: getSize(92),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                    child: Text(
                      categorys.name,
                      maxLines: null,
                      textAlign: TextAlign.center,
                      style: AppStyle.txtSFUIDisplayMedium12.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
