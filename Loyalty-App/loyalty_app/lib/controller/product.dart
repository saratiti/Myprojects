
import 'package:loyalty_app/model/option_menu.dart';
import 'package:loyalty_app/model/product.dart';

import 'api_helper.dart';

class ProductController {


Future<Map<String, dynamic>> getProductWithOptionalMenu(int productId) async {
  final url = '/api/optionMenue/$productId'; 

  try {
    final response = await ApiHelper().getRequest(url);

    if (response != null) {
      final Map<String, dynamic> parsed = response;
      if (parsed.containsKey('product') && parsed.containsKey('optionalMenuItems')) {
        final Product product = Product.fromJson(parsed['product']);
        final List<OptionalMenu> optionalMenuItems = List<OptionalMenu>.from(parsed['optionalMenuItems'].map((item) => OptionalMenu.fromJson(item['options']))); 

        return {
          'product': product,
          'optionalMenuItems': optionalMenuItems,
        };
      } else {
        throw Exception('Response does not contain product or optionalMenuItems');
      }
    } else {
      throw Exception('Failed to load product with optional menu items');
    }
  } catch (error) {
    throw Exception('Error retrieving product with optional menu items: $error');
  }
}


}
