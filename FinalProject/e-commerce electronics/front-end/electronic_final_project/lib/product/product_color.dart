import 'package:electronic_final_project/controller/product.dart';
import 'package:electronic_final_project/model/color.dart';
import 'package:flutter/material.dart';



class ColorProductUI extends StatefulWidget {
  final int productId;
  final Function(ColorProduct) onColorSelected;

  ColorProductUI({required this.productId, required this.onColorSelected});

  @override
  _ColorProductUIState createState() => _ColorProductUIState();
}

class _ColorProductUIState extends State<ColorProductUI> {
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ColorProduct>>(
      future: ProductController().getProductByColor(widget.productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<ColorProduct> colorProducts = snapshot.data!;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: colorProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  final colorProduct = colorProducts[index];
                  final colorName = colorProduct.colors.toLowerCase();
                  final color = getColorByName(colorName);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColorIndex = index;
                      });
                      widget.onColorSelected(colorProduct);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                        border: Border.all(
                          color: _selectedColorIndex == index
                              ? Colors.orange
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Text('No color products found.');
        }
      },
    );
  }

  Color getColorByName(String colorName) {
    switch (colorName) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'black':
        return Colors.black;
      case 'purple':
        return Colors.purple;
      case 'white':
        return Colors.white;
      case 'pink':
        return Colors.pink;
      case 'gold':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}
