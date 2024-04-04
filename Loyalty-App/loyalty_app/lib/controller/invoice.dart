import 'dart:convert';
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

Future<Map<String, dynamic>> processScannedData(Uint8List imageBytes) async {
  try {
    // Convert image bytes to base64 string
    String base64Image = base64Encode(imageBytes);

    // Send the base64 encoded image to the backend for scanning
    var response = await _apiHelper.postDio(
      "/api/invoices/scan",
      {'image': base64Image},
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Decode the response body JSON string
      Map<String, dynamic> result = json.decode(response.body);
      return result;
    } else {
      // If the request was not successful, throw an exception
      throw Exception('Failed to scan invoice: ${response.reasonPhrase}');
    }
  } catch (e) {
    // Print the error message
    print('Error scanning invoice: $e');
    // Throw an exception to handle the error
    throw Exception('Failed to scan invoice: $e');
  }
}}