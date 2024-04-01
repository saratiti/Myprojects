import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/routes/app_routes.dart';
import 'package:loyalty_app/view/receipt/widgets/receiptone_item_widget.dart';
import 'package:loyalty_app/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:loyalty_app/widgets/custom_bottom_bar.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_icon_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.v),
            _buildReceiptList(context),
            SizedBox(height: 24.v),
            _buildUploadButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptList(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(height: 24.v),
        itemCount: 1,
        itemBuilder: (context, index) => ReceiptoneItemWidget(),
      ),
    );
  }

Widget _buildUploadButton(BuildContext context) {
  return CustomElevatedButton(
    height: 55.v,
    text: "Upload Receipt",
    onPressed: () {
      Navigator.pushNamed(context, AppRoutes.receiptUploadScreen);
    },
    leftIcon: Padding(
      padding: EdgeInsets.only(right: 9.0), 
      child: Icon(
        Icons.cloud_upload,
        color: Colors.white,
        size: 24,
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
        "My Receipts",
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    ),
  );
}
}