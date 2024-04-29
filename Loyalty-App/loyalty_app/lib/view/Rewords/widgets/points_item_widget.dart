
import 'package:loyalty_app/core/app_export.dart';


class PointsItemWidget extends StatelessWidget {
  final Transaction transaction; // Define a named parameter for the Transaction object
  const PointsItemWidget({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 111.v,
        width: 400.h,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(right: 6.h),
                padding: EdgeInsets.all(9.h),
                decoration: AppDecoration.outlineBlack,
                child: Row(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgImg120x120,
                      height: 92.v,
                      width: 107.h,
                      radius: BorderRadius.circular(
                        8.h,
                      ),
                      margin: EdgeInsets.only(bottom: 1.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 34.h,
                        top: 24.v,
                        bottom: 19.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 4.h),
                            child: Text(
                              transaction.transactionType, // Access properties of the Transaction object
                              style: CustomTextStyles.labelLargeBlack900,
                            ),
                          ),
                          SizedBox(height: 14.v),
                          Text(
                            "You just earned ${transaction.points} points!", // Access properties of the Transaction object
                            style: CustomTextStyles.labelLargeGray600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: CustomElevatedButton(
                width: 160.h,
                text: "+${transaction.points} points", // Access properties of the Transaction object
                alignment: Alignment.topRight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
