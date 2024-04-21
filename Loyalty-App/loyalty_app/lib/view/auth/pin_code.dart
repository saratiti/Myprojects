// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loyalty_app/controller/user.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/localization/app_localization.dart';
import 'package:loyalty_app/core/routes/app_routes.dart';
import 'package:loyalty_app/widgets/custom_pin_code_text_field.dart';

class PinCodePasswordScreen extends StatefulWidget {
  const PinCodePasswordScreen({Key? key}) : super(key: key);

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
                                      "msg12",
                                      style: CustomTextStyles
                                          .titleMediumGray100
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
                                              text: "msg20",
                                              style:
                                                  theme.textTheme.bodyMedium,
                                            ),
                                            TextSpan(
                                              text: "lbl_62",
                                              style: CustomTextStyles
                                                  .bodyMediumInterGray60001,
                                            ),
                                            const TextSpan(
                                              text: "lbl13",
                                              
                                                  
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
                                        if (kDebugMode) {
                                          print('PIN changed: $pin');
                                        }
                                        if (pin.length == 6) {
                                          userController.verifyPinCode(
                                              context, userEmail, pin);
                                        }
                                      },
                                     onPinFilled: (pin) async {
  if (kDebugMode) {
    print('PIN filled: $pin');
  }
  bool isPinCorrect = await userController.verifyPinCode(context, userEmail, pin);

  if (isPinCorrect) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushNamed(AppRoutes.resetPassowrd, arguments: {'email': userEmail});
    });
  } else {
    // Show an error dialog for incorrect PIN
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Incorrect PIN'),
        content: const Text('Please try again with the correct PIN.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
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
                                        
                                       StreamBuilder<int>(
  stream: Stream.periodic(const Duration(seconds: 1), (i) => i),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      int remainingTime = _countdownMinutes * 60 - snapshot.data!;
      int minutes = remainingTime ~/ 60;
      int seconds = remainingTime % 60;
      return Text(
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
        style: CustomTextStyles.bodySmallGray400,
      );
    } else {
      return const Text("Loading..."); // or any other placeholder
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
                                            "msg21",
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
                    ],
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