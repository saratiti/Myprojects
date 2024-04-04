import 'package:flutter/material.dart';

import 'package:my_eco_print/core/localization/app_localization.dart';

import 'package:my_eco_print/view/screen/barcode/barcode_read.dart';
import 'package:my_eco_print/view/widgets/app_bar/appbar.dart';

class ScanCodeScreenRef1 extends StatefulWidget {
  @override
  _ScanCodeScreenRef1State createState() => _ScanCodeScreenRef1State();
}

class _ScanCodeScreenRef1State extends State<ScanCodeScreenRef1> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    return Center(
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context, "msg50"), 
          body: Center(
            child: ScanCodeScreenRef(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, String title) {
    final localization = AppLocalizationController.to;
    final textDirection =
        localization.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Directionality(
        textDirection: textDirection,
        child: buildAppBar(context, title), 
      ),
    );
  }
}
