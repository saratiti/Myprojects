import 'package:electronic_final_project/controller/whislist.dart';
import 'package:electronic_final_project/core/utils/color_constant.dart';
import 'package:electronic_final_project/core/utils/image_constant.dart';
import 'package:electronic_final_project/core/utils/size_utils.dart';
import 'package:electronic_final_project/model/wishlist.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_image.dart';
import 'package:electronic_final_project/widgets/app_bar/appbar_title.dart';
import 'package:electronic_final_project/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Wishlist> wishlists = [];
  bool isFavorite = true;

  @override
  void initState() {
    super.initState();
    fetchWishlist();
  }

  Future<void> fetchWishlist() async {
    try {
      List<Wishlist> fetchedWishlists = await WishlistController().getUserWhishlist();
      setState(() {
        wishlists = fetchedWishlists;
      });
    } catch (error) {
 
      print('Error fetching wishlist: $error');
    }
  }

  Future<void> deleteWishlist(int index) async {
    try {
      await WishlistController().deleteWishlist(wishlists[index].id!); 
      setState(() {
        wishlists.removeAt(index);
      });
      print('Wishlist deleted successfully.');
    } catch (error) {
      print('Error deleting wishlist: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to delete wishlist. Please try again later.'),
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
                            onTapArrowLeft(context);
                          },
                        ),
                        AppbarTitle(
                          text: "My Wishlist",
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
                child: wishlists.isEmpty
                    ? Center(child: Text('No Wishlist found'))
                    : ListView.builder(
  itemCount: wishlists.length,
  itemBuilder: (context, index) {
    Wishlist wishlist = wishlists[index];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 150, 
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2.0,
          child: ListTile(
            leading: wishlist.product != null
                ? Image.network(
                    wishlist.product!.image ?? '',
                    width: 80,
                    height: 80, 
                    fit: BoxFit.cover,
                  )
                : SizedBox.shrink(),
            title: Text(
              wishlist.product?.name ?? 'Unknown Product',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                SizedBox(height: 8), 
                Text(
                  'Additional Details:', 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Price: \$${wishlist.product?.price ?? 0}', 
                  style: TextStyle(color: Colors.grey),
                ),
 
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.orange,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Remove Wishlist'),
                    content: Text('Are you sure you want to remove this wishlist?'),
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
                          deleteWishlist(index);
                        },
                        child: Text('Remove'),
                      ),
                    ],
                  ),
                );
              },
            ),
            onTap: () {
         
            },
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
  void onTapArrowLeft(BuildContext context) {
    Navigator.of(context).pop();
  }

}
