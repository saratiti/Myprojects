import 'dart:typed_data';

import 'package:loyalty_app/controller/api_helper.dart';
import 'package:loyalty_app/model/invoice.dart';

class InvoiceController {
  final ApiHelper _apiHelper = ApiHelper();

Future<List<Invoice>> getUserInvoice() async {
  try {
    var result = await _apiHelper.getRequest("/api/invoices");
    List<dynamic>? data = result['invoices'];
    if (data != null) {
      List<Invoice> invoices = [];
      
      // Construct Invoice objects
      for (var item in data) {
        // Read image bytes asynchronously
        List<Uint8List> imageList = await _apiHelper.getInvoiceImages(item['file_path']);
        
        invoices.add(Invoice(
          invoiceId: item['invoice_id'],
          uploadDate: item['upload_date'],
          filePath: item['file_path'],
          userId: item['user_id'],
          imageBytesList: imageList,
        ));
      }
      
      return invoices;
    } else {
      throw Exception('Failed to fetch user invoices: No data');
    }
  } catch (e) {
    throw Exception('Failed to fetch user invoices: $e');
  }
}
}



