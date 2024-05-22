import 'package:my_eco_print/core/app_export.dart';

class SplashScreenTwo extends StatelessWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          // height: screenHeight,
          // width: screenWidth,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: CustomImageView(
                  imagePath: ImageConstant.imgsplashScreen,
                  fit: BoxFit.fill,
                  height: screenHeight,
                  width: screenWidth,
                ),
              ),
              Positioned(
                top: 250,
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "msg".tr,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style:
                  CustomTextStyles.titleLargeWhiteA700.copyWith(height: 1.84),
            ),
          ),
        ),
        const SizedBox(height: 250),
        Flexible(
          child: CustomOutlinedButton(
            width: MediaQuery.of(context).size.width * 0.8,
            text: "lbl".tr,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.loginScreen);
            },
          ),
        ),
      ],
    );
  }
}
