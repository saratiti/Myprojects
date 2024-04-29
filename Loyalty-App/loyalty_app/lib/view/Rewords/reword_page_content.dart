


// ignore_for_file: must_be_immutable, unused_local_variable


import 'package:loyalty_app/core/app_export.dart';


class RewordContentPage extends StatelessWidget {
  RewordContentPage({super.key});

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
                    "AVAILABLE REWORDS",
                    style: CustomTextStyles.labelLargeGray600,
                  ),
                ),
                  SizedBox(height: 49.v),
        _buildRectangleTwo(context),
        SizedBox(height: 61.v),
        Row(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgClose,
              height: 31.v,
              width: 39.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 11.h),
              child: Text(
                "Hottest Rewards",
                style: CustomTextStyles.titleMediumPoppinsGray900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10), 
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 19.h, right: 28.h),
            child: _buildSoftDrinkGridView(context),
          ),
        ),
      ],
    ),
  );
  }




int userPoints = 60;
  Widget _buildRectangleTwo(BuildContext context) {
    double bronzeProgress = (userPoints <= 500) ? userPoints / 500 : 1.0;
    double silverProgress = (userPoints > 500 && userPoints <= 1000)
        ? (userPoints - 500) / 500
        : (userPoints > 1000)
            ? 1.0
            : 0.0;
    double goldProgress = (userPoints > 1000 && userPoints <= 1500)
        ? (userPoints - 1000) / 500
        : (userPoints > 1500)
            ? 1.0
            : 0.0;

    return SizedBox(
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
          Positioned(
            bottom: 22,
            left: 50,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgBronzeMedal,
                        height: 70,
                        width: 60,
                        radius: BorderRadius.circular(30),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LinearPercentIndicator(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          lineHeight: 8.0,
                          percent: bronzeProgress,
                          backgroundColor: Colors.grey,
                          progressColor: appTheme.deepOrangeA700E5,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgSilverMedal,
                        height: 70,
                        width: 60,
                        radius: BorderRadius.circular(30),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LinearPercentIndicator(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          lineHeight: 8.0,
                          percent: silverProgress,
                          backgroundColor: Colors.grey,
                          progressColor: appTheme.deepOrangeA700E5,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGoldMedal,
                        height: 70,
                        width: 60,
                        radius: BorderRadius.circular(30),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "Come back everyday and collect 5 free points",
                    style: CustomTextStyles.titleSmallBluegray90002,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 13,
            left: 25,
            right: 29,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Text(
                    "Current Points",
                    style: CustomTextStyles.titleMediumPoppinsGray900,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: CustomElevatedButton(
              height: 46,
              width: 179,
              text: "Come back in 22:45:23",
              buttonTextStyle: CustomTextStyles.labelLargeInterGray100,
              alignment: Alignment.centerRight,
            ),
          ),
        ],
      ),
    );
  }


Widget _buildSoftDrinkGridView(BuildContext context) {
  return GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 12.0,
    crossAxisSpacing: 25.0,
    childAspectRatio: 166.h / 190.v,
    children: [
      _buildProduct02(
        context,
        softDrink: "SoftDrink",
        cafenioRestaurant: "Rose garden",
        price: "40",
      ),
      _buildProduct02(
        context,
        softDrink: "SoftDrink",
        cafenioRestaurant: "Cafenio Restaurant",
        price: "60",
      ),
    ],
  );
}


Widget _buildProduct02(
  BuildContext context, {
  required String softDrink,
  required String cafenioRestaurant,
  required String price,
}) {
  return SizedBox(
    height: 190.v,
    width: 166.h,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 13.h,
                vertical: 10.v,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Colors.white, 
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 39.v),
                  Text(
                    softDrink,
                    style: CustomTextStyles.titleSmallSenBluegray90001.copyWith(
                      color: appTheme.blueGray90001,
                    ),
                  ),
                  SizedBox(height: 5.v),
                  Text(
                    cafenioRestaurant,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: appTheme.blueGray600,
                    ),
                  ),
                  SizedBox(height: 3.v),
                  Container(
                    width: 136.h,
                    margin: EdgeInsets.only(left: 3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 6.v,
                            bottom: 4.v,
                          ),
                          child: Text(
                            price,
                            style: CustomTextStyles.titleMediumSenBluegray90001
                                .copyWith(
                              color: appTheme.blueGray90001,
                            ),
                          ),
                        ),
                        CustomIconButton(
                          height: 31.v,
                          width: 32.h,
                          padding: EdgeInsets.all(9.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgPlusWhiteA700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgRectangle39,
            height: 89.v,
            width: 60.h,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 48.h),
          ),
        ],
      ),
    ),
  );
}




}
