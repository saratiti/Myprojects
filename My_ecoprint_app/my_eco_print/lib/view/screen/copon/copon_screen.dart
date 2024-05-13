// ignore_for_file: library_private_types_in_public_api



import 'package:my_eco_print/core/app_export.dart';

class CoponScreen extends StatefulWidget {
  const CoponScreen({Key? key}) : super(key: key);

  @override
  _CoponScreenState createState() => _CoponScreenState();
}

class _CoponScreenState extends State<CoponScreen> {
  final TransactionController transactionController = TransactionController();
   String selectedSortOrder = 'desc';
String label24 = "";
  String label25 = ""; 
List<dynamic> transactions = [];
Future<void> fetchData(String sort) async {
  try {
    final List<Transaction> result = await transactionController.getAllTransactions();

    if (result.isNotEmpty) {
      setState(() {
        label24 = result[0].transactionType;
        label25 = result[0].points.toString();

        transactions = sortTransactions(result, sort);
      });
    } else {
      if (kDebugMode) {
        print('Empty result');
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('Error fetching data: $error');
    }
  }
}


List<Transaction> sortTransactions(List<Transaction> transactions, String sort) {
  if (sort == 'asc') {
    transactions.sort((a, b) => a.transactionDate.compareTo(b.transactionDate));
  } else {
    transactions.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
  }

  return transactions;
}





  @override
  Widget build(BuildContext context) {
 final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child:
    Scaffold(
      appBar: CustomAppBar(
        title: AppbarSubtitle(text: ''),
        actions: [
          AppbarImage(
            margin: EdgeInsets.fromLTRB(28.h, 21.v, 28.h, 22.v),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 4.v),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppBar(context),
             SizedBox(height: 26.v),
            // headerCoupon(),
            SizedBox(height: 26.v),
            buildCouponStack(),
          ],
        ),
      ),
    ));
  }

Widget buildCouponStack() {
  return FutureBuilder<List<Transaction>>(
    future: transactionController.getAllTransactions(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Text('No transactions available.');
      } else {
        List<Transaction> transactions = snapshot.data!;

        return SingleChildScrollView(
          child: SizedBox(
           
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
                    alignment: Alignment.center,
                  ),
                ),
                Align(
  alignment: Alignment.topCenter,
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 31.h),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            buildCouponContainer(transactions[index]),
            if (index < transactions.length - 1) SizedBox(height: 16.v),
          ],
        );
      },
    ),
  ),
),

              ],
            ),
          ),
        );
      }
    },
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





void onSortButtonClick(String sortOrder) {
  if (kDebugMode) {
    print('Sort button clicked: $sortOrder');
  }
  if (kDebugMode) {
    print('Sort button clicked: $sortOrder');
  }
  setState(() {
    selectedSortOrder = sortOrder;
  });

  fetchData(sortOrder);
}

Widget headerCoupon() {
 return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, right: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: TextButton(
                onPressed: () => onSortButtonClick('asc'),
                child: Text(
                  "lbl24".tr,
                  style: selectedSortOrder == 'asc'
                      ? CustomTextStyles.titleSmallBahijTheSansArabicLightgreen500
                      : CustomTextStyles.titleSmallBahijTheSansArabic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: TextButton(
                onPressed: () => onSortButtonClick('desc'),
                child: Text(
                  "lbl25".tr,
                  style: selectedSortOrder == 'desc'
                      ? CustomTextStyles.titleSmallBahijTheSansArabicLightgreen500
                      : CustomTextStyles.titleSmallBahijTheSansArabic,
                ),
              ),
            ),
            CustomImageView(
              svgPath: ImageConstant.imgLocation,
              height: 24,
              width: 24,
              margin: const EdgeInsets.only(left: 26),
            ),
          ],
        ),
      ));
}

Widget buildCouponContainer(Transaction transaction) {
  final localization = AppLocalizationController.to;

  final isRtl = localization.locale.languageCode == 'ar';

  return Directionality(
    textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.v),
      decoration: AppDecoration.outlineOnPrimaryContainer3.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded( 
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.v),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    getMessageForTransactionType(transaction.transactionType),
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis, 
                    maxLines: 2, 
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    transaction.points.toString(),
                    style: CustomTextStyles.titleSmallBahijTheSansArabicRed700,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.h),
          CustomIconButton(
            height: 44.adaptSize,
            width: 44.adaptSize,
            margin: EdgeInsets.only(top: 1.v),
            padding: EdgeInsets.all(11.h),
            child: CustomImageView(svgPath: getIconPathBasedOnTransactionType(transaction.transactionType)),
          ),
        ],
      ),
    ),
  );
}



  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapImgArrowleft(BuildContext context) {
    Navigator.pop(context);
  }

CustomAppBar buildAppBar(BuildContext context) {
final localization = AppLocalizationController.to;
final textDirection = localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

  return CustomAppBar(
    height: 40.v,
    leadingWidth: 52.h,
    leading: AppbarImage1(
      svgPath: (textDirection == TextDirection.rtl)
          ? ImageConstant.imgArrowright
          : ImageConstant.imgArrowleftOnprimary,
      margin: EdgeInsets.only(top: 5.v, bottom: 10),
      onTap: () {
        onTapArrowleft(context);
      },
    ),
    centerTitle: true,
    title: AppbarTitle(text:"lbl20_".tr),
  );
}

void onTapArrowleft(BuildContext context) {
  Navigator.pop(context);
}
}