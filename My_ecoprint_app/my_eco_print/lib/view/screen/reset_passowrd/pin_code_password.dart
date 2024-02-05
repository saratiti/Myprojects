import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_eco_print/controller/api_helper.dart';
import 'package:my_eco_print/controller/user.dart';
import 'package:my_eco_print/core/app_export.dart';
import 'package:my_eco_print/view/screen/reset_passowrd/rest_password_screen.dart';

class PinCodePasswordScreen extends StatefulWidget {
  PinCodePasswordScreen({Key? key}) : super(key: key);

  @override
  _PinCodePasswordScreenState createState() => _PinCodePasswordScreenState();
}

class _PinCodePasswordScreenState extends State<PinCodePasswordScreen> {
  final TextEditingController pinController = TextEditingController();
  late Timer _timer;
  int _countdownMinutes = 5;

  void startTimer() {
    const oneMinute = Duration(minutes: 1);

    _timer = Timer.periodic(oneMinute, (Timer timer) {
      setState(() {
        if (_countdownMinutes > 0) {
          _countdownMinutes--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void deactivate() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = UserController();
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String userEmail = arguments['email'] ?? '';
    mediaQueryData = MediaQuery.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

     return Directionality(
      textDirection: textDirection,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ListView(
            children: [
              SizedBox(
            width: mediaQueryData.size.width,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 92.v),
              child: SizedBox(
                height: 878.v,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 854.v,
                        width: double.maxFinite,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Opacity(
                              opacity: 0.1,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgGroup70252,
                                height: 702.v,
                                width: 393.h,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 46.h,
                                  top: 162.v,
                                  right: 46.h,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "msg12".tr,
                                      style: CustomTextStyles
                                          .titleLargeFFShamelFamilyLightgreen500,
                                    ),
                                    Container(
                                      width: 252.h,
                                      margin: EdgeInsets.only(
                                        left: 23.h,
                                        top: 14.v,
                                        right: 24.h,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "msg20".tr,
                                              style:
                                                  theme.textTheme.bodyMedium,
                                            ),
                                            TextSpan(
                                              text: "lbl_62".tr,
                                              style: CustomTextStyles
                                                  .bodyMediumLightgreen500,
                                            ),
                                            TextSpan(
                                              text: "lbl13".tr,
                                              style:
                                                  theme.textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    CustomPinCodeTextField(
                                      controller: pinController,
                                      context: context,
                                      margin: EdgeInsets.only(
                                        top: 41.v,
                                        right: 1.h,
                                      ),
                                      onChanged: (pin) {
                                        print('PIN changed: $pin');
                                        if (pin.length == 6) {
                                          userController.verifyPinCode(
                                              context, userEmail, pin);
                                        }
                                      },
                                      onPinFilled: (pin) async {
                                        print('PIN filled: $pin');
                                        bool isPinCorrect =
                                            await userController.verifyPinCode(
                                                context, userEmail, pin);

                                       if (isPinCorrect) {
  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(context).pushNamed(AppRoutes.resetPassowrd,
        arguments: {'email': userEmail});
  });
} 
 else {
                                         
                                          await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Incorrect PIN'),
                                              content: Text(
                                                  'Please try again with the correct PIN.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(height: 10.v),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                          svgPath: ImageConstant.imgClock,
                                          height: 13.v,
                                          width: 11.h,
                                          margin: EdgeInsets.only(bottom: 2.v),
                                        ),
                                       StreamBuilder<int>(
  stream: Stream.periodic(Duration(seconds: 1), (i) => i),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      int remainingTime = _countdownMinutes * 60 - snapshot.data!;
      int minutes = remainingTime ~/ 60;
      int seconds = remainingTime % 60;
      return Text(
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
        style: CustomTextStyles.bodySmallReadexPro,
      );
    } else {
      return Text("Loading..."); // or any other placeholder
    }
  },
),

                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                           
                                            await userController
                                                .sendPinForEmailVerification(
                                                    userEmail);
                                          },
                                          child: Text(
                                            "msg21".tr,
                                            style:
                                                theme.textTheme.bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomImageView(
                      svgPath: ImageConstant.imgFingerprintLightGreen500,
                      height: 163.v,
                      width: 289.h,
                      alignment: Alignment.topCenter,
                )],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}