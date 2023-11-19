// ignore_for_file: must_be_immutable, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';

class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({super.key, this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomAppBarState createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  List<BottomMenuModel> bottomMenuList = [
       BottomMenuModel(
      icon: ImageConstant.imgCut,
      activeIcon: ImageConstant.imgCut,
      type: BottomBarEnum.Cut,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgFingerprint,
      activeIcon: ImageConstant.imgFingerprint,
      type: BottomBarEnum.Fingerprint,
    ),

     BottomMenuModel(
        icon: ImageConstant.imgInfocircle,
        activeIcon: ImageConstant.imgInfocircle,
        type: BottomBarEnum.Infocircle,
        isSelected: true),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 141.v,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            bottomMenuList.length,
            (index) {
              return InkWell(
                onTap: () {
                  // Iterate through the menu items to set isSelected
                  for (var element in bottomMenuList) {
                    element.isSelected = false;
                  }
        
                  bottomMenuList[index].isSelected = true;

                  
                  widget.onChanged?.call(bottomMenuList[index].type);

                  setState(() {});
                },
                child: CustomImageView(
                  svgPath: bottomMenuList[index].isSelected
                      ? bottomMenuList[index].activeIcon
                      : bottomMenuList[index].icon,
                  height: bottomMenuList[index].isSelected
                      ? 34.adaptSize
                      : 68.v,
                  width: bottomMenuList[index].isSelected
                      ? 34.adaptSize
                      : 44.h,
                  color: bottomMenuList[index].isSelected
                      ? theme.colorScheme.primary 
                      : appTheme.lightGreen500, 
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


enum BottomBarEnum {
  Infocircle,
  Fingerprint,
  Cut,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
    this.isSelected = false,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;

  bool isSelected;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
