// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/view/rewords/challenge_reword.dart';
import 'package:loyalty_app/view/rewords/reword_page_content.dart';
import 'package:loyalty_app/view/rewords/transaction_reword.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class RewordPage extends StatefulWidget {
  const RewordPage({Key? key}) : super(key: key);

  @override
  _RewordPageState createState() => _RewordPageState();
}

class _RewordPageState extends State<RewordPage> {
  late PageController pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                _buildMegaphone(context),
                SizedBox(height: 61.v),
                SizedBox(height: 5.v),
                _buildTabContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMegaphone(BuildContext context) {
  return Container(
    height: 278.v,
    width: double.maxFinite,
    color: Colors.black.withOpacity(0.5),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgImg383x388,
          height: 278.v,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 20.0, 
          left: 20.0, 
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appTheme.deepOrange800,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 50,
            color: Colors.black.withOpacity(0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabBarItem("Available Rewards", 0),
                _buildTabBarItem("Challenges", 1),
                _buildTabBarItem("Transactions", 2),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget _buildTabBarItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPageIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _currentPageIndex == index
                  ? Colors.white
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_currentPageIndex) {
      case 0:
        return RewordContentPage();
      case 1:
        return const ChallengePage();
      case 2:
        return TransactionPage();
      default:
        return Container();
    }
  }
}
