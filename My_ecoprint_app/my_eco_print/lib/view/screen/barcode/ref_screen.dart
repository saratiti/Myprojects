// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_eco_print/core/app_export.dart';



class ScanCodeScreenRef1 extends StatefulWidget {
  const ScanCodeScreenRef1({super.key});

  @override
  _ScanCodeScreenRef1State createState() => _ScanCodeScreenRef1State();
}

class _ScanCodeScreenRef1State extends State<ScanCodeScreenRef1> {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context, "msg50"), 
          body: const Center(
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
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Directionality(
        textDirection: textDirection,
        child: buildAppBar(context, title), 
      ),
    );
  }
}
