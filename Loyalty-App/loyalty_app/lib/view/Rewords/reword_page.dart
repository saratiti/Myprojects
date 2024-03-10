import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/view/Rewords/challenge_reword.dart';
import 'package:loyalty_app/view/Rewords/reword_page_content.dart';
import 'package:loyalty_app/view/Rewords/transaction_reword.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class RewordPage extends StatefulWidget {
  RewordPage({Key? key}) : super(key: key);

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
        padding: EdgeInsets.symmetric(horizontal: 20),
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
          style: TextStyle(
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
        return ChallengePage();
      case 2:
        return TransactionPage();
      default:
        return Container();
    }
  }
}
