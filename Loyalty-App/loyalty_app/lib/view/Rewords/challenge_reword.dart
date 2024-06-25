

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/model/challenge.dart';
class ChallengePage extends StatelessWidget {
  const ChallengePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 900),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 13.h),
            child: Text(
              "AVAILABLE CHALLENGES",
              style: CustomTextStyles.labelLargeGray600,
            ),
          ),
          SizedBox(height: 49.v),
          FutureBuilder<List<Challenge>>(
  future: ChallengeController().getUserChallenges(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      List<Challenge> challenges = snapshot.data ?? [];
      return Column(
        children: challenges.map((challenge) {
          return _buildChallengeCompleted(context, challenge);
        }).toList(),
      );
    }
  },
),

          SizedBox(height: 5.v),
        ],
      ),
    );
  }

Widget _buildChallengeCompleted(BuildContext context, Challenge challenge) {
 
 bool isCompleted = true;
 
 //challenge?.challenges != null && challenge?.completeDate != null;



  return Column(
    children: [
      const SizedBox(height: 20), 
      SizedBox(
        height: 200,
        width: double.maxFinite,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 7,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(right: 2),
                padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Padding(
  padding: const EdgeInsets.only(left: 22),
  child: Text(
    challenge?.name ?? '', 
    style: CustomTextStyles.titleSmallBluegray90002,
  ),
),

                    SizedBox(height: 23.v),
                    Padding(
                      padding: EdgeInsets.only(right: 51.h),
                      child: Row(
                        children: [
                          SizedBox(width: 30.v),
                          CustomImageView(
                            imagePath: ImageConstant.imgRectangle35,
                            height: 57.v,
                            width: 88.h,
                          ),
                          SizedBox(width: 12.h),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.only(left: 12),
                              child: Text(
  challenge?.description ?? '',
  style: const TextStyle(
    fontSize: 16,
  ),
),

                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 27.v),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 22.v,
                        width: 354.h,
                        decoration: BoxDecoration(
                          color: appTheme.redA100E5,
                          borderRadius: BorderRadius.circular(11.h),
                        ),
                        // child: LinearProgressIndicator(
                        //   value: isCompleted ? 1.0 : 0.0,
                        //   backgroundColor: Colors.grey[300],
                        //   valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                        // ),
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
                text: isCompleted ? "Challenge Completed!" : "Start Challenge",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

}