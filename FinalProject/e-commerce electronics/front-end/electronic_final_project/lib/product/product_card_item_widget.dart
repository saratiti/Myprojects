import 'package:electronic_final_project/controller/product_provider.dart';
import 'package:electronic_final_project/controller/review.dart';
import 'package:electronic_final_project/controller/whislist.dart';
import 'package:electronic_final_project/model/color.dart';
import 'package:electronic_final_project/model/product.dart';
import 'package:electronic_final_project/model/review.dart';
import 'package:electronic_final_project/model/size.dart';
import 'package:electronic_final_project/model/wishlist.dart';
import 'package:electronic_final_project/my_bag_page/my_cart_screen.dart';
import 'package:electronic_final_project/product/product_color.dart';
import 'package:electronic_final_project/product/product_review.dart';
import 'package:electronic_final_project/product/product_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  ProductDetailsPage({Key? key, required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String selectedColor = '';
  String selectedSize = '';
  bool isFavorite = false;
  String comment = '';
  double starRating = 0.0;
  late int productId;
  int selectedColorIndex = -1;

  @override
  void initState() {
    super.initState();
    productId = widget.product.id;
  }

  void _submitReview() async {
    if (comment.isEmpty) {
      EasyLoading.showError('Please enter a comment');
      return;
    }
    if (starRating == 0.0) {
      EasyLoading.showError('Please select a star rating');
      return;
    }

    final review = Review(
      comment: comment,
      rating: starRating,
      productId: productId,
    );

    await ReviewController().create(review);

    EasyLoading.showSuccess('Review submitted successfully');

    setState(() {
      comment = '';
      starRating = 0.0;
    });
  }

  void _selectColor(ColorProduct colorProduct) {
    setState(() {
      selectedColor = colorProduct.colors; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left),
        ),
        actions: [
          Consumer<ProductProvider>(
            builder: (context, productProvider, _) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      child: Text(
                        productProvider.cartItemCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          return ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .35,
                padding: const EdgeInsets.only(bottom: 30),
                width: double.infinity,
                child: Image.network(widget.product.image),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Color:',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            SizedBox(width: 2),
                            Container(
                            width: 140,
                              height: 140,
                              child: ColorProductUI(
                                onColorSelected: _selectColor,
                                productId: widget.product.id,
                              ),
                            ),
                            
                            Text('Selected Color: $selectedColor'),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Size:',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Container(
                              width: 200,
                              height: 100,
                              child: SizeProductUI(
                                onSizeSelected: (SizeProduct sizeProduct) {},
                                productId: widget.product.id,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),Divider(),
                    SizedBox(height: 4),
                    Text(
                      'Product Details',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.product.description,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Product Reviews',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<List<Review>>(
                      future: ReviewController().getProductReviews(productId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          final reviews = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: reviews.length,
                            itemBuilder: (context, index) {
                              return ProductReview(review: reviews[index]);
                            },
                          );
                        } else {
                          return Center(
                            child: Text('No reviews available.'),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Leave a Review',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: starRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          starRating = rating;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _submitReview();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 211, 210, 210),
                          ),
                          color: Color.fromARGB(255, 204, 203, 203),
                        ),
                        child: TextFormField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'Comment',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _submitReview();
                              },
                              child: Icon(Icons.send, color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.grey),
                          onChanged: (value) {
                            setState(() {
                              comment = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              final productProvider =
                                  Provider.of<ProductProvider>(context, listen: false);
                              productProvider.addToCart(widget.product);

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CartScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 100,
                              ),
                              child: Text(
                                'Buy Now',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                         IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite; 
              });
              Wishlist wishlist = Wishlist(productId: productId);
              WishlistController().create(wishlist).then((result) {}).catchError((error) {});
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.orange : Colors.orange, 
            ),
          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
