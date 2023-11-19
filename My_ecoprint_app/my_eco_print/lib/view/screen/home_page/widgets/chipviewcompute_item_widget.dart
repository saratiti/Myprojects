import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';

class ChipviewcomputeItemWidget extends StatelessWidget {
  const ChipviewcomputeItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 190, 
            child: RawChip(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              showCheckmark: false,
              labelPadding: EdgeInsets.zero,
              label: Text(
                "lbl20".tr,
                style: TextStyle(
                  color: appTheme.whiteA700,
                  fontSize: 16,
                  fontFamily: 'Bahij TheSansArabic',
                  fontWeight: FontWeight.w500,
                ),
              ),
              deleteIcon: SizedBox(
                height: 40,
                width: 40,
                child: CustomImageView(
                  svgPath: ImageConstant.imgComputer,
                  color: Colors.white,
                ),
              ),
              onDeleted: () {},
              selected: false,
              backgroundColor: appTheme.red700,
              selectedColor: appTheme.lightGreen500,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (value) {
                Navigator.of(context).pushNamed(AppRoutes.replacePoints);
              },
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 190, 
            child: RawChip(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10), 
              showCheckmark: false,
              labelPadding: EdgeInsets.zero,
              label: Text(
                "lbl21".tr,
                style: TextStyle(
                  color: appTheme.whiteA700,
                  fontSize: 16, 
                  fontFamily: 'Bahij TheSansArabic',
                  fontWeight: FontWeight.w500,
                ),
              ),
              deleteIcon: SizedBox(
                height: 40,
                width: 40,
                child: CustomImageView(
                  svgPath: ImageConstant.imgFile,
                  color: Colors.white,
                ),
              ),
              onDeleted: () {},
              selected: false,
              backgroundColor: appTheme.lightGreen500,
              selectedColor: appTheme.lightGreen500,
              shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (value) {
                Navigator.of(context).pushNamed(AppRoutes.collectingPoints);
              },
            ),
          ),
        ],
      ),
    );
  }
}
