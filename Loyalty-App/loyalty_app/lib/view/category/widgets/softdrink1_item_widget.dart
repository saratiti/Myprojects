import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loyalty_app/controller/category.dart';
import 'package:loyalty_app/core/app_export.dart';
import 'package:loyalty_app/core/routes/app_routes.dart';
import 'package:loyalty_app/model/product.dart';
import 'package:loyalty_app/widgets/custom_icon_button.dart';
import 'package:loyalty_app/widgets/custom_image_view.dart';

class Softdrink1ItemWidget extends StatefulWidget {
  final int categoryId;

  const Softdrink1ItemWidget({Key? key, required this.categoryId}) : super(key: key);

  @override
  _Softdrink1ItemWidgetState createState() => _Softdrink1ItemWidgetState();
}

class _Softdrink1ItemWidgetState extends State<Softdrink1ItemWidget> {
  late Future<List<Product>> _productsFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  void didUpdateWidget(Softdrink1ItemWidget oldWidget) {
    if (widget.categoryId != oldWidget.categoryId) {
      _fetchProducts();
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _fetchProducts() async {
    try {
      List<Product> products = await CategoryController().getProductsByCategory(widget.categoryId);
      setState(() {
        _productsFuture = Future.value(products);
      });
    } catch (ex) {
      print('Error fetching products: $ex');
    }
  }

   @override
Widget build(BuildContext context) {
  return FutureBuilder<List<Product>>(
    future: _productsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
        return Center();
      } else {
        return SingleChildScrollView(
  child: GridView.builder(
    shrinkWrap: true, 
    physics: NeverScrollableScrollPhysics(), 
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0, 
      childAspectRatio: 166.h / 190.v, 
    ),
    itemCount: snapshot.data!.length ,
    itemBuilder: (context, index) {
      return _buildProduct(context, snapshot.data![index]);
    },
  ),
);

      }
    },
  );
}

  Widget _buildProduct(BuildContext context, Product product) {
    return  GestureDetector(
    onTap: () {
      _navigateToProductDetails(context,product.id);
    },
    child:
    
    
    Container(
      width: 166.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 39.0),
                  Text(
                    product.nameEnglish,
                    style: CustomTextStyles.titleSmallSenBluegray90001.copyWith(
                      color: appTheme.blueGray90001,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    product.description,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: appTheme.blueGray600,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Container(
                    width: 136.0,
                    margin: EdgeInsets.only(left: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          initialRating: product.price,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        CustomIconButton(
                          height: 31.0,
                          width: 32.0,
                          padding: EdgeInsets.all(9.0),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgPlusWhiteA700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // CustomImageView(
          //   imagePath: product.image ?? "",
          //   height: 89.0,
          //   width: 60.0,
          //   alignment: Alignment.topLeft,
          //   margin: EdgeInsets.only(left: 48.0),
          // ),
        ],
      ),
     ) );
  }
void _navigateToProductDetails(BuildContext context, int productId) {
  Navigator.of(context).pushNamed(
    AppRoutes.productDetailsScreen,
    arguments: {'productId': productId},
  );
}



}
