import 'package:loyalty_app/core/app_export.dart';

void showSummaryInvoice(BuildContext context) {
  final productProvider = Provider.of<ProductProvider>(context, listen: false);

  String invoiceData = '';

  invoiceData +=
      'Product Name\tPrice\tQuantity\tSelected Options\tOption Price\tSubtotal\n';

  for (final product in productProvider.selectedProducts
      .where((product) => product.selectedQty > 0)) {
    final selectedOptions =
        productProvider.selectedOptionsMap[product.id] ?? [];
    double totalWithOption = product.subTotal;
    String optionNames = '';
    double optionPrices = 0.0;

    for (final option in selectedOptions) {
      if (option.isSelected) {
        totalWithOption += (option.price ?? 0.0) * product.selectedQty;
        optionNames += '${option.nameEnglish ?? option.nameArabic}, ';
        optionPrices += (option.price ?? 0.0);
      }
    }

    invoiceData +=
        '${product.nameEnglish}\t\$${product.price.toStringAsFixed(2)}\t${product.selectedQty}\t${optionNames.isNotEmpty ? optionNames.substring(0, optionNames.length - 2) : 'None'}\t\$${optionPrices.toStringAsFixed(2)}\t\$${totalWithOption.toStringAsFixed(2)}\n';
  }

  invoiceData +=
      'Total Price:\t\t\t\t\t\$${productProvider.total.toStringAsFixed(2)}';
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Summary Invoice',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Product Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Quantity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Selected Options',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Option Price',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Subtotal',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: productProvider.selectedProducts
                    .where((product) => product.selectedQty > 0)
                    .map((product) {
                  final selectedOptions =
                      productProvider.selectedOptionsMap[product.id] ?? [];
                  double totalWithOption = product.subTotal;
                  String optionNames = '';
                  double optionPrices = 0.0;

                  for (final option in selectedOptions) {
                    if (option.isSelected) {
                      totalWithOption +=
                          (option.price ?? 0.0) * product.selectedQty;
                      optionNames +=
                          '${option.nameEnglish ?? option.nameArabic}, ';
                      optionPrices += (option.price ?? 0.0);
                    }
                  }

                  return DataRow(
                    cells: [
                      DataCell(Text(product.nameEnglish)),
                      DataCell(Text('\$${product.price.toStringAsFixed(2)}')),
                      DataCell(Text('${product.selectedQty}')),
                      DataCell(Text(optionNames.isNotEmpty
                          ? optionNames.substring(0, optionNames.length - 2)
                          : 'None')),
                      DataCell(Text('\$${optionPrices.toStringAsFixed(2)}')),
                      DataCell(Text('\$${totalWithOption.toStringAsFixed(2)}')),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Price:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${productProvider.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                CustomElevatedButton(
                  onPressed: () {
                    confirmOrder(productProvider);
                  },
                  height: 50.v,
                  width: 190.h,
                  text: "Confirm Order",
                  margin: EdgeInsets.only(bottom: 4.v),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  buttonTextStyle: CustomTextStyles.titleMediumSFProText,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SizedBox(
                width: 200,
                height: 100,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoiceData,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

void confirmOrder(ProductProvider productProvider) async {
  try {
    EasyLoading.show(status: 'Creating Order...');

    if (productProvider.selectedProducts.isEmpty ||
        productProvider.total == 0) {
      throw Exception('Invalid product data');
    }

    final List<Map<String, dynamic>> productsWithQty =
        productProvider.selectedProducts
            .map((product) => {
                  'product_id': product.id,
                  'qty': product.selectedQty,
                  'price': product.price,
                })
            .toList();

    final newOrderData = {
      'total': productProvider.total,
      'total_price': productProvider.total,
      'products': productsWithQty,
    };

    await OrderController().create(newOrderData);

    EasyLoading.dismiss();
    EasyLoading.showSuccess("Done");
  } catch (ex) {
    EasyLoading.dismiss();
    EasyLoading.showError(ex.toString());
  }
}
