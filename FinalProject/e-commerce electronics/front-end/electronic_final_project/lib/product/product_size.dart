import 'package:electronic_final_project/controller/product.dart';
import 'package:electronic_final_project/model/size.dart';
import 'package:flutter/material.dart';

class SizeProductUI extends StatefulWidget {
  final int productId;
  final Function(SizeProduct) onSizeSelected;

  SizeProductUI({required this.productId, required this.onSizeSelected});

  @override
  _SizeProductUIState createState() => _SizeProductUIState();
}

class _SizeProductUIState extends State<SizeProductUI> {
  late int _selectedSizeIndex;

  @override
  void initState() {
    super.initState();
    _selectedSizeIndex = 0; 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SizeProduct>>(
      future: ProductController().getProductBySize(widget.productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<SizeProduct> sizeProducts = snapshot.data!;
          return SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount: sizeProducts.length,
              itemBuilder: (BuildContext context, int index) {
                final sizeProduct = sizeProducts[index];
                final bool isSelected = index == _selectedSizeIndex;

                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedSizeIndex = index;
                    });
                    widget.onSizeSelected(sizeProduct);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: isSelected ? Colors.orange : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    primary: Colors.grey,
                    minimumSize: Size(64, 64),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        sizeProduct.sizes.toString(),
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Text('No size products found.');
        }
      },
    );
  }
}

