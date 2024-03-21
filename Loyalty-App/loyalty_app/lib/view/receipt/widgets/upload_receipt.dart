


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class uploadReceipt extends StatelessWidget {
  const uploadReceipt({Key? key})
      : super(
          key: key,
        );

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: DottedBorder(
                    color: appTheme.deepOrange800.withOpacity(0.43),
                    padding: EdgeInsets.all(10.0),
                    strokeWidth: 2.0,
                    radius: Radius.circular(10.0),
                    borderType: BorderType.RRect,
                    dashPattern: [5, 5],
                    child: Container(
                      padding: EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center, 
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgUploadIconPrimary,
                            height: 100.0,
                            width: 100.0,
                          ),
                          SizedBox(height: 20.0),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Drag & drop files or ",
                                  style: CustomTextStyles.titleMediumMulishff0e0e0e,
                                ),
                                TextSpan(
                                  text: "Browse",
                                  style: CustomTextStyles.titleMediumMulishffd1512d.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            "Supported formats: JPEG, PNG, PDF",
                            style: CustomTextStyles.bodyMediumInterGray60001,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              CustomElevatedButton(
                height: 60.0,
                text: "Continue",
                buttonStyle: CustomButtonStyles.outlineBlue,
                buttonTextStyle: CustomTextStyles.titleLargeWhiteA700,
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    ),
  );
}
PreferredSizeWidget _buildAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight),
    child: AppBar(
      elevation: 0,
      leadingWidth: 40.0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: appTheme.deepOrange800,
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
      title: Text(
        "Upload Receipts",
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
  );
}

}