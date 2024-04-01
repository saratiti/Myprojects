import 'package:flutter/material.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/controller/transaction_controller.dart'; // Import your TransactionController
import 'package:loyalty_app/model/transaction.dart';
import 'package:loyalty_app/view/rewords/widgets/points_item_widget.dart';
import 'package:loyalty_app/widgets/custom_elevated_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class TransactionPage extends StatelessWidget {
  final TransactionController _transactionController = TransactionController(); // Instantiate your TransactionController

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
      future: _transactionController.getAllTransactions(), // Use the method from your TransactionController to fetch transactions
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Transaction> transactions = snapshot.data ?? [];
          return Container(
            constraints: BoxConstraints(maxHeight: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.h,
                    right: 73.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1.v),
                        child: Text(
                          "Today",
                          style: CustomTextStyles.labelLargeGray600,
                        ),
                      ),
                      Text(
                        "Clear All",
                        style: CustomTextStyles.labelLargeGray600,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.v),
                _buildPoints(context, transactions),
                SizedBox(height: 69.v),
                Padding(
                  padding: EdgeInsets.only(left: 30.h),
                  child: Text(
                    "Yesterday",
                    style: CustomTextStyles.labelLargeGray600,
                  ),
                ),
                SizedBox(height: 5.v),
               // _buildPoints1(context, transactions),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildPoints(BuildContext context, List<Transaction> transactions) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 42.v,
            );
          },
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return PointsItemWidget(transaction: transactions[index]);
          },
        ),
      ),
    );
  }

}