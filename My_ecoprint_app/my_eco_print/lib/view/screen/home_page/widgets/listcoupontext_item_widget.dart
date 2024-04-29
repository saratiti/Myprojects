// ignore_for_file: library_private_types_in_public_api

import 'package:my_eco_print/core/app_export.dart';


class ListcoupontextItemWidget extends StatefulWidget {
  const ListcoupontextItemWidget({Key? key}) : super(key: key);

  @override
  _ListcoupontextItemWidgetState createState() =>
      _ListcoupontextItemWidgetState();
}

class _ListcoupontextItemWidgetState extends State<ListcoupontextItemWidget> {
List<Transaction> weeklyTransactions = [];

  @override
  void initState() {
    super.initState();
    fetchWeeklyTransactions();
  }

  Future<void> fetchWeeklyTransactions() async {
    try {
      final transactions =
          await TransactionController().getWeeklyTransactions();
      setState(() {
        weeklyTransactions = transactions;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching weekly transactions: $error');
      }
    }
  }

  @override
  void didUpdateWidget(covariant ListcoupontextItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    fetchWeeklyTransactions();
  }


  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizationController.to;

    final isRtl = localization.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.v),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: weeklyTransactions.length,
            itemBuilder: (context, index) {
              final transaction = weeklyTransactions[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.v),
                child: buildClothesContainer(
                  getMessageForTransactionType(transaction.transactionType),
                  transaction.points.toString(),
                  getIconPathBasedOnTransactionType(transaction.transactionType),
                ),
              );
            },
          ),
          SizedBox(height: 24.v),
        ],
      ),
    );
  }

  Widget buildClothesContainer(String message, String label, String iconPath) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.v),
      margin: EdgeInsets.only(bottom: 24.v),
      decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: theme.textTheme.titleMedium),
              Text(label,
                  style: CustomTextStyles.titleSmallBahijTheSansArabicRed700),
            ],
          ),
          CustomIconButton(
            height: 44.adaptSize,
            width: 44.adaptSize,
            margin: EdgeInsets.only(top: 3.v),
            padding: EdgeInsets.all(11.h),
            child: CustomImageView(svgPath: iconPath),
          ),
        ],
      ),
    );
  }

  String getMessageForTransactionType(String transactionType) {
    final localization = AppLocalizationController.to;
    final transactionTypeMessages = {
      'redemption': "msg30",
      'daily_points': "msg31",
      'apple_store_points_redemption': "msg32",
    };
    final translationKey = transactionTypeMessages[transactionType];
    return translationKey != null
        ? localization.getString(translationKey)
        : "Unknown transaction type";
  }

  String getIconPathBasedOnTransactionType(String transactionType) {
    if (transactionType == 'redemption') {
      return ImageConstant.imgMobile;
    } else if (transactionType == 'daily_points') {
      return ImageConstant.imgFile;
    } else {
      return ImageConstant.imgFire;
    }
  }
}
