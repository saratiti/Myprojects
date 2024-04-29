// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:intl/intl.dart';
import 'package:my_eco_print/core/app_export.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final Map<DateTime, bool> _collectedDates = {};

  @override
  void initState() {
    super.initState();
    _retrieveCollectedDates();
  }

  void _storeCollectedDates(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('collectedDates',
        _collectedDates.keys.map((date) => date.toString()).toList());
  }

  Future<void> _retrieveCollectedDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedDates = prefs.getStringList('collectedDates') ?? [];
    setState(() {
      _collectedDates.clear();
      for (String dateStr in storedDates) {
        DateTime date = DateTime.parse(dateStr);
        _collectedDates[date] = true;
      }
    });
  }

  Future<int> collectDaily() async {
    try {
      User user = await UserController().getUser();

      if (user.id != null) {
        var dailyPoints = await PointController().collectDailyPoints();

        Provider.of<UserProfileModel>(context, listen: false)
            .updateTotalPoints(dailyPoints);

        _storeCollectedDates(user.id!);

        return dailyPoints;
      } else {
        throw Exception("User ID is null or not available");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error collecting daily points: $e");
      }
      return 0;
    }
  }

  void _showPopDialog(BuildContext context, int dailyPoints) async {
    String messageText = dailyPoints > 0 ? "msg37".tr : "msg36".tr;
    User user = await UserController().getUser();
    DateTime now = DateTime.now();
    if (dailyPoints > 0) {
      setState(() {
        _collectedDates[now] = true;
      });
      _storeCollectedDates(user.id!);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 41.h, right: 41.h, bottom: 150.v),
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.v),
            decoration: AppDecoration.fillWhiteA
                .copyWith(borderRadius: BorderRadiusStyle.circleBorder28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  svgPath: ImageConstant.imgClose,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                  onTap: () {
                    onTapImgCloseone(context);
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 24.v, right: 59.h),
                    child: Text(
                      dailyPoints > 0 ? "lbl37".tr : "msg_36".tr,
                      style: theme.textTheme.displaySmall,
                    ),
                  ),
                ),
                SizedBox(height: 46.v),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 156.h,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: messageText,
                            style: theme.textTheme.titleMedium,
                          ),
                          if (dailyPoints > 0)
                            TextSpan(
                              text: " $dailyPoints",
                              style: CustomTextStyles.titleMediumLightgreen500,
                            ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat dateFormat = DateFormat('dd');

    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final List<int> daysList = List.generate(daysInMonth, (index) => index + 1);
    final localization = AppLocalizationController.to;

    final isRtl = localization.locale.languageCode == 'ar';

    return Column(
      crossAxisAlignment:
          isRtl ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Align(
          alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 20.v, left: 30.h, right: 20.h),
            child: Text("lbl26".tr,
                style: CustomTextStyles.titleSmallBahijTheSansArabic15),
          ),
        ),
        SizedBox(height: 24.v),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicWidth(
            child: Padding(
              padding: EdgeInsets.only(
                  right: isRtl ? 0 : 28.h, left: isRtl ? 28.h : 0),
              child: Row(
                children: daysList.map((day) {
                  final DateTime date = DateTime(now.year, now.month, day);
                  final String formattedDate = dateFormat.format(date);
                  final String labelKey = 'lbl${201 + day - 1}';
                  final String label = _getLocalizedLabel(context, labelKey);
                  final double leftMargin = day == daysList.first ? 0 : 12.h;

                  final bool isToday = date.day == now.day &&
                      date.month == now.month &&
                      date.year == now.year;
                  return GestureDetector(
                    onTap: () async {
                      if (isToday) {
                        int dailyPoints = await collectDaily();
                        if (dailyPoints > 0) {
                          setState(() {
                            _collectedDates[date] = true;
                          });
                        }
                        _showPopDialog(context, dailyPoints);
                      }
                    },
                    child: _collectedDates[date] ?? false
                        ? _buildCheckmarkContainer(formattedDate, label,
                            leftMargin: leftMargin)
                        : _buildCard(context, formattedDate, label, date,
                            leftMargin: leftMargin, isClickable: isToday),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getLocalizedLabel(BuildContext context, String labelKey) {
    final localizationController = AppLocalizationController.to;
    return localizationController.getString(labelKey);
  }

  Widget _buildCard(BuildContext context, String formattedDate, String label,
      DateTime cardDate,
      {double leftMargin = 0, bool isClickable = true}) {
    final user = Provider.of<UserProfileModel>(context);
    bool isCollectedByCurrentUser = _collectedDates[cardDate] ?? false;

    return GestureDetector(
      onTap: () async {
        if (isClickable) {
          int dailyPoints = await collectDaily();
          if (dailyPoints > 0) {
            setState(() {
              _collectedDates[cardDate] = true;
              isCollectedByCurrentUser = true; // Update the variable
            });
            _storeCollectedDates(user.userId);
          }
          _showPopDialog(context, dailyPoints);
        }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: EdgeInsets.only(left: leftMargin),
        color: appTheme.whiteA700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.circleBorder28,
        ),
        child: Container(
          height: 103.v,
          width: 61.h,
          padding: EdgeInsets.symmetric(horizontal: 11.h, vertical: 24.v),
          decoration: AppDecoration.outlineOnPrimaryContainer4.copyWith(
            borderRadius: BorderRadiusStyle.circleBorder28,
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '$label',
                  textAlign: TextAlign.right,
                  style: CustomTextStyles.bahijTheSansArabicOnPrimary,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    formattedDate,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.headlineMedium,
                  ),
                ),
              ),
              if (isCollectedByCurrentUser)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: _buildCheckmarkContainer(formattedDate, label),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckmarkContainer(String formattedDate, String label,
      {double leftMargin = 0}) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin),
      padding: EdgeInsets.symmetric(horizontal: 13.h, vertical: 17.v),
      decoration: AppDecoration.outlineOnPrimaryContainer5.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            svgPath: ImageConstant.imgCheckmarkWhiteA700,
            height: 10.adaptSize,
            width: 10.adaptSize,
          ),
          SizedBox(height: 5.v),
          Text(
            formattedDate,
            style: CustomTextStyles.bahijTheSansArabicWhiteA700,
          ),
          Text(
            label,
            style: CustomTextStyles.bahijTheSansArabicWhiteA700,
          ),
        ],
      ),
    );
  }
}
