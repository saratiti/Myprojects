import 'package:electronic_final_project/controller/review.dart';
import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/review.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_image.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_title.dart';
import 'package:electronic_final_project/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class MyReviewScreen extends StatefulWidget {
  @override
  _MyReviewScreenState createState() => _MyReviewScreenState();
}

class _MyReviewScreenState extends State<MyReviewScreen> {
  List<Review> reviews = [];
int ?reviewId;
  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      List<Review> fetchedReviews = await ReviewController().getUserReview();
      setState(() {
        reviews = fetchedReviews;
      });
    } catch (error) {
     
    }
  }
  Future<void> deleteReview(int index) async {
    try {
      await ReviewController().deleteReview(reviews[index].id!); 
      setState(() {
        reviews.removeAt(index);
      });
      print('Order deleted successfully.');
    } catch (error) {
      print('Error deleting order: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to delete order. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
@override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final availableHeight = screenSize.height - kToolbarHeight - 100;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Column(
          children: [
            CustomAppBar(
              height: getVerticalSize(100),
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(left: 20, right: 20),
                    child: Row(
                      children: [
                        AppbarImage(
                          height: getSize(24),
                          width: getSize(24),
                          svgPath: ImageConstant.imgArrowleftBlueGray900,
                          margin: getMargin(top: 15),
                          onTap: () {
                            onTapArrowleft(context);
                          },
                        ),
                        AppbarTitle(
                          text: "My Review",
                          margin: getMargin(left: 113, top: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: reviews.isEmpty
                    ? Center(child: Text('No Reviews found'))
                    : ListView.builder(
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          Review review = reviews[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              height: 120,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 2.0,
                                child: ListTile(
                                  leading: review.product != null
                                      ? Image.network(
                                          review.product!.image ?? '',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : SizedBox.shrink(),
                                  title: Text(
                                    review.product?.name ?? 'Unknown Product',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.yellow),
                                          Text(review.rating.toString()),
                                        ],
                                      ),
                                      Text(review.comment),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete_outline),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Remove Review'),
                                          content: Text('Are you sure you want to remove this review?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                        TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                        deleteReview(index);
                                                      },
                                                      child: Text('Remove'),
                                                    ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
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
  void onTapArrowleft(BuildContext context) {
    Navigator.of(context).pop();
  }
}
