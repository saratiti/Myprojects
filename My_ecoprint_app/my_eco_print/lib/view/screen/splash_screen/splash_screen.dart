// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/view/screen/splash_screen/splash_screen_two.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

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
              // Display a loading indicator while content is loading
              child: CircularProgressIndicator(),
            )
          : _buildContent(),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 116.v),
          child: SizedBox(
            height: 702.v,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  svgPath: ImageConstant.imgFingerprintWhiteA700,
                  height: 200.v,
                  width: 289.h,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 171.v),
                ),
                Opacity(
                  opacity: 0.03,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgGroup70252,
                    height: 702.v,
                    width: 393.h,
                    alignment: Alignment.center,
                    color: Colors.amber,
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 702.v,
                    height: 702.v,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: fs.Svg(
                          ImageConstant.imgGroup11,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
