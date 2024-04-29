import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:my_eco_print/core/app_export.dart';

class ScanCodeScreen extends StatefulWidget {
  const ScanCodeScreen({Key? key}) : super(key: key);

  @override
  State<ScanCodeScreen> createState() => _ScanCodeScreenState();
}

class _ScanCodeScreenState extends State<ScanCodeScreen> {
  ScannerViewController? controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final theme = Theme.of(context);
    final localization = AppLocalizationController.to;
    final textDirection = localization.locale.languageCode == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
        textDirection: textDirection,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: <Widget>[
                ScannerView(onScannerViewCreated: onScannerViewCreated),
                SizedBox(
                  width: mediaQueryData.size.width,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 42.h, vertical: 85.v),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: fs.Svg(ImageConstant.imgGroup48096454),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    onTapImgArrowleftone(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 24.adaptSize,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 84.h),
                                  child: Text(
                                    "lbl38".tr,
                                    style: CustomTextStyles.titleLargeWhiteA700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 270.v,
                            width: 271.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: DottedBorder(
                                    color: theme.colorScheme.primary,
                                    padding: EdgeInsets.all(3.h),
                                    strokeWidth: 3.h,
                                    radius: const Radius.circular(16),
                                    borderType: BorderType.RRect,
                                    dashPattern: const [6, 6],
                                    child: Container(
                                      height: 270.v,
                                      width: 271.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.h),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40.v),
                          Text(
                            "msg38".tr,
                            style: CustomTextStyles.titleMediumWhiteA700,
                          ),
                          SizedBox(height: 40.v),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void onTapImgArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  void onScannerViewCreated(ScannerViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    await controller.setLicense(
        'DLS2eyJoYW5kc2hha2VDb2RlIjoiMjAwMDAxLTE2NDk4Mjk3OTI2MzUiLCJvcmdhbml6YXRpb25JRCI6IjIwMDAwMSIsInNlc3Npb25QYXNzd29yZCI6IndTcGR6Vm05WDJrcEQ5YUoifQ==');
    await controller.init();
    await controller.startScanning();
    controller.scannedDataStream.listen((results) {
      setState(() {});
    });
  }

  String getBarcodeResults(List<BarcodeResult> results) {
    StringBuffer sb = StringBuffer();
    for (BarcodeResult result in results) {
      sb.write(result.format);
      sb.write("\n");
      sb.write(result.text);
      sb.write("\n\n");
    }
    if (results.isEmpty) sb.write("No QR Code Detected");
    return sb.toString();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
