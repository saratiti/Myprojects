
import 'package:loyalty_app/core/app_export.dart';




class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: 
      
      
      CustomImageView(
        imagePath: ImageConstant.imgRectangle28,
        height: 86.v,
        width: 170.h,
        radius: BorderRadius.circular(
          15.h,
        ),
      ),
    );
  }
}
