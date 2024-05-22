// ignore_for_file: library_private_types_in_public_api

import 'package:my_eco_print/core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _isLoading = false;
      });

      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashScreenTwo()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.lightGreen500,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildContent(),
    );
  }

  Widget _buildContent() {
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
                  imagePath: ImageConstant.imgsplashScreen1,
                  fit: BoxFit.fill,
                  height: screenHeight,
                  width: screenWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
